Farnham Food Hygiene Ratings
================
Clare Gibson

- [Packages](#packages)
- [Load the data](#load-the-data)
- [Dataframe profile](#dataframe-profile)
- [Column profiling](#column-profiling)
  - [`fhrsid`](#fhrsid)
  - [`local_authority_business_id`](#local_authority_business_id)
- [Cleaning requirements identified](#cleaning-requirements-identified)

# Packages

Load the packages to be used for this project.

``` r
library(here)
library(knitr)
```

# Load the data

The data for profiling is contained in the `fhr` object created in the
[`2-prep-data.R`](script/2-prep-data.R) script.

``` r
# Load data
source(here("script/2-prep-data.R"))

# Check that data has loaded
head(fhr_data) %>% 
  kable()
```

|  fhrsid | local_authority_business_id | business_name           | business_type           | business_type_id | rating_value | rating_key   | rating_date | local_authority_code | local_authority_name | local_authority_web_site     | local_authority_email_address         | hygiene | structural | confidence_in_management | scheme_type | new_rating_pending | longitude | latitude | address_line1          | address_line2 | address_line3 | address_line4 | post_code | fhrs_establishment_id |
|--------:|:----------------------------|:------------------------|:------------------------|-----------------:|:-------------|:-------------|:------------|---------------------:|:---------------------|:-----------------------------|:--------------------------------------|--------:|-----------:|-------------------------:|:------------|:-------------------|----------:|---------:|:-----------------------|:--------------|:--------------|:--------------|:----------|:----------------------|
| 1199283 | PI/000134037                | 3D Spice                | Other catering premises |             7841 | 5            | fhrs_5_en-GB | 2022-02-01  |                  314 | Waverley             | <http://www.waverley.gov.uk> | <environmentalhealth@waverley.gov.uk> |       0 |          0 |                        0 | FHRS        | FALSE              |        NA |       NA | NA                     | NA            | NA            | NA            | NA        | EstablishmentDetail   |
|  177971 | PI/000044599                | 40 Degreez              | Other catering premises |             7841 | 5            | fhrs_5_en-GB | 2022-05-27  |                  314 | Waverley             | <http://www.waverley.gov.uk> | <environmentalhealth@waverley.gov.uk> |       5 |          5 |                        5 | FHRS        | FALSE              | -0.793374 | 51.21678 | Farnham Youth Project  | Dogflud Way   | Farnham       | Surrey        | NA        | EstablishmentDetail   |
| 1495850 | PI/000180590                | 7AM Premier Farnham     | Retailers - other       |             4613 | 1            | fhrs_1_en-GB | 2022-12-08  |                  314 | Waverley             | <http://www.waverley.gov.uk> | <environmentalhealth@waverley.gov.uk> |      15 |         15 |                       20 | FHRS        | FALSE              | -0.762408 | 51.23089 | 57-59 Badshot Lea Road | Badshot Lea   | Farnham       | Surrey        | GU9 9LP   | EstablishmentDetail   |
| 1209035 | PI/000178110                | A & R Convenience Store | Retailers - other       |             4613 | 5            | fhrs_5_en-GB | 2023-02-01  |                  314 | Waverley             | <http://www.waverley.gov.uk> | <environmentalhealth@waverley.gov.uk> |       5 |          5 |                        0 | FHRS        | FALSE              | -0.606548 | 51.19057 | 7 Meadrow              | Godalming     | Surrey        | NA            | GU7 3HJ   | EstablishmentDetail   |
| 1531219 | PI/000161558                | A Bite to Wheat         | Other catering premises |             7841 | 5            | fhrs_5_en-GB | 2022-06-09  |                  314 | Waverley             | <http://www.waverley.gov.uk> | <environmentalhealth@waverley.gov.uk> |       0 |          0 |                        0 | FHRS        | FALSE              |        NA |       NA | NA                     | NA            | NA            | NA            | NA        | EstablishmentDetail   |
| 1495839 | PI/000124651                | A Fancy Piece           | Other catering premises |             7841 | 5            | fhrs_5_en-GB | 2022-03-15  |                  314 | Waverley             | <http://www.waverley.gov.uk> | <environmentalhealth@waverley.gov.uk> |       5 |          5 |                        0 | FHRS        | FALSE              |        NA |       NA | NA                     | NA            | NA            | NA            | NA        | EstablishmentDetail   |

# Dataframe profile

The dataframe has 982 rows and 25 columns. A `glimpse` of the data is
shown below.

``` r
# Glimpse data
glimpse(fhr_data)
```

    ## Rows: 982
    ## Columns: 25
    ## $ fhrsid                        <dbl> 1199283, 177971, 1495850, 1209035, 15312…
    ## $ local_authority_business_id   <chr> "PI/000134037", "PI/000044599", "PI/0001…
    ## $ business_name                 <chr> "3D Spice", "40 Degreez", "7AM Premier F…
    ## $ business_type                 <chr> "Other catering premises", "Other cateri…
    ## $ business_type_id              <dbl> 7841, 7841, 4613, 4613, 7841, 7841, 7841…
    ## $ rating_value                  <chr> "5", "5", "1", "5", "5", "5", "5", "0", …
    ## $ rating_key                    <chr> "fhrs_5_en-GB", "fhrs_5_en-GB", "fhrs_1_…
    ## $ rating_date                   <date> 2022-02-01, 2022-05-27, 2022-12-08, 202…
    ## $ local_authority_code          <dbl> 314, 314, 314, 314, 314, 314, 314, 314, …
    ## $ local_authority_name          <chr> "Waverley", "Waverley", "Waverley", "Wav…
    ## $ local_authority_web_site      <chr> "http://www.waverley.gov.uk", "http://ww…
    ## $ local_authority_email_address <chr> "environmentalhealth@waverley.gov.uk", "…
    ## $ hygiene                       <dbl> 0, 5, 15, 5, 0, 5, 5, 15, 5, 0, 5, 0, 0,…
    ## $ structural                    <dbl> 0, 5, 15, 5, 0, 5, 0, 20, 5, 0, 0, 5, 5,…
    ## $ confidence_in_management      <dbl> 0, 5, 20, 0, 0, 0, 0, 20, 5, 0, 5, 10, 5…
    ## $ scheme_type                   <chr> "FHRS", "FHRS", "FHRS", "FHRS", "FHRS", …
    ## $ new_rating_pending            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE…
    ## $ longitude                     <dbl> NA, -0.7933740, -0.7624080, -0.6065480, …
    ## $ latitude                      <dbl> NA, 51.21678, 51.23089, 51.19057, NA, NA…
    ## $ address_line1                 <chr> NA, "Farnham Youth Project", "57-59 Bads…
    ## $ address_line2                 <chr> NA, "Dogflud Way", "Badshot Lea", "Godal…
    ## $ address_line3                 <chr> NA, "Farnham", "Farnham", "Surrey", NA, …
    ## $ address_line4                 <chr> NA, "Surrey", "Surrey", NA, NA, NA, NA, …
    ## $ post_code                     <chr> NA, NA, "GU9 9LP", "GU7 3HJ", NA, NA, NA…
    ## $ fhrs_establishment_id         <chr> "EstablishmentDetail", "EstablishmentDet…

# Column profiling

Look at each column in turn and assess the number of unique values. Is
any recoding required?

## `fhrsid`

``` r
# How many unique values?
length(unique(fhr_data$fhrsid))
```

    ## [1] 982

This is an ID column with no duplicates.

## `local_authority_business_id`

``` r
# How many unique values?
length(unique(fhr_data$local_authority_business_id))
```

    ## [1] 982

This is an ID column with no duplicates.

# Cleaning requirements identified

- Records with missing location data should be removed. These records
  refer to establishments that are run from a private address. There are
  226 such records in the dataset, representing 23% of the total.
