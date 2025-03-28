# Farnham Food
An exploration of food establishments in Waverley, Surrey, using geospatial analysis techniques.

## Description
This project sets out to explore food hygiene ratings in Farnham and the wider borough of Waverley in Surrey, UK. The UK [Food Standards Agency](https://www.food.gov.uk) publishes [full ratings data](https://ratings.food.gov.uk) for every local authority in England and Wales. An explainer on the UK's Food Hygiene Rating Scheme can be found [here](https://www.food.gov.uk/safety-hygiene/food-hygiene-rating-scheme).

## Getting started
### Data
* The source data used for this project can be downloaded [here](https://drive.google.com/file/d/1u6Qu3k99K0SbU-35ohsdppoV7PKm3bRY/view?usp=share_link). The original source of the data is the UK FSA, and can be downloaded [here](https://ratings.food.gov.uk/OpenDataFiles/FHRS314en-GB.xml). If downloading from source be aware that the data may differ from that used in this project since the ratings are refreshed on a daily basis.
* - [Local Authority Districts (May 2023) Boundaries UK BFC](https://geoportal.statistics.gov.uk/datasets/2f0b8074b6ab4af6a1ec30eb66317d12_0/explore?location=54.959083%2C-3.316939%2C5.91). Download the Shapefile at this URL and store in `/data/src/shape-lad/`.

Note that some of the establishments in the dataset have no location data because they are run from a private address. These establishments have been excluded from my analysis.

### Data Profiling
My exploratory analysis and profiling of the source data can be found [here](https://rpubs.com/SurreyDataGirl/farnham-food).

## Author
- [Clare Gibson](https://www.surreydatagirl.com) - [surreydatagirl@gmail.com](mailto:surreydatagirl.com)

## Licence
This project is licensed under the CC0 1.0 Universal licence. See the [LICENSE](./LICENSE) file for details.

## Acknowledgements
- [This article](https://urbandatapalette.com/post/2021-03-xml-dataframe-r/) was a tremendous help when converting the XML data to an R dataframe.
- [Waffle Charts](https://www.vizwiz.com/2019/09/waffle-chart.html)