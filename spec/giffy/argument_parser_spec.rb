require "spec_helper"

describe ArgumentParser do
  describe ".parse" do
    context "when calling with -h" do
      it "displays help" do
        output = double('output')
        args = ["-h"]

        expect(output).to receive(:puts)
        begin
          ArgumentParser.parse(args, output)
        rescue SystemExit
          # eat
        end
      end

      it "exits cleanly" do
        output = double('output', :puts => "help dummy")
        args = ["-h"]
        expect { ArgumentParser.parse(args, output) }.to raise_error SystemExit
      end
    end

    context "without an input file" do
      it "raises an error" do
        output = double('output')
        empty_args = []
        missing_i_args = ["-s", "10:24:04", "-t", "2", "cool.gif"]

        expect{ ArgumentParser.parse(empty_args, output) }.to raise_error
        expect{ ArgumentParser.parse(missing_i_args, output) }.to raise_error
      end
    end

    context "with no given output file" do
      it "falls back to the default" do
        output = double('output')
        args = ["-i", "nice.mp4", "-s", "00:01:42", "-t", "3"]
        expect(ArgumentParser.parse(args, output)).to eql(
          { :input_file => "nice.mp4",
            :start_time => "00:01:42",
            :duration => "3",
            :output_file => "animation.gif"
          }
        )
      end
    end
  end
end
