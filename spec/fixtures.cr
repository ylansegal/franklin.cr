require "random/secure"

module Franklin
  struct Library
    def self.fixture
      new("San Francisco Public Library", "https://sfpl.overdrive.com")
    end

    def self.random_fixture
      new(Random::Secure.hex, "http://#{Random::Secure.hex}.com")
    end
  end

  struct Item
    def self.random_fixture(type = "eBook")
      new(Random::Secure.hex, Random::Secure.hex, Random::Secure.hex, type)
    end
  end

  struct Availability
    def self.random_fixture(available_copies = rand(15))
      new(Library.random_fixture, rand(20), available_copies, 0)
    end
  end
end
