defprotocol NumberFormatter.Conversion do
  @moduledoc "Converts values to formats consumable by NumberFormatter."
  @fallback_to_any false

  @doc "Converts a value to a Float."
  def to_float(value)

  @doc "Converts a value to a Decimal."
  def to_decimal(value)
end

defimpl NumberFormatter.Conversion, for: BitString do
  @moduledoc false

  def to_float(value) do
    case Float.parse(value) do
      {float, ""} -> float
      _ -> raise ArgumentError, "could not convert #{inspect(value)} to float"
    end
  end

  def to_decimal(value) do
    string = String.Chars.to_string(value)

    case Decimal.parse(string, max_digits: 100) do
      {decimal, ""} -> decimal
      _ -> raise ArgumentError, "could not convert #{inspect(value)} to Decimal"
    end
  end
end

defimpl NumberFormatter.Conversion, for: Float do
  @moduledoc false

  def to_float(value), do: value

  def to_decimal(value) do
    Decimal.from_float(value)
  end
end

defimpl NumberFormatter.Conversion, for: Integer do
  @moduledoc false

  def to_float(value), do: value * 1.0

  def to_decimal(value) do
    Decimal.new(value)
  end
end

defimpl NumberFormatter.Conversion, for: Decimal do
  @moduledoc false

  def to_float(value) do
    {float, _} =
      value
      |> Decimal.to_string()
      |> Float.parse()

    float
  end

  def to_decimal(value) do
    value
  end
end
