# ![LendingHome](https://cloud.githubusercontent.com/assets/2419/19467866/7efa93a8-94c8-11e6-93e7-4375dbb8a7bc.png) active_record-updated_at
[![Code Climate](https://codeclimate.com/github/LendingHome/active_record-updated_at/badges/gpa.svg)](https://codeclimate.com/github/LendingHome/active_record-updated_at) [![Coverage](https://codeclimate.com/github/LendingHome/active_record-updated_at/badges/coverage.svg)](https://codeclimate.com/github/LendingHome/active_record-updated_at) [![Gem Version](https://badge.fury.io/rb/active_record-updated_at.svg)](http://badge.fury.io/rb/active_record-updated_at)

> Touch `updated_at` by default with calls to `update_column(s)` and `update_all`

## Installation

Add this gem to the project `Gemfile`.

```ruby
gem "active_record-updated_at"
```

## Usage

The default `ActiveRecord` behavior does not touch `updated_at` when the following are called:

* `ActiveRecord::Base#update_column`
* `ActiveRecord::Base#update_columns`
* `ActiveRecord::Relation#update_all`

We **rarely ever have a case to modify data WITHOUT touching `updated_at`** so this gem enables the touching behavior by default. For those rare occasions that we don't want the touching we can wrap these calls in a `disable` block explicitly:

```ruby
ActiveRecord::UpdatedAt.disable { User.update_all(role: "member") }
```

**If `updated_at` is explicitly specified then the UPDATE query is not modified**.

```ruby
# This touches `updated_at` with `Time.current`
User.update_all(role: "member")

# This sets `updated_at` to `1.day.ago`
User.update_all(role: "member", updated_at: 1.day.ago)

# This sets `updated_at` to `NULL`
User.update_all(role: "member", updated_at: nil)

# This doesn't touch `updated_at`
ActiveRecord::UpdatedAt.disable { User.update_all(role: "member") }
```

## Testing

```bash
bundle exec rspec
```

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so we don't break it in a future version unintentionally.
* Commit, do not mess with the version or history.
* Open a pull request. Bonus points for topic branches.

## Authors

* [Sean Huber](https://github.com/shuber)

## License

[MIT](https://github.com/lendinghome/active_record-updated_at/blob/master/LICENSE) - Copyright © 2016 LendingHome
