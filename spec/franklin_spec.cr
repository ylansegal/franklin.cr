require "./spec_helper"

describe Franklin do
  it "has a version number" do
    expect(Franklin::VERSION).not_to be_nil
  end

  describe ".run" do
    let(:example_config_path) { File.join(__DIR__, "example_franklin_config.yml") }
    let(:test_connection) { Cossack::TestConnection.new.tap { |con|
        con.stub_get("/search", {200, File.read("spec/seveneves_search.html")})
      }
    }

    it "integrates end-to-end" do
      expect {
        Franklin.run("Seveneves",
                     config_path: example_config_path,
                     filter: nil,
                     io: IO::Memory.new,
                     connection: test_connection)
      }.not_to raise_error
    end
  end
end
