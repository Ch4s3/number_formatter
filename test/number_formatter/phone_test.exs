defmodule NumberFormatter.PhoneTest do
  use ExUnit.Case

  doctest NumberFormatter.Phone

  test "a delimiter containing a backslash-digit sequence is inserted literally" do
    assert NumberFormatter.Phone.number_to_phone(1_235_551_234, delimiter: "\\1") ==
             "123\\1555\\11234"
  end
end
