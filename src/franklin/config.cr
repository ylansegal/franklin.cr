require "./library"
require "yaml"

class Config
  DEFAULT_FILE_LOCATION = File.join(ENV["HOME"], ".franklin")

  YAML.mapping(
    libraries: {
      type: Array(Library),
      key: ":libraries"
    },
    default_type: {
      type: String,
      key: ":default_type"
    }
  )

  def self.from_file(file : String = DEFAULT_FILE_LOCATION)
    from_yaml(File.read(file))
  end
end
