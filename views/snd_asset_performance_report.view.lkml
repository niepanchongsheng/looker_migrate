view: snd_asset_performance_report {
  sql_table_name: ads_reports_data.snd_asset_performance_report
  ;;

  dimension: app_id {
    type: string
    sql: ${TABLE}.campaign_app_campaign_setting_app_id ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
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
    sql: ${TABLE}.segments_date ;;
  }

  dimension: asset_type_display {
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

  dimension: asset_thumbnail {
    type: string
    sql: ${TABLE}.asset_thumbnail ;;
    html: <img src={{value}} width="150" height="120">;;
  }

  dimension: asset_id {
    type: string
    sql: ${TABLE}.asset_id ;;
  }

  dimension: asset_name {
    type: string
    sql: ${TABLE}.asset_name ;;
  }

  dimension: Performance_Labelv {
    type: string
    sql: ${TABLE}.ad_group_ad_asset_view_performance_label ;;
  }

  dimension: link {
    type: string
    sql: CONCAT("https://www.youtube.com/watch?v=", ${TABLE}.asset_youtube_video_asset_youtube_video_id) ;;
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
    sql: sum(${TABLE}.metrics_clicks)/sum(${TABLE}.metrics_conversions) ;;
  }

  measure: avg_cpc {
    label: "Avg.CPC"
    value_format_name: decimal_2
    type: number
    sql: sum(${TABLE}.metrics_cost)/sum(${TABLE}.metrics_clicks) ;;
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
    sql: sum(${TABLE}.metrics_conversions)/sum(${TABLE}.metrics_clicks) ;;
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
    sql: ${conversions_value}/${cost} ;;
  }

  measure: score {
    label: "Score"
    value_format_name: decimal_2
    type: number
    sql: sum(${TABLE}.metrics_conversions)*1000/sum(${TABLE}.metrics_impressions) ;;
  }

}
