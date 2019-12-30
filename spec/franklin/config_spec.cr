require "../spec_helper"
require "yaml"

module Franklin
  describe Config do
    library = Library.new("Alexandria Library", "http://alexandria.book")
    default_type = "eBook"
    yaml = <<-END
      ---
      libraries:
        - name: #{library.name}
          url: #{library.url}
      default_type: #{default_type}
      END

    subject = Config.from_yaml(yaml)

    context "YAML deserilization" do
      it "maps default_type" do
        subject.default_type.should eq(default_type)
      end

      it "maps libraries" do
        subject.libraries.should eq([library])
      end
    end

    context "YAML deserialization without default type" do
      yaml = <<-END
        ---
        libraries:
          - name: #{library.name}
            url: #{library.url}
        END

      it "maps default_default" do
        subject = Config.from_yaml(yaml)

        subject.default_type.should eq(nil)
      end

      it "maps libraries" do
        subject = Config.from_yaml(yaml)

        subject.libraries.should eq([library])
      end
    end
  end
end
