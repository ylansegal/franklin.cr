require "../spec_helper"

module Franklin
  describe Library do
    subject { Library.new(name, url) }
    let(name) { "The Library Of Alexandria" }
    let(url) { "https://alexandria.book" }

    it "has a name" do
      expect(subject.name).to eq(name)
    end

    it "has a url" do
      expect(subject.url).to eq(url)
    end
  end
end
