defmodule NumberFormatter.CurrencyTest do
  use ExUnit.Case

  doctest NumberFormatter.Currency

  test "a unit containing a backslash-digit sequence is inserted literally" do
    assert NumberFormatter.Currency.number_to_currency(1000, unit: "\\1-") ==
             "\\1-1,000.00"
  end
end
