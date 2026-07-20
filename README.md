# NumberFormatter

[![Build Status](https://github.com/Ch4s3/number_formatter/actions/workflows/ci.yml/badge.svg)](https://github.com/Ch4s3/number_formatter/actions/workflows/ci.yml)
[![Inline docs](http://inch-ci.org/github/Ch4s3/number_formatter.svg?branch=master)](http://inch-ci.org/github/Ch4s3/number_formatter)
[![Coverage Status](https://coveralls.io/repos/github/Ch4s3/number_formatter/badge.svg?branch=master)](https://coveralls.io/github/Ch4s3/number_formatter?branch=master)
[![Module Version](https://img.shields.io/hexpm/v/number_formatter.svg)](https://hex.pm/packages/number_formatter)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/number_formatter/)
[![Total Download](https://img.shields.io/hexpm/dt/number_formatter.svg)](https://hex.pm/packages/number_formatter)
[![License](https://img.shields.io/hexpm/l/number_formatter.svg)](https://github.com/Ch4s3/number_formatter/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/Ch4s3/number_formatter.svg)](https://github.com/Ch4s3/number_formatter/commits/master)


`NumberFormatter` is an [Elixir](https://github.com/elixir-lang/elixir) library which
provides functions to convert numbers into a variety of different formats.
Ultimately, it aims to be a partial clone of
[ActionView::Helpers::NumberHelper](http://api.rubyonrails.org/classes/ActionView/Helpers/NumberHelper.html)
from Rails.

```elixir
NumberFormatter.Currency.number_to_currency(2034.46)
"$2,034.46"

NumberFormatter.Phone.number_to_phone(1112223333, area_code: true, country_code: 1)
"+1 (111) 222-3333"

NumberFormatter.Percentage.number_to_percentage(100, precision: 0)
"100%"

NumberFormatter.Human.number_to_human(1234)
"1.23 Thousand"

NumberFormatter.Delimit.number_to_delimited(12345678)
"12,345,678"
```

## Installation

Get it from Hex:

```elixir
defp deps do
  [{:number_formatter, "~> 1.0"}]
end
```

Then run `mix deps.get`.

## Usage

If you want to import all of the functions provided by `NumberFormatter`, simply `use`
it in your module:

```elixir
defmodule MyModule do
  use NumberFormatter
end
```

More likely, you'll want to import the functions you want from one of
`NumberFormatter`'s submodules.

```elixir
defmodule MyModule do
  import NumberFormatter.Currency
end
```

See the [Hex documentation](http://hexdocs.pm/number_formatter/) for more information
about the modules provided by `NumberFormatter`.

## License
MIT. See [LICENSE](https://github.com/Ch4s3/number_formatter/blob/master/LICENSE) for more details.
