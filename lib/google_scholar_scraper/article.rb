module GoogleScholarScraper
  # Represents an article from Google Scholar
  class Article
    attr_accessor :title, :link, :description, :year

    def initialize(title, link, description, year)
      @title = title
      @link = link
      @description = description
      @year = year
    end
  end
end
