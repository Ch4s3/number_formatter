defmodule NumberFormatterTest.UsesNumberFormatter do
  use NumberFormatter

  def currency(number), do: number_to_currency(number)
  def delimited(number), do: number_to_delimited(number)
  def phone(number), do: number_to_phone(number)
  def percentage(number, options), do: number_to_percentage(number, options)
  def human(number), do: number_to_human(number)
end

defmodule NumberFormatterTest do
  use ExUnit.Case

  alias NumberFormatterTest.UsesNumberFormatter

  describe "use NumberFormatter" do
    test "imports NumberFormatter.Currency" do
      assert UsesNumberFormatter.currency(1000) == "$1,000.00"
    end

    test "imports NumberFormatter.Delimit" do
      assert UsesNumberFormatter.delimited(12_345_678) == "12,345,678.00"
    end

    test "imports NumberFormatter.Phone" do
      assert UsesNumberFormatter.phone(1_235_551_234) == "123-555-1234"
    end

    test "imports NumberFormatter.Percentage" do
      assert UsesNumberFormatter.percentage(100, precision: 0) == "100%"
    end

    test "imports NumberFormatter.Human" do
      assert UsesNumberFormatter.human(1234) == "1.23 Thousand"
    end
  end
end
