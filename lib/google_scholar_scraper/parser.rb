require_relative "article"

module GoogleScholarScraper
  class Parser
    def initialize(html_response)
      @html_response = html_response
    end

    attr_reader :html_response

    def parse
      # HTML markup example:
      #
      # <tr class="gsc_a_tr">
      #   <td class="gsc_a_t">
      #     <a class="gsc_a_at" href="">The adaptive decision maker</a>
      #     <div class="gs_gray">JW Payne, JR Bettman, EJ Johnson</div>
      #     <div class="gs_gray">Cambridge University Press
      #       <span class="gs_oph">, 1993</span>
      #     </div>
      #   </td>
      #   <td class="gsc_a_c">
      #     <a class="gsc_a_ac" href="">3965</a>
      #   </td>
      #   <td class="gsc_a_y">
      #     <span class="gsc_a_h">1993</span>
      #   </td>
      # </tr>

      # <button id="gsc_bpf_more" class=" gs_btn_smd">
      #   <span class="gs_wr">
      #     <span class="gs_lbl">Show more</span>
      #   </span>
      # </button>

      articles_arr = []
      articles_wrap = html_response.css(".gsc_a_tr")
      return if articles_wrap.count.zero?

      articles_wrap.each do |article|
        h3 = article.css(".gsc_a_at").first
        title = h3.text
        href = h3.attributes["href"]
        link = href.nil? ? nil : href.value
        # the url that scholar provide h is inside scholar. Should be ok or
        # article pdf url
        y = article.css(".gsc_a_y .gsc_a_h").children.first
        year = y.nil? ? nil : y.text.scan(/\d+/).first
        articles_arr << GoogleScholar::Scraper::Article.new(title, link, nil, year)
      end

      articles_arr
    end
  end
end
