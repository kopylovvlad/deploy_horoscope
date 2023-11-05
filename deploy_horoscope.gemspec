# frozen_string_literal: true

require_relative "lib/deploy_horoscope/version"

Gem::Specification.new do |spec|
  spec.name = "deploy_horoscope"
  spec.version = DeployHoroscope::VERSION
  spec.authors = ["kopylovvlad"]
  spec.email = ["kopylov.vlad@gmail.com"]

  spec.summary = "Fetch the data from deployhoroscope.ru"
  spec.description = "The list of the most favorable calendar dates for deploying to production for all zodiac signs"
  spec.homepage = "https://github.com/kopylovvlad/deploy_horoscope"
  spec.license = "MPL 2.0"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "nokogiri"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
