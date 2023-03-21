view: uac_report_gas_list {
  sql_table_name:
  `uac_report.uac_report_pack_last31days_*`

    ;;

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: cast(${TABLE}.Day as date) ;;
  }

  dimension: AccountName {
    type: string
    sql: ${TABLE}.AccountName ;;
  }

  dimension: CID {
    type: string
    sql: ${TABLE}.CID ;;
  }

  dimension: Store {
    type: string
    sql: ${TABLE}.Store ;;
  }

  dimension: app_id {
    type: string
    sql: ${TABLE}.AppId ;;
  }

  dimension: CampaignName {
    type: string
    sql: ${TABLE}.CampaignName ;;
  }

  dimension: CampaignID {
    type: string
    sql: ${TABLE}.CampaignID ;;
  }

  dimension:  CampaignStatus{
    type: string
    sql: ${TABLE}.CampaignStatus ;;
  }

  dimension: AdGroupId {
    type: string
    sql: ${TABLE}.AdGroupId ;;
  }

  dimension: AdGroupStatus {
    type: string
    sql: ${TABLE}.AdGroupStatus ;;
  }

  dimension: AdGroupName {
    type: string
    sql: ${TABLE}.AdGroupName ;;
  }

  dimension: UACType {
    type: string
    sql: ${TABLE}.UACType ;;
  }

  dimension: TargetConversions {
    type: string
    sql: ${TABLE}.TargetConversions ;;
  }

  dimension: Currency {
    type: string
    sql: ${TABLE}.Currency ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }

  dimension: Language {
    type: string
    sql: ${TABLE}.Language ;;
  }

  dimension: English {
    type: string
    sql: ${TABLE}.English ;;
  }

  dimension: AssetType {
    type: string
    sql: ${TABLE}.AssetType ;;
  }

  dimension: AdAsset {
    type: string
    sql: ${TABLE}.AdAsset ;;
  }

  dimension: pre_creativeid {
    type: string
    sql: case when ${TABLE}.AdAsset like 'DS2D%' then split(${TABLE}.AdAsset,'_')[OFFSET(0)]
              when ${TABLE}.AdAsset like 'DS3D%' then split(${TABLE}.AdAsset,'_')[OFFSET(0)]
              when ${TABLE}.AdAsset like 'DSKO%' then split(${TABLE}.AdAsset,'_')[OFFSET(0)]
              when ${TABLE}.AdAsset like 'Play%' then split(${TABLE}.AdAsset,'_')[OFFSET(0)]
              when ${TABLE}.AdAsset like 'FFSVD%' then split(${TABLE}.AdAsset,' ')[OFFSET(0)]
              when ${TABLE}.AdAsset like 'DSCS%' then split(${TABLE}.AdAsset,'_')[OFFSET(0)]
              when ${TABLE}.AdAsset like 'DSMS%' then split(${TABLE}.AdAsset,'_')[OFFSET(0)]
              when ${TABLE}.AdAsset like 'FFSPW%' then split(${TABLE}.AdAsset,'_')[OFFSET(0)]
              when ${TABLE}.AdAsset like 'FFSHC%' then split(${TABLE}.AdAsset,'_')[OFFSET(0)]
              else '' end ;;
  }

  dimension: FeedDataOriginal {
    type: string
    sql: ${TABLE}.FeedDataOriginal ;;
  }

  dimension: FeedData {
    type: string
    sql: ${TABLE}.FeedData ;;
  }

  dimension: PerformanceGrouping   {
    type: string
    sql: ${TABLE}.PerformanceGrouping  ;;
  }

  dimension: mediaid {
    type: string
    sql: ${TABLE}.mediaid ;;
  }

  dimension: sourceUrl {
    type: string
    sql: ${TABLE}.sourceUrl ;;
  }

  dimension: mediafilesize {
    type: string
    sql: ${TABLE}.mediafilesize ;;
  }

  dimension: LinkToCampaign {
    type: string
    sql: ${TABLE}.LinkToCampaign ;;
    link: {
      label: "URL:"
      url: "{{value}}"
    }
  }

  dimension: ImageSize {
    type: string
    sql: ${TABLE}.ImageSize ;;
  }

  dimension: VideoOrientation  {
    type: string
    sql: ${TABLE}.VideoOrientation   ;;
  }

  dimension: video_aspect_ratio  {
    type: string
    sql: ${TABLE}.video_aspect_ratio   ;;
  }

  dimension: RecommendedImage  {
    type: string
    sql: ${TABLE}.RecommendedImage   ;;
  }

  dimension: video_length_bucket   {
    type: string
    sql: ${TABLE}.video_length_bucket  ;;
  }

  dimension: ImageSizeType   {
    type: string
    sql: ${TABLE}.ImageSizeType  ;;
  }

  dimension: RefinedImageSize  {
    type: string
    sql: ${TABLE}.RefinedImageSize   ;;
  }

  dimension: Link {
    type: string
    sql: ${TABLE}.Link ;;
    link: {
      label: "URL:"
      url: "{{value}}"
    }
  }

  dimension: Status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: Network   {
    type: string
    sql: ${TABLE}.Network  ;;
  }

  dimension: Device {
    type: string
    sql: ${TABLE}.Device ;;
  }


  measure: clicks {
    label: "clicks"
    type: number
    sql: sum(cast(${TABLE}.clicks as int64)) ;;
    value_format_name: decimal_0
  }

  measure: impressions {
    label: "impressions"
    type: number
    sql: sum(cast(${TABLE}.impressions as int64)) ;;
    value_format_name: decimal_0
  }

  measure: cost  {
    label: "cost"
    type: number
    sql: sum(cast(${TABLE}.cost as float64))   ;;
    value_format_name: decimal_2
  }

  measure: conversions   {
    label: "conversions"
    type: number
    sql: sum(cast(${TABLE}.conversions as float64))  ;;
    value_format_name: decimal_2
  }

  measure: view_through_conversions    {
    label: "view_through_conversions"
    type: number
    sql: sum(cast(${TABLE}.view_through_conversions as int64))     ;;
    value_format_name: decimal_0
  }

  measure: installs    {
    label: "installs"
    type: number
    sql: sum(cast(${TABLE}.installs as float64))     ;;
    value_format_name: decimal_2
  }

  measure: InApp     {
    label: "InApp"
    type: number
    sql: sum(cast(${TABLE}.InApp as float64))    ;;
    value_format_name: decimal_2
  }

  measure: InApp_day_7       {
    label: "InApp_day_7"
    type: number
    sql: sum(cast(${TABLE}.InApp_day_7 as float64))      ;;
    value_format_name: decimal_2
  }

  measure: InApp_day_5     {
    label: "InApp_day_5"
    type: number
    sql: sum(cast(${TABLE}.InApp_day_5 as float64))    ;;
    value_format_name: decimal_2
  }

  measure: InApp_day_3       {
    label: "InApp_day_3"
    type: number
    sql: sum(cast(${TABLE}.InApp_day_3 as float64))      ;;
    value_format_name: decimal_2
  }

  measure: InApp_day_1     {
    label: "InApp_day_1"
    type: number
    sql: sum(cast(${TABLE}.InApp_day_1 as float64))    ;;
    value_format_name: decimal_2
  }

  measure: InApp_day_0       {
    label: "InApp_day_0"
    type: number
    sql: sum(cast(${TABLE}.InApp_day_0 as float64))      ;;
    value_format_name: decimal_2
  }

  measure: InApp_day_14      {
    label: "InApp_day_14"
    type: number
    sql: sum(cast(${TABLE}.InApp_day_14 as float64))       ;;
    value_format_name: decimal_2
  }

  measure: InApp_day_30        {
    label: "InApp_day_30"
    type: number
    sql: sum(cast(${TABLE}.InApp_day_30 as float64))         ;;
    value_format_name: decimal_2
  }

  measure: conversion_value_day_0        {
    label: "conversion_value_day_0"
    type: number
    sql: sum(cast(${TABLE}.conversion_value_day_0 as float64))         ;;
    value_format_name: decimal_2
  }

  measure: conversion_value_day_1        {
    label: "conversion_value_day_1"
    type: number
    sql: sum(cast(${TABLE}.conversion_value_day_1 as float64))         ;;
    value_format_name: decimal_2
  }

  measure: conversion_value_day_3          {
    label: "conversion_value_day_3"
    type: number
    sql: sum(cast(${TABLE}.conversion_value_day_3 as float64))           ;;
    value_format_name: decimal_2
  }

  measure: conversion_value_day_5 {
    label: "conversion_value_day_5"
    type: number
    sql: sum(cast(${TABLE}.conversion_value_day_5 as float64));;
    value_format_name: decimal_2
  }

  measure: conversion_value_day_7          {
    label: "conversion_value_day_7"
    type: number
    sql: sum(cast(${TABLE}.conversion_value_day_7 as float64))           ;;
    value_format_name: decimal_2
  }

  measure: conversion_value_day_14           {
    label: "conversion_value_day_14"
    type: number
    sql: sum(cast(${TABLE}.conversion_value_day_14 as float64))          ;;
    value_format_name: decimal_2
  }

  measure: conversion_value_day_30           {
    label: "conversion_value_day_30"
    type: number
    sql: sum(cast(${TABLE}.conversion_value_day_30 as float64))          ;;
    value_format_name: decimal_2
  }


  filter: date_filter {
    type: date
    sql: _TABLE_SUFFIX BETWEEN replace(safe_cast(date({%date_start date_filter %}) as string),'-','') AND replace(safe_cast(date({%date_end date_filter %}) as string),'-','');;
  }

}
