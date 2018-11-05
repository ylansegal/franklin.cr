require "../spec_helper"
require "random/secure"

module Franklin
  describe Item do
    title = "Ender's Game"
    author = "Orson Scott Card"
    format = "eBook"

    it "has an id" do
      id = Random::Secure.hex
      subject = Item.new(id, title, author, format)

      subject.id.should eq(id)
    end

    it "has a title" do
      id = Random::Secure.hex
      subject = Item.new(id, title, author, format)

      subject.title.should eq(title)
    end

    it "has an author" do
      id = Random::Secure.hex
      subject = Item.new(id, title, author, format)


      subject.author.should eq(author)
    end

    it "has a format" do
      id = Random::Secure.hex
      subject = Item.new(id, title, author, format)

      subject.author.should eq(author)
    end

    it "can be compared to other items by value" do
      id = Random::Secure.hex
      subject = Item.new(id, title, author, format)

      subject.should_not eq(Item.new(Random::Secure.hex, title, author, format))
      subject.should eq(Item.new(id, title, author, format))
    end
  end
end
