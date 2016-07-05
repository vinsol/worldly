defmodule Worldly.LocaleTest do
  use ExUnit.Case

  test "set_locale_data/3 for Country" do
    country = %Worldly.Country{alpha_2_code: "AD", alpha_3_code: "AND", numeric_code: "020"}
    assert country.name == ""
    assert country.official_name == ""
    assert country.common_name == ""

    country_with_locale_data = Worldly.Locale.set_locale_data(country, 'country')
    assert country_with_locale_data.name == "Andorra"
    assert country_with_locale_data.official_name == "Principality of Andorra"
    assert country_with_locale_data.common_name == ""
  end

  test "set_locale_data/3 for region" do
    region = %Worldly.Region{code: '01', type: "county", parent_file_path: "al"}
    assert region.name == ""

    region_with_locale_data = Worldly.Locale.set_locale_data(region, 'region')
    assert region_with_locale_data.name == "Berat"
  end

  test "set_locale_data/3 for Country when no locale found" do
    country = %Worldly.Country{alpha_2_code: "IN", alpha_3_code: "IND", numeric_code: "356"}
    assert country.name == ""
    assert country.official_name == ""
    assert country.common_name == ""

    assert_raise MatchError, fn -> Worldly.Locale.set_locale_data(country, 'country') end
  end

  test "set_locale_data/3 for region when no locale found for country" do
    region = %Worldly.Region{code: '01', type: "state", parent_file_path: "in"}
    assert region.name == ""

    exception = try do
      Worldly.Locale.set_locale_data(region, 'region')
    catch
      {:yamerl_exception, a} -> a
    end
    [{error, _, _, _, _, _, _, _}] = exception
    assert error == :yamerl_parsing_error
  end

  test "set_locale_data/3 for region when no locale found for region" do
    region = %Worldly.Region{code: '99', type: "state", parent_file_path: "al"}
    assert region.name == ""

    assert_raise MatchError, fn -> Worldly.Locale.set_locale_data(region, 'region') end
  end
end
