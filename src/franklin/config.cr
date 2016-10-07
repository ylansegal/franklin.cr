require "./library"
require "yaml"

class Config
  YAML.mapping(
    libraries: Array(Library),
    default_type: String
  )
end
