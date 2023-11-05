# frozen_string_literal: true

module DeployHoroscope
  class Sign
    # @param sign_ru [String] Ex: 'овен'
    # @param sign [String] Ex: 'aries'
    # @param positive_days [Array<String>]
    # @param neutral_days [Array<String>]
    # @param unfavorable_days [Array<String>]
    # @param actual_date [String] DateTime in '%d/%m/%Y' format
    def initialize(sign_ru, sign, positive_days, neutral_days, unfavorable_days, actual_date)
      @sign_ru = sign_ru
      @sign = sign
      @positive_days = positive_days
      @neutral_days = neutral_days
      @unfavorable_days = unfavorable_days
      @actual_date = actual_date
    end

    # @!method sign_ru
    #   @return [String] Ex: 'овен'
    # @!method sign
    #   @return [String] Ex: 'aries'
    # @!method positive_days
    #   @return [Array<String>]
    # @!method neutral_days
    #   @return [Array<String>]
    # @!method unfavorable_days
    #   @return [Array<String>]
    # @!method actual_date
    #   @return [String] DateTime in '%d/%m/%Y' format
    attr_reader :sign_ru, :sign, :positive_days, :neutral_days, :unfavorable_days, :actual_date

    # @return [Boolean]
    def can_deploy_today?
      today != :unfavorable
    end

    # @return [Symbol] Ex: :positive, :unfavorable, :neutral
    def today
      today = Date.strptime(actual_date, "%d/%m/%Y").day.to_s
      if positive_days.include?(today)
        :positive
      elsif unfavorable_days.include?(today)
        :unfavorable
      else
        :neutral
      end
    end
  end
end
