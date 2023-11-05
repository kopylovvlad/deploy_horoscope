# frozen_string_literal: true

module DeployHoroscope
  class Collection
    # @param signs [Array<Sign>]
    # @param actual_date [String] DateTime in '%d/%m/%Y' format
    def initialize(signs, actual_date)
      @signs = signs
      @actual_date = actual_date
    end

    # @!method signs
    #   @return [Array<Sign>]
    # @!method actual_date
    #   @return [String] DateTime in '%d/%m/%Y' format
    attr_reader :signs, :actual_date

    # @param sign [Symbol] :aries, :taurus, etc
    # @return [Sign]
    # @raise [::DeployHoroscope::Error, ]
    def sign(sign = ::DeployHoroscope::SIGNS.firts)
      raise ::DeployHoroscope::Error, "Undefined sign '#{sign}'" unless SIGNS.values.include?(sign)

      signs.find { |i| i.sign == sign }
    end

    # @param lang [Symbol] :en or :ru
    # @return [Array<Symbols>] Ex: [:aries, :taurus]
    def can_deploy_signs(lang = :en)
      items = signs.reject { |i| i.today == :unfavorable }
      lang == :ru ? items.map(&:sign_ru) : items.map(&:sign)
    end

    # @param lang [Symbol] :en or :ru
    # @return [Array<Symbols>] Ex: [:aries, :taurus]
    def positive_today(lang = :en)
      items = select_by_type(:positive)
      lang == :ru ? items.map(&:sign_ru) : items.map(&:sign)
    end

    # @param lang [Symbol] :en or :ru
    # @return [Array<Symbols>] Ex: [:aries, :taurus]
    def unfavorable_today(lang = :en)
      items = select_by_type(:unfavorable)
      lang == :ru ? items.map(&:sign_ru) : items.map(&:sign)
    end

    # @param lang [Symbol] :en or :ru
    # @return [Array<Symbols>] Ex: [:aries, :taurus]
    def neutral_today(lang = :en)
      items = select_by_type(:neutral)
      lang == :ru ? items.map(&:sign_ru) : items.map(&:sign)
    end

    private

    def select_by_type(type)
      signs.select { |i| i.today == type }
    end
  end
end
