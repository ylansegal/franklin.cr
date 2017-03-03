require "yaml"

module Franklin
  struct Library
    YAML.mapping(
      name: String,
      url: String
    )

    def initialize(@name, @url)
    end
  end
end
