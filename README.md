# Nicetitle

Nicetitle is an implementation of [John Gruber's TitleCase.pl](https://daringfireball.net/2008/08/title_case_update).

The rule set is:

- Small words such as "a", "an", and "but" are not capitalized:
  - except for the word "is";
  - except if the previous word ended with a colon.
- The first and last words are always capitalized, even if they're small words.
- Words starting with `(`, `_`, `'`, or `"` are capitalized e.g. `__foo` becomes `__Foo`.
- Words starting with a dash, or words interspersed with dashes, are capitalized after every dash e.g. `-Foo-bar` becomes `-Foo-Bar`.
- Words interspersed with slashes are capitalized "between" every slash e.g. `foo/bar` becomes `Foo/Bar`.
- Words starting with a slash are not capitalized.
- URLs are not capitalized.
- Words containing capitals other than the first character are not capitalized e.g. `iOS` remains untouched.
- Words containing dots are not capitalized.
- All caps sentences are down-cased before applying above mentioned rules.

Check out the [test cases](https://github.com/evaneykelen/nicetitle/test/nicetitle_test.rb) for a detailed overview.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nicetitle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nicetitle

## Usage

Calling

`Nicetitle::Titlecase.titlecase('What am I reading/listing/applying these days?')`

outputs

`What Am I Reading/Listing/Applying These Days?`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/evaneykelen/nicetitle.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Similar projects

I've written [an article](https://www.msgtrail.com/articles/20190525-1530-title-casing-is-harder-than-i-thought/) about title casing. This article mentions the following similar projects:

- https://daringfireball.net/2008/08/title_case_update
- https://github.com/samsouder/titlecase
- https://github.com/granth/titleize
