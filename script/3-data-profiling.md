Farnham Food Hygiene Ratings
================
Clare Gibson

- [Introduction](#introduction)
- [Packages](#packages)
- [Load the data](#load-the-data)
- [Dataframe profile](#dataframe-profile)
- [Column profiling](#column-profiling)
  - [`fhrsid`](#fhrsid)
  - [`local_authority_business_id`](#local_authority_business_id)
  - [`business_name`](#business_name)
  - [`business_type`](#business_type)
  - [`business_type_id`](#business_type_id)
  - [`rating_value`](#rating_value)
  - [`rating_key`](#rating_key)
  - [`rating_date`](#rating_date)
  - [`local_authority_code`](#local_authority_code)
  - [`local_authority_name`](#local_authority_name)
  - [`local_authority_web_site`](#local_authority_web_site)
  - [`local_authority_email_address`](#local_authority_email_address)
  - [`hygiene`](#hygiene)
  - [`structural`](#structural)
  - [`confidence_in_management`](#confidence_in_management)
  - [`scheme_type`](#scheme_type)
  - [`new_rating_pending`](#new_rating_pending)
- [Cleaning requirements identified](#cleaning-requirements-identified)

# Introduction

This script outlines the steps take to profile the data from the Food
Hygiene Ratings dataset. This script will not make any edits to the data
but will note down where cleaning actions should be taken so that this
can be performed with an R script in the overall pipeline.

# Packages

Load the packages to be used for this project.

``` r
library(here)
library(knitr)
library(ggplot2)
```

# Load the data

The data for profiling is contained in the `fhr` object created in the
[`2-prep-data.R`](script/2-prep-data.R) script.

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

- There are 982 unique values.
- This is an ID column with no duplicates.

## `local_authority_business_id`

- There are 982 unique values
- This is an ID column with no duplicates.

## `business_name`

- There are 939 unique values.
- Be aware there are some duplicated business names.

## `business_type`

- There are 13 unique values.

| business_type                         |   n | prop |
|:--------------------------------------|----:|-----:|
| Restaurant/Cafe/Canteen               | 188 | 0.19 |
| Other catering premises               | 179 | 0.18 |
| Retailers - other                     | 153 | 0.16 |
| Hospitals/Childcare/Caring Premises   | 110 | 0.11 |
| Pub/bar/nightclub                     |  95 | 0.10 |
| School/college/university             |  82 | 0.08 |
| Takeaway/sandwich shop                |  52 | 0.05 |
| Mobile caterer                        |  50 | 0.05 |
| Manufacturers/packers                 |  28 | 0.03 |
| Hotel/bed & breakfast/guest house     |  20 | 0.02 |
| Retailers - supermarkets/hypermarkets |  19 | 0.02 |
| Distributors/Transporters             |   5 | 0.01 |
| Farmers/growers                       |   1 | 0.00 |

## `business_type_id`

There are 13 unique values.

| business_type_id |   n | prop |
|-----------------:|----:|-----:|
|                1 | 188 | 0.19 |
|             7841 | 179 | 0.18 |
|             4613 | 153 | 0.16 |
|                5 | 110 | 0.11 |
|             7843 |  95 | 0.10 |
|             7845 |  82 | 0.08 |
|             7844 |  52 | 0.05 |
|             7846 |  50 | 0.05 |
|             7839 |  28 | 0.03 |
|             7842 |  20 | 0.02 |
|             7840 |  19 | 0.02 |
|                7 |   5 | 0.01 |
|             7838 |   1 | 0.00 |

## `rating_value`

- There are 8 unique values.

| rating_value       |   n | prop |
|:-------------------|----:|-----:|
| 5                  | 729 | 0.74 |
| 4                  | 116 | 0.12 |
| 3                  |  58 | 0.06 |
| Exempt             |  43 | 0.04 |
| 2                  |  16 | 0.02 |
| 1                  |  12 | 0.01 |
| AwaitingInspection |   7 | 0.01 |
| 0                  |   1 | 0.00 |

- Note the mix of character and numeric. Could we remove character?

## `rating_key`

- There are 8 unique values.

| rating_key                    |   n | prop |
|:------------------------------|----:|-----:|
| fhrs_5_en-GB                  | 729 | 0.74 |
| fhrs_4_en-GB                  | 116 | 0.12 |
| fhrs_3_en-GB                  |  58 | 0.06 |
| fhrs_exempt_en-GB             |  43 | 0.04 |
| fhrs_2_en-GB                  |  16 | 0.02 |
| fhrs_1_en-GB                  |  12 | 0.01 |
| fhrs_awaitinginspection_en-GB |   7 | 0.01 |
| fhrs_0_en-GB                  |   1 | 0.00 |

- This column supplements the `rating_value` column nicely. We probably
  don’t need to add another column.

## `rating_date`

- There are 389 unique values.
- Earliest date is 2016-01-22
- Latest date is 2023-07-19

<!-- -->

    ##         Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
    ## "2016-01-22" "2022-02-11" "2022-07-01" "2022-07-04" "2023-01-20" "2023-07-19" 
    ##         NA's 
    ##          "7"

## `local_authority_code`

- There is 1 unique value.
- This should be treated as metadata since the same value applies to
  every record.

## `local_authority_name`

- There is 1 unique value.
- This should be treated as metadata since the same value applies to
  every record.

## `local_authority_web_site`

- There is 1 unique value.
- This should be treated as metadata since the same value applies to
  every record.

## `local_authority_email_address`

- There is 1 unique value.
- This should be treated as metadata since the same value applies to
  every record.

## `hygiene`

- There are 5 unique values.

| hygiene |   n | prop |
|--------:|----:|-----:|
|       0 | 587 | 0.60 |
|       5 | 241 | 0.25 |
|      10 |  94 | 0.10 |
|      NA |  50 | 0.05 |
|      15 |  10 | 0.01 |

- This column is part of the `score` tag in the original xml file.

## `structural`

- There are 6 unique values.

| structural |   n | prop |
|-----------:|----:|-----:|
|          0 | 458 | 0.47 |
|          5 | 358 | 0.36 |
|         10 |  95 | 0.10 |
|         NA |  50 | 0.05 |
|         15 |  20 | 0.02 |
|         20 |   1 | 0.00 |

- This column is part of the `score` tag in the original xml file.

## `confidence_in_management`

- There are 5 unique values.

| confidence_in_management |   n | prop |
|-------------------------:|----:|-----:|
|                        0 | 506 | 0.52 |
|                        5 | 311 | 0.32 |
|                       10 | 102 | 0.10 |
|                       NA |  50 | 0.05 |
|                       20 |  13 | 0.01 |

- This column is part of the `score` tag in the original xml file.

## `scheme_type`

- There is 1 unique value.
- This should be treated as metadata since the same value applies to
  every record.

## `new_rating_pending`

- There are 2 unique values.

| new_rating_pending |   n | prop |
|:-------------------|----:|-----:|
| FALSE              | 973 | 0.99 |
| TRUE               |   9 | 0.01 |

# Cleaning requirements identified

- Records with missing location data should be removed. These records
  refer to establishments that are run from a private address. There are
  226 such records in the dataset, representing 23% of the total.
- `rating_value` has a mix of character and numeric values. Look at
  keeping a single type in the column (perhaps split data into 2
  columns, one for numeric rating and one for rating code.)
- Add the following fields to metadata since the same value is used for
  every record: `local_authority_code`, `local_authority_name`,
  `local_authority_web_site`, `local_authority_email_address`.
- Append `_score` to the following columns: `hygiene`, `structural`,
  `confidence_in_management` (abbreviated to `management`)
