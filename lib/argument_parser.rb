require 'optparse'

class ArgumentParser

  def self.parse(args, output)
    options = {}
    opt_parser = OptionParser.new do |opts|
      opts.banner = "
      Usage: giffy -i=INPUT [options] [animation.gif]
      Example: giffy -i awesome.mp4 -s 00:05:09 -t cool.gif

      Options:
      "

      # defaults
      options[:start_time]  = "00:00:00"
      options[:duration]    = 5
      options[:output_file] = "animation.gif"

      opts.on("-i", "--args FILE", "args_exampe.mp4") do |i|
        options[:args_file] = i
      end

      opts.on("-s", "--start [HH:MM:SS]",
              "start position; default=00:00:00") do |s|
        options[:start_time] = s
      end

      opts.on("-t", "--duration [SECONDS]", "duration; default=5") do |t|
        options[:duration] = t
      end

      opts.on("-h", "--help", "display this message") do
        output.puts opts
        exit
      end
    end

    opt_parser.parse!(args)

    unless options[:args_file]
      raise "Please supply an args file: '-i YOUR_FILE.mp4'"
    end

    if ARGV.length > 0
      options[:output_file] = ARGV.shift
    end

    options
  end
end
