class Splitter
  def self.make_pngs(opts)
    `ffmpeg -ss #{opts[:start_time]} -t #{opts[:duration]} -i #{opts[:input_file]} output%03d.png`
  end
end
