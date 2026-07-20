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

  # Descending order matters: the first scale that `number` is at least as
  # large as wins. Below the smallest scale (1_000), the number is left as a
  # plain delimited value with no label.
  @scales [
    {1_000_000_000_000_000, "Quadrillion"},
    {1_000_000_000_000, "Trillion"},
    {1_000_000_000, "Billion"},
    {1_000_000, "Million"},
    {1_000, "Thousand"}
  ]

  def number_to_human(%Decimal{} = number, options) do
    case Enum.find(@scales, fn {threshold, _label} -> at_least?(number, threshold) end) do
      {threshold, label} -> delimit(number, Decimal.new(threshold), label, options)
      nil -> number_to_delimited(number, options)
    end
  end

  def number_to_human(number, options) do
    if NumberFormatter.Conversion.impl_for(number) do
      number
      |> NumberFormatter.Conversion.to_decimal()
      |> number_to_human(options)
    else
      raise ArgumentError,
            "number must be a float, integer or implement `NumberFormatter.Conversion` protocol, was #{inspect(number)}"
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

  defp at_least?(number, threshold) do
    Decimal.compare(number, Decimal.new(threshold)) in [:gt, :eq]
  end

  defp delimit(number, divisor, label, options) do
    number =
      number
      |> Decimal.div(divisor)
      |> number_to_delimited(options)

    number <> " " <> label
  end
end
