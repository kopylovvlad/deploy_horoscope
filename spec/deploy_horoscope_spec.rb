# frozen_string_literal: true

RSpec.describe DeployHoroscope do
  let(:data) do
    YAML.safe_load(
      File.read("./spec/fixtures/data.yml"),
      permitted_classes: [Symbol]
    )
  end

  before do
    allow_any_instance_of(DeployHoroscope::Client).to receive(:parse_data).and_return(data)
    allow(Time).to receive(:now).and_return(Date.strptime("04/11/2023", "%d/%m/%Y"))
  end

  it "has a version number" do
    expect(DeployHoroscope::VERSION).not_to be nil
  end

  describe "#fetch_data" do
    subject { DeployHoroscope.fetch_data }

    it "returns the collection" do
      is_expected.to be_an_instance_of DeployHoroscope::Collection
    end
  end

  describe "Collection" do
    subject { DeployHoroscope.fetch_data }

    describe "#can_deploy_signs" do
      let(:signs) { %i[taurus gemini cancer virgo scorpio sagittarius] }
      it { expect(subject.can_deploy_signs).to eq(signs) }
    end

    describe "#positive_today" do
      let(:signs) { %i[gemini cancer virgo] }

      it { expect(subject.positive_today).to eq(signs) }
    end

    describe "#neutral_today" do
      let(:signs) { %i[taurus scorpio sagittarius] }

      it { expect(subject.neutral_today).to eq(signs) }
    end

    describe "#unfavorable_today" do
      let(:signs) { %i[aries leo libra capricorn aquarius pisces] }

      it { expect(subject.unfavorable_today).to eq(signs) }
    end

    describe "#actual_date" do
      it { expect(subject.actual_date).to eq("04/11/2023") }
    end
  end

  describe "Sign" do
    subject { DeployHoroscope.fetch_data.sign(:virgo) }

    describe "#sign" do
      it { expect(subject.sign).to eq(:virgo) }
    end

    describe "#sign_ru" do
      it { expect(subject.sign_ru).to eq("дева") }
    end

    describe "#positive_days" do
      let(:days) { %w[4 10 20 21 27 29] }

      it { expect(subject.positive_days).to eq(days) }
    end

    describe "#neutral_days" do
      let(:days) { %w[1 8 11 14 18 19 22 28 30] }

      it { expect(subject.neutral_days).to eq(days) }
    end

    describe "#unfavorable_days" do
      let(:days) do
        %w[2 3 5 6 7 9 12 13 15 16 17 23 24 25 26]
      end

      it { expect(subject.unfavorable_days).to eq(days) }
    end

    describe "#can_deploy_today?" do
      it { expect(subject.can_deploy_today?).to eq(true) }
    end

    describe "#today" do
      it { expect(subject.today).to eq(:positive) }
    end
  end
end
