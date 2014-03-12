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
  end
end
