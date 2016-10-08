require "yaml"

struct Library
  YAML.mapping(
    name: {
      type: String,
      key: ":name"
    },
    url: {
      type: String,
      key: ":url"
    }
  )

  def initialize(@name, @url)
  end
end
