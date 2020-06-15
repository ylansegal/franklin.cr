require "yaml"

module Franklin
  struct Library
    include YAML::Serializable

    property name : String
    property url : String

    def initialize(@name, @url)
    end
  end
end
