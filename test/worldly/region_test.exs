defmodule Worldly.RegionTest do
  use ExUnit.Case

  describe "regions_for/1" do
    setup do
      country_with_nested_regions = Worldly.Country.with_name("Albania") |> List.first
      country_with_regions = Worldly.Country.with_code("AD") |> List.first
      {:ok, country_with_regions: country_with_regions, country_with_nested_regions: country_with_nested_regions}
    end

    test "exists?/1 for no nested regions", %{country_with_regions: country} do
      assert Worldly.Region.exists?(country)

      r = Worldly.Region.regions_for(country) |> List.first
      refute Worldly.Region.exists?(r)
    end

    test "exists?/1 for nested regions", %{country_with_nested_regions: country} do
      assert Worldly.Region.exists?(country)

      r = Worldly.Region.regions_for(country) |> List.first
      assert Worldly.Region.exists?(r)

      r = Worldly.Region.regions_for(r) |> List.first
      refute Worldly.Region.exists?(r)
    end

    test "regions_for/1 for no nested regions", %{country_with_regions: country} do
      regions = Worldly.Region.regions_for(country)
      assert regions == country_with_regions_data

      r = regions |> List.first
      regions = Worldly.Region.regions_for(r)
      assert regions == []
    end

    test "regions_for/1 with nested regions", %{country_with_nested_regions: country} do
      regions = Worldly.Region.regions_for(country)
      assert regions == country_with_nested_regions_data

      r = regions |> List.first
      regions = Worldly.Region.regions_for(r)
      assert regions == regions_for_albania_berat

      r = regions |> List.first
      regions = Worldly.Region.regions_for(r)
      assert regions == []
    end
  end

  defp country_with_regions_data do
    [
      %Worldly.Region{code: '02', name: "Canillo", parent_code: "AD", type: 'parish', parent_file_path: "ad"},
      %Worldly.Region{code: '03', name: "Encamp", parent_code: "AD", type: 'parish', parent_file_path: "ad"},
      %Worldly.Region{code: '04', name: "La Massana", parent_code: "AD", type: 'parish', parent_file_path: "ad"},
      %Worldly.Region{code: '05', name: "Ordino", parent_code: "AD", type: 'parish', parent_file_path: "ad"},
      %Worldly.Region{code: '06', name: "Sant Julià de Lòria", parent_code: "AD", type: 'parish', parent_file_path: "ad"},
      %Worldly.Region{code: '07', name: "Andorra la Vella", parent_code: "AD", type: 'parish', parent_file_path: "ad"},
      %Worldly.Region{code: '08', name: "Escaldes-Engordany", parent_code: "AD", type: 'parish', parent_file_path: "ad"}
    ]
  end

  defp country_with_nested_regions_data do
    [
      %Worldly.Region{code: '01', name: "Berat", parent_code: "AL", type: 'county', parent_file_path: "al"},
      %Worldly.Region{code: '02', name: "Durrës", parent_code: "AL", type: 'county', parent_file_path: "al"},
      %Worldly.Region{code: '03', name: "Elbasan", parent_code: "AL", type: 'county', parent_file_path: "al"},
      %Worldly.Region{code: '04', name: "Fier", parent_code: "AL", type: 'county', parent_file_path: "al"},
      %Worldly.Region{code: '05', name: "Gjirokastër", parent_code: "AL", type: 'county', parent_file_path: "al"},
      %Worldly.Region{code: '06', name: "Korçë", parent_code: "AL", type: 'county', parent_file_path: "al"},
      %Worldly.Region{code: '07', name: "Kukës", parent_code: "AL", type: 'county', parent_file_path: "al"},
      %Worldly.Region{code: '08', name: "Lezhë", parent_code: "AL", type: 'county', parent_file_path: "al"},
      %Worldly.Region{code: '09', name: "Dibër", parent_code: "AL", type: 'county', parent_file_path: "al"},
      %Worldly.Region{code: '10', name: "Shkodër", parent_code: "AL", type: 'county', parent_file_path: "al"},
      %Worldly.Region{code: '11', name: "Tiranë", parent_code: "AL", type: 'county', parent_file_path: "al"},
      %Worldly.Region{code: '12', name: "Vlorë", parent_code: "AL", type: 'county', parent_file_path: "al"}
    ]
  end

  def regions_for_albania_berat do
    [
      %Worldly.Region{code: 'BR', name: "Berat", parent_code: '01', parent_file_path: "al/01", type: 'district'},
      %Worldly.Region{code: 'KC', name: "Kuçovë", parent_code: '01', parent_file_path: "al/01", type: 'district'},
      %Worldly.Region{code: 'SK', name: "Skrapar", parent_code: '01', parent_file_path: "al/01", type: 'district'}
    ]
  end
end
