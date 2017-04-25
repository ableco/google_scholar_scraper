require "test_helper"

class ScraperTest < Minitest::Test
  def setup
    @scraper = GoogleScholarScraper::Scraper.new
  end

  def test_find_article
    RestClient::Request.stub(:execute, File.open("test/support/google_scholar_response_example.html").read) do
      assert_equal @scraper.find_articles(google_scholar_id: "foo").size, 6
    end
  end
end
