require "../spec_helper"

module Franklin
  describe Library do
    name = "The Library Of Alexandria"
    url = "https://alexandria.book"
    subject = Library.new(name, url)

    it "has a name" do
      subject.name.should eq(name)
    end

    it "has a url" do
      subject.url.should eq(url)
    end

    it "is equal if fields are equal" do
      subject.should eq(Library.new(name, url))
    end
  end
end
