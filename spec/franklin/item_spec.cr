require "../spec_helper"
require "random/secure"

module Franklin
  describe Item do
    subject { Item.new(id, title, author, format) }
    let(:id) { Random::Secure.hex }
    let(:title) { "Ender's Game" }
    let(:author) { "Orson Scott Card" }
    let(:format) { "eBook" }

    it "has an id" do
      expect(subject.id).to eq(id)
    end

    it "has a title" do
      expect(subject.title).to eq(title)
    end

    it "has an author" do
      expect(subject.author).to eq(author)
    end

    it "has a format" do
      expect(subject.format).to eq(format)
    end

    it "can be compared to other items by value" do
      expect(subject).not_to eq(described_class.new(Random::Secure.hex, title, author, format))
      expect(subject).to eq(described_class.new(id, title, author, format))
    end
  end
end
