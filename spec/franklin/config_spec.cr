require "../spec_helper"
require "yaml"

module Franklin
  describe Config do
    subject { Config.from_yaml(yaml) }
    let(yaml) {
      <<-END
      ---
      libraries:
        - name: #{library.name}
          url: #{library.url}
      default_type: #{default_type}
      END
     }
    let(library) { Library.new("Alexandria Library", "http://alexandria.book") }
    let(default_type) { "eBook" }

    context "YAML deserilization" do
      it "maps default_type" do
        expect(subject.default_type).to eq(default_type)
      end

      it "maps libraries" do
        expect(subject.libraries).to eq([library])
      end
    end

    context "YAML deserialization without default type" do
      let(yaml) {
        <<-END
        ---
        libraries:
          - name: #{library.name}
            url: #{library.url}
        END
       }

      it "maps default_default" do
        expect(subject.default_type).to eq(nil)
      end

      it "maps libraries" do
        expect(subject.libraries).to eq([library])
      end
    end
  end
end
