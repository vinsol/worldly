defmodule Worldly.CountryTest do
  use ExUnit.Case

  test "all/0" do
    assert Worldly.Country.all == [
      country_andorra,
      country_albania
    ]
  end

  test "with_name/1" do
    assert Worldly.Country.with_name("Albania") == [country_albania]
  end

  test "with_code/1 of length 2" do
    assert Worldly.Country.with_code("AL") == [country_albania]
  end

  test "with_code/1 of length 3" do
    assert Worldly.Country.with_code("ALB") == [country_albania]
  end

  test "with_code/1 of length other than 2 or 3" do
    assert Worldly.Country.with_code("ALBA") == []
  end

  @tag :real_data
  test "real paths working" do
    Application.put_env(:worldly, :data_path, "priv/data")
    assert Worldly.Country.with_code("AL") == [country_albania]
    Application.put_env(:worldly, :data_path, "priv/test_data")
  end

  defp country_andorra do
    %Worldly.Country{alpha_2_code: "AD", alpha_3_code: "AND", common_name: "", has_regions: true, name: "Andorra", numeric_code: "020", official_name: "Principality of Andorra"}
  end

  defp country_albania do
    %Worldly.Country{alpha_2_code: "AL", alpha_3_code: "ALB", common_name: "", has_regions: true, name: "Albania", numeric_code: "008", official_name: "Republic of Albania"}
  end
end
