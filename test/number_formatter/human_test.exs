defmodule NumberFormatter.HumanTest do
  use ExUnit.Case

  doctest NumberFormatter.Human

  test "the Thousand scale kicks in exactly at 1000" do
    assert NumberFormatter.Human.number_to_human(999) == "999.00"
    assert NumberFormatter.Human.number_to_human(1000) == "1.00 Thousand"
  end
end
