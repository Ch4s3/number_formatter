defmodule NumberFormatter.Human do
  @moduledoc """
  Provides functions for converting numbers into more human readable strings.
  """

  import NumberFormatter.Delimit, only: [number_to_delimited: 2]

  @doc """
  Formats and labels a number with the appropriate English word.

  ## Examples

      iex> NumberFormatter.Human.number_to_human(nil)
      nil

      iex> NumberFormatter.Human.number_to_human(123)
      "123.00"

      iex> NumberFormatter.Human.number_to_human(1234)
      "1.23 Thousand"

      iex> NumberFormatter.Human.number_to_human(999001)
      "999.00 Thousand"

      iex> NumberFormatter.Human.number_to_human(1234567)
      "1.23 Million"

      iex> NumberFormatter.Human.number_to_human(1234567890)
      "1.23 Billion"

      iex> NumberFormatter.Human.number_to_human(1234567890123)
      "1.23 Trillion"

      iex> NumberFormatter.Human.number_to_human(1234567890123456)
      "1.23 Quadrillion"

      iex> NumberFormatter.Human.number_to_human(1234567890123456789)
      "1,234.57 Quadrillion"

      iex> NumberFormatter.Human.number_to_human(Decimal.new("5000.0"))
      "5.00 Thousand"

      iex> NumberFormatter.Human.number_to_human(~c"charlist")
      ** (ArgumentError) number must be a float, integer or implement `NumberFormatter.Conversion` protocol, was ~c"charlist"

  """
  @spec number_to_human(NumberFormatter.t(), Keyword.t()) :: String.t()
  def number_to_human(number, options \\ [])
  def number_to_human(nil, _options), do: nil

  def number_to_human(number, options) when not is_map(number) do
    if NumberFormatter.Conversion.impl_for(number) do
      number
      |> NumberFormatter.Conversion.to_decimal()
      |> number_to_human(options)
    else
      raise ArgumentError,
            "number must be a float, integer or implement `NumberFormatter.Conversion` protocol, was #{inspect(number)}"
    end
  end

  def number_to_human(number, options) do
    cond do
      Decimal.compare(number, ~d(999)) == :gt && Decimal.compare(number, ~d(1_000_000)) == :lt ->
        delimit(number, ~d(1_000), "Thousand", options)

      Decimal.compare(number, ~d(1_000_000)) in [:gt, :eq] and
          Decimal.compare(number, ~d(1_000_000_000)) == :lt ->
        delimit(number, ~d(1_000_000), "Million", options)

      Decimal.compare(number, ~d(1_000_000_000)) in [:gt, :eq] and
          Decimal.compare(number, ~d(1_000_000_000_000)) == :lt ->
        delimit(number, ~d(1_000_000_000), "Billion", options)

      Decimal.compare(number, ~d(1_000_000_000_000)) in [:gt, :eq] and
          Decimal.compare(number, ~d(1_000_000_000_000_000)) == :lt ->
        delimit(number, ~d(1_000_000_000_000), "Trillion", options)

      Decimal.compare(number, ~d(1_000_000_000_000_000)) in [:gt, :eq] ->
        delimit(number, ~d(1_000_000_000_000_000), "Quadrillion", options)

      true ->
        number_to_delimited(number, options)
    end
  end

  @doc """
  Adds ordinal suffix (st, nd, rd or th) for the number
  ## Examples

      iex> NumberFormatter.Human.number_to_ordinal(3)
      "3rd"

      iex> NumberFormatter.Human.number_to_ordinal(1)
      "1st"

      iex> NumberFormatter.Human.number_to_ordinal(46)
      "46th"

      iex> NumberFormatter.Human.number_to_ordinal(442)
      "442nd"

      iex> NumberFormatter.Human.number_to_ordinal(4001)
      "4001st"

  """
  @spec number_to_ordinal(NumberFormatter.t()) :: String.t()
  def number_to_ordinal(number) when is_integer(number) do
    sfx = ~w(th st nd rd th th th th th th)

    Integer.to_string(number) <>
      case rem(number, 100) do
        11 -> "th"
        12 -> "th"
        13 -> "th"
        _ -> Enum.at(sfx, rem(number, 10))
      end
  end

  defp sigil_d(number, _modifiers) do
    number
    |> String.replace("_", "")
    |> String.to_integer()
    |> Decimal.new()
  end

  defp delimit(number, divisor, label, options) do
    number =
      number
      |> Decimal.div(divisor)
      |> number_to_delimited(options)

    number <> " " <> label
  end
end
