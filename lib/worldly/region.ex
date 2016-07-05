defmodule Worldly.Region do
  defstruct type: "", code: "", parent_code: "", name: "", parent_file_path: ""

  alias Worldly.Country
  alias Worldly.Locale
  alias Worldly.Region

  def region_data_files_path do
    Application.get_env(:worldly, :data_path)
  end

  def exists?(model) do
    model
    |> region_file
    |> File.exists?
  end

  def regions_for(model) do
    if exists?(model) do
      model
      |> region_file
      |> load_region_data
      |> build_region_structs(model)
    else
      []
    end
  end

  ## Helper Functions

  defp load_region_data(file) do
    [regions] = :yamerl_constr.file file, schema: :failsafe
    convert_to_tuple = fn({key, value}) -> {String.to_atom(to_string(key)), value} end
    Enum.map(regions, fn(region_doc) -> Enum.into(Enum.map(region_doc, convert_to_tuple), %{}) end)
  end

  defp build_region_structs(region_list, %Country{alpha_2_code: code}) do
    Enum.map(region_list, fn(region_map) -> %Region{struct(Region, region_map)| parent_code: code, parent_file_path: downcase(code)} |> Locale.set_locale_data('region') end)
  end
  defp build_region_structs(region_list, %Region{code: code, parent_code: parent_code, parent_file_path: parent_file_path}) do
    Enum.map(region_list, fn(region_map) -> %Region{struct(Region, region_map)| parent_code: code, parent_file_path: "#{parent_file_path}/#{downcase(code)}"} |> Locale.set_locale_data('region') end)
  end

  defp region_file(%Country{alpha_2_code: code}) do
    region_data_files_path
    |> Path.join("world")
    |> Path.join("#{code}.yml")
  end
  defp region_file(%Region{code: code, parent_code: parent_code, parent_file_path: parent_file_path}) do
    region_data_files_path
    |> Path.join("world")
    |> Path.join(parent_code)
    |> Path.join("#{code}.yml")
  end

  defp downcase(str) do
    String.downcase(str)
  rescue
    e in FunctionClauseError ->
      str
  end
end
