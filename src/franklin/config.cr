require "./library"
require "yaml"

module Franklin
  class Config
    DEFAULT_FILE_LOCATION = File.join(ENV["HOME"], ".franklin")

    YAML.mapping(
      libraries: Array(Library),
      default_type: {
        type: String,
        nilable: true
      }
    )

    def self.from_file(file : String | Nil = nil)
      file ||= DEFAULT_FILE_LOCATION
      from_yaml(File.read(file))
    end
  end
end
