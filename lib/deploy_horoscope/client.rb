# frozen_string_literal: true

module DeployHoroscope
  class Client
    DOMAIN = "deployhoroscope.ru"

    # @raise [DeployHoroscope::Error]
    # @return [DeployHoroscope::Collection]
    def fetch
      today_date = Time.now
      collection = parse_data.map do |i|
        Sign.new(
          i[:sign_ru],
          i[:sign],
          i[:positive_days],
          i[:neutral_days],
          i[:unfavorable_days],
          today_date.strftime("%d/%m/%Y")
        )
      end
      Collection.new(collection, today_date.strftime("%d/%m/%Y"))
    end

    private

    def parse_data
      url = URI.parse("https://#{DOMAIN}/")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == "https")
      request = Net::HTTP::Get.new(url.request_uri)
      response = http.request(request)

      if response.code != "200"
        raise ::DeployHoroscope::Error,
              "Request to '#{DOMAIN}' failed with status code: #{response.code}"
      end

      doc = Nokogiri::HTML(response.body)
      data = []
      doc.css("tbody tr").each do |row|
        cells = row.css("td")
        sign_ru = cells[0].text.downcase.strip
        data << {
          sign_ru: sign_ru,
          sign: ::DeployHoroscope::SIGNS[sign_ru],
          positive_days: cells[1].css("span").map(&:text).map(&:strip),
          neutral_days: cells[2].css("span").map(&:text).map(&:strip),
          unfavorable_days: cells[3].css("span").map(&:text).map(&:strip)
        }
      end
      data
    end
  end
end
