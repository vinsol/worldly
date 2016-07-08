# Worldly

Elixir Module containing data about Countries, states and their regions as per iso standard.

This package is a port of [carmen ruby gem](https://github.com/jim/carmen)

**Warning**

Alpha Quality(Work in Progress). Reads the files for every function call.

**TODO**

1. [ ] Improve performance by utilizing the OTP.
1. [ ] Add proper localization support.
1. [ ] Better Documentation [Module and Function docs]
1. [ ] Allow countries or regions to be extended in App
1. [x] Publish to Hex.
1. [x] Add Tests

## Installation

  1. Add worldly to your list of dependencies in `mix.exs`.

         def deps do
           [
             {:yamerl, github: "yakaz/yamerl"},
             {:worldly, "~> 0.1.1"}
           ]
         end

  2. **Ensure worldly and yamerl is started before your application**:

         def application do
           [applications: [:yamerl, :worldly]]
         end

  3. Add worldly config data path in config/config.exs

         config :worldly, :data_path, Path.join(Mix.Project.build_path, "lib/worldly/priv/data")


  4. You can also checkout a [demo mix project](https://github.com/pikender/worldly_test_app) showing use of worldly and its setup. Check README and commit-history (4 commits only :) )

## Usage

*Disclaimer:* - Locale need to be added for all corresponding entries in countries or regions to provide `name` and other relevant information. It might crash if corresponding locale mapping missing.

1. To get the list of countries use `Worldly.Country.all`
1. You can get country by name using `Worldly.Country.with_name name_in_locale`
1. You can get country by code using `Worldly.Country.with_code alpha_2_code` or `Worldly.Country.with_code alpha_3_code`
1. To get the regions for a country, use `Worldly.Region.regions_for country_or_region`, where country_or_region can be a country struct `Worldy.Country` or region struct `Worldy.Region`
1. You can also whether sub-regions exist for country or a region, use `Worldly.Region.regions_for country_or_region`, where country_or_region can be a country struct `Worldy.Country` or region struct `Worldy.Region`
