module Franklin
  struct Library
    def self.fixture
      new("San Francisco Public Library", "https://sfpl.overdrive.com")
    end

    def self.random_fixture
      new(SecureRandom.hex, "http://#{SecureRandom.hex}.com")
    end
  end
end
