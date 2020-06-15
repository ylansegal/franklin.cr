require "./library"
require "yaml"

module Franklin
  class Config
    include YAML::Serializable

    DEFAULT_FILE_LOCATION = File.join(ENV["HOME"], ".franklin")

    property libraries : Array(Library)
    property default_type : String? = nil

    def self.from_file(file : String | Nil = nil)
      file ||= DEFAULT_FILE_LOCATION
      from_yaml(File.read(file))
    end
  end
end
