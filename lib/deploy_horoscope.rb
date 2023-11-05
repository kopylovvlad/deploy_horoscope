# frozen_string_literal: true

require "nokogiri"
require "net/http"
require "uri"
require "date"

require_relative "deploy_horoscope/client"
require_relative "deploy_horoscope/collection"
require_relative "deploy_horoscope/sign"
require_relative "deploy_horoscope/version"

module DeployHoroscope
  class Error < StandardError; end

  SIGNS = {
    "овен" => :aries,
    "телец" => :taurus,
    "близнецы" => :gemini,
    "рак" => :cancer,
    "лев" => :leo,
    "дева" => :virgo,
    "весы" => :libra,
    "скорпион" => :scorpio,
    "стрелец" => :sagittarius,
    "козерог" => :capricorn,
    "водолей" => :aquarius,
    "рыбы" => :pisces
  }.freeze

  class << self
    def fetch_data
      Client.new.fetch
    end
  end
end
