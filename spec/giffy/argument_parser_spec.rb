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
  end
end
