class Mkgif

  def self.call(options)
    Dir.mkdir("giftemp")
    Dir.chdir("giftemp")

    self.capture_frames(options)

    all_pngs = Dir.glob("*.{png}")

    pngs = Mkgif.cull(all_pngs)
    self.convert_to_gifs(pngs)
    self.animate(options)
    self.clean_up(options)
  end

  def self.capture_frames(options)
    begin
      puts "\ncapturing frames..."
      `ffmpeg -loglevel error -ss #{options[:start_time]} -t #{options[:duration]} -i #{options[:input_file]} output%03d.png`
    rescue
      raise "Maybe you don't have ffmpeg installed?"
    end
  end

  def self.cull(pngs)
    get_last_digit = lambda do |file_name|
      begin
        /(\d{3})/.match(file_name)[1][-1].to_i
      rescue
      end
    end

    every_third = Proc.new do |file_name|
      begin
        last_digit = get_last_digit.call(file_name)
        last_digit == 1 || last_digit == 4 || last_digit == 7
      rescue
      end
    end

    every_other = Proc.new do |file_name|
      begin
        last_digit = get_last_digit.call(file_name)
        last_digit.odd?
      rescue
      end
    end

    puts "culling frames to reduce file size..."
    pngs.count > 70 ? pngs.select(&every_third) : pngs.select(&every_other)
  end

  def self.convert_to_gifs(pngs)
    begin
      pngs.each_with_index do |file_name, counter|
        puts "converting frame #{counter + 1} of #{pngs.count} to gif..."
        `convert #{file_name} #{File.basename(file_name, ".png")}.gif`
      end
    rescue
      puts "maybe you don't have imagemagick installed?
            please install imagemagick."
    end
  end

  def self.animate(options)
    gifs = Dir.glob("*.{gif}")

    puts "animating..."
    begin
      `convert -delay 10 #{gifs.join(' ')} -loop 0 #{options[:output_file]}`
    rescue
      puts "there was an error during conversion"
    end

    puts "optimizing..."
    begin
      `convert -layers Optimize #{options[:output_file]} optimized.gif`
    rescue
      puts "there was an error during optimization"
    end

    `mv optimized.gif #{options[:output_file]}`
  end

  def self.clean_up(options)
    puts "cleaning up..."
    `mv #{options[:output_file]} ..`
    Dir.chdir("..")
    `rm -rf ./giftemp`
  end
end
