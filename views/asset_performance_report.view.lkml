view: asset_performance_report {
  sql_table_name: ads_reports_data_v4.app_trd_asset_perf_report
    ;;

  dimension: app_id {
    type: string
    sql: ${TABLE}.campaign_app_campaign_setting_app_id ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: network_type {
    type: string
    sql:
      case
        when ${TABLE}.segments_ad_network_type = "SEARCH" then "Search"
        when ${TABLE}.segments_ad_network_type = "SEARCH_PARTNERS" then "Search Partners"
        when ${TABLE}.segments_ad_network_type = "CONTENT" then "Content"
        when ${TABLE}.segments_ad_network_type = "YOUTUBE_SEARCH" then "Youtube Search"
        when ${TABLE}.segments_ad_network_type = "YOUTUBE_WATCH" then "Youtube Watch"
        when ${TABLE}.segments_ad_network_type = "MIXED" then "Mixed"
        else ""
      end;;
  }

  dimension: asset_type {
    type: string
    sql:
      case
        when ${TABLE}.ad_group_ad_asset_view_field_type = "YOUTUBE_VIDEO" then "Video"
        when ${TABLE}.ad_group_ad_asset_view_field_type  = "DESCRIPTION" then "Description"
        when ${TABLE}.ad_group_ad_asset_view_field_type = "HEADLINE" then "Headline"
        when ${TABLE}.ad_group_ad_asset_view_field_type = "MARKETING_IMAGE" then "Image"
        else "Media Bundle"
      end;;
  }

  dimension: campaign_type {
    type: string
    sql:
      case
        when ${TABLE}.campaign_app_campaign_setting_bidding_strategy_goal_type = "OPTIMIZE_INSTALLS_TARGET_INSTALL_COST" then "AC for Install 1.0"
        when ${TABLE}.campaign_app_campaign_setting_bidding_strategy_goal_type = "OPTIMIZE_IN_APP_CONVERSIONS_TARGET_CONVERSION_COST" then "AC for Action"
        when ${TABLE}.campaign_app_campaign_setting_bidding_strategy_goal_type = "OPTIMIZE_IN_APP_CONVERSIONS_TARGET_INSTALL_COST" then "Ac for Install 2.0"
        when ${TABLE}.campaign_app_campaign_setting_bidding_strategy_goal_type = "OPTIMIZE_RETURN_ON_ADVERTISING_SPEND" then "AC for Value"
        else "Unknown"
      end;;
  }

  dimension: segments_date {
    type: date
    datatype: date
    convert_tz: no
    sql: date(${TABLE}.segments_date) ;;
  }

  dimension: asset_thumbnail {
    type: string
    sql: ${TABLE}.asset_thumbnail ;;
    html: <img src={{value}} width="120" height="80">;;
  }

  dimension: asset_id {
    type: string
    sql: ${TABLE}.asset_id ;;
  }

  dimension: asset_name {
    type: string
    sql: ${TABLE}.video_title ;;
  }

  dimension:  account_id{
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.customer_descriptive_name ;;
  }

  dimension: Performance_Labelv {
    type: string
    sql: ${TABLE}.ad_group_ad_asset_view_performance_label ;;
  }

  dimension: link {
    type: string
    sql: CONCAT("https://www.youtube.com/watch?v=", ${TABLE}.asset_youtube_video_asset_youtube_video_id) ;;
    link: {
      label: "URL:"
      url: "{{value}}"
    }
  }


  measure: assets {
    label: "Assets"
    type: count_distinct
    sql: ${TABLE}.asset_id ;;
  }

  measure: cost {
    label: "Cost"
    value_format: "$0.00"
    type: number
    sql: sum(${TABLE}.metrics_cost) ;;
  }

  measure: ctr {
    label: "CTR"
    type: number
    value_format_name: percent_2
    sql:
      case when sum(${TABLE}.metrics_impressions) = 0 then null
      else sum(${TABLE}.metrics_clicks)/sum(${TABLE}.metrics_impressions)
      end ;;
  }

  measure: avg_cpc {
    label: "Avg.CPC"
    value_format_name: decimal_2
    type: number
    sql:
      case when sum(${TABLE}.metrics_clicks) = 0 then null
      else sum(${TABLE}.metrics_cost)/sum(${TABLE}.metrics_clicks)
      end ;;
  }

  measure: impressions {
    label: "Impressions"
    type: number
    sql: sum(${TABLE}.metrics_impressions) ;;
  }

  measure: cvr {
    label: "CVR"
    type: number
    value_format_name: percent_2
    sql:
      case when sum(${TABLE}.metrics_clicks) = 0 then null
      else sum(${TABLE}.metrics_conversions)/sum(${TABLE}.metrics_clicks)
      end ;;
  }

  measure: clicks {
    label: "Clicks"
    type: number
    sql: sum(${TABLE}.metrics_clicks) ;;
  }

  measure: conversions {
    label: "Conversions"
    type: number
    sql: sum(${TABLE}.metrics_conversions) ;;
  }

  measure: conversions_value {
    label: "Conv.Value"
    type: number
    sql: sum(${TABLE}.metrics_conversions_value) ;;
  }

  measure: roas {
    label: "ROAS"
    type: number
    value_format_name: percent_2
    sql:
      case when ${cost} = 0 then null
      else ${conversions_value}/${cost}
      end ;;
  }

  measure: score {
    label: "Score"
    value_format_name: decimal_2
    type: number
    sql:
      case when sum(${TABLE}.metrics_impressions) = 0 then null
      else sum(${TABLE}.metrics_conversions)*1000/sum(${TABLE}.metrics_impressions)
      end ;;
  }

  measure: all_conversions {
    type: number
    sql: sum(${TABLE}.metrics_all_conversions) ;;
  }

  measure: all_conversions_value {
    type: number
    sql: sum(${TABLE}.metrics_all_conversions_value) ;;
  }

}
