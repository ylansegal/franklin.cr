require "../spec_helper"

module Franklin
  describe Search do
    library = Library.fixture
    subject = Search.new(library)
    search_terms = "Prelude to Foundation"

    context "#perform" do
      # These results where known to be accurate when this test was recorded.
      # To update test, modify the contents of spec/*_search.html
      response_body = File.read("spec/prelude_to_foundation_search.html")

      it "returns expected results" do
        WebMock.reset
        WebMock.stub(:get, "#{library.url}/search?query=Prelude+to+Foundation")
               .to_return(status: 200, body: response_body)

        results = subject.perform(search_terms)
        items = results.keys


        items.map(&.format).sort.should eq(["eBook", "Audiobook"].sort)
        items.map(&.title).first.should match(/#{search_terms}/)
        items.map(&.author).first.should eq("Isaac Asimov")
      end

      context "when unreadable json is returned from server" do
        response_body = File.read("spec/bad_search.html")

        it "returns empty results" do
          WebMock.reset
          WebMock.stub(:get, "#{library.url}/search?query=Prelude+to+Foundation")
                 .to_return(status: 200, body: response_body)

          subject.perform(search_terms).empty?.should be_true
        end
      end
    end

    context "search_url" do
      it "appends the search path and query" do
        search_url = subject.search_url(search_terms)
        search_url.should eq("#{library.url}/search?query=Prelude+to+Foundation")
      end

      context "when a libarary contains an ending /" do
        url = "https://alexandria.org/"
        expected_url = "https://alexandria.org/search?query=Prelude+to+Foundation"
        library = Library.new("Library Of Alexandria", url)

        it "handles setting the path without repeating /" do
          subject = Search.new(library)
          search_url = subject.search_url(search_terms)

          search_url.should eq(expected_url)
        end
      end
    end
  end
end
