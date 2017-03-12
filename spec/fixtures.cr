require "secure_random"

module Franklin
  struct Library
    def self.fixture
      new("San Francisco Public Library", "https://sfpl.overdrive.com")
    end

    def self.random_fixture
      new(SecureRandom.hex, "http://#{SecureRandom.hex}.com")
    end
  end

  struct Item
    def self.random_fixture(type = "eBook")
      new(SecureRandom.uuid, SecureRandom.hex, SecureRandom.hex, type)
    end
  end

  struct Availability
    def self.random_fixture
        new(Library.random_fixture, rand(20), rand(15), 0)
      end
  end
end
