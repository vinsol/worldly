# Worldly
Elixir Module containing data about Countries and their states

**Warning**

Alpha Quality(Work in Progress). Reads the files for every function call.

**TODO**

1. [ ] Improve performance by utilizing the OTP.
1. [ ] Add proper localization support.
1. [ ] Better Documentation
1. [x] Publish to Hex.
1. [x] Add Tests

## Installation

  1. Add worldly to your list of dependencies in `mix.exs`.

         def deps do
           [{:worldly, "~> 0.1.0"}]
         end

  2. Ensure worldly is started before your application:

         def application do
           [applications: [:worldly]]
         end

## Usage

1. To get the list of countries use `Worldly.Country.all`
1. You can get country by name using `Worldly.Country.with_name name_in_locale`
1. You can get country by code using `Worldly.Country.with_code alpha_2_code` or `Worldly.Country.with_code alpha_3_code`
1. To get the regions for a country, use `Worldly.Region.regions_for country_or_region`, where country_or_region can be a country struct `Worldy.Country` or region struct `Worldy.Region`
1. You can also whether sub-regions exist for country or a region, use `Worldly.Region.regions_for country_or_region`, where country_or_region can be a country struct `Worldy.Country` or region struct `Worldy.Region`
