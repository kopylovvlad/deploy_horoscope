# DeployHoroscope

When it's best to deploy to production? You can see the dates in https://deployhoroscope.ru/ The information is addressed to those who are planning to deploy to production in the near future. Especially for the resource an astrologer has calculated the most favorable calendar dates for this procedure for all zodiac signs.

## Installation

```
gem install deploy_horoscope
```

## Usage

To fetch data from https://deployhoroscope.ru/ run

```ruby
collection = DeployHoroscope.fetch_data
# DeployHoroscope::Collection

# Collection's API:

collection.can_deploy_signs
# [:taurus, :gemini, :cancer, :virgo, :scorpio, :sagittarius]
collection.positive_today
# [:gemini, :cancer, :virgo]
collection.neutral_today
# [:taurus, :scorpio, :sagittarius]
collection.unfavorable_today
# [:aries, :leo, :libra, :capricorn, :aquarius, :pisces]

# You can get data for one sign
virgo = collection.sign(:virgo)
# #<DeployHoroscope::Sign:0x00007f9b4c148400
#  @actual_date="04/11/2023",
#  @neutral_days=["1", "8", "11", "14", "18", "19", "22", "28", "30"],
#  @positive_days=["4", "10", "20", "21", "27", "29"],
#  @sign=:virgo,
#  @sign_ru="дева",
#  @unfavorable_days=["2", "3", "5", "6", "7", "9", "12", "13", "15", "16", "17", "23", "24", "25", "26"]>

# Sign's API:

virgo.can_deploy_today?
# true
virgo.today
# :positive

# The data is cached you can see the date when data was fetched

collection.actual_date
# "04/11/2023"
virgo.actual_date
# "04/11/2023"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kopylovvlad/deploy_horoscope. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/kopylovvlad/deploy_horoscope/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [Mozilla Public License 2.0](https://choosealicense.com/licenses/mpl-2.0/).

## Code of Conduct

Everyone interacting in the DeployHoroscope project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/deploy_horoscope/blob/master/CODE_OF_CONDUCT.md).

## TODO

* Write CLI
