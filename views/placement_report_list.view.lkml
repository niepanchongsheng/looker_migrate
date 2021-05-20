view: placement_report_list {
  sql_table_name: ads_reports_data.snd_placement_report_list
  ;;

  dimension: app_id {
    type: string
    sql: ${TABLE}.campaign_app_campaign_setting_app_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: placement_type {
    type: string
    sql: ${TABLE}.group_placement_view_placement_type ;;
  }

  dimension: placement {
    type: string
    sql: ${TABLE}.group_placement_view_display_name ;;
    link: {
      label: "View {{value}}"
      url: "{{group_placement_view_target_url._value}}"
    }
  }

  dimension: segments_date {
    type: date
    datatype: date
    convert_tz: no
    sql: date(${TABLE}.segment_date) ;;
  }

  dimension: group_placement_view_display_name {
    type: string
    sql: ${TABLE}.group_placement_view_display_name ;;
  }

  dimension: group_placement_view_target_url {
    type: string
    sql: ${TABLE}.group_placement_view_target_url ;;
  }


  measure: cost {
    label: "Cost"
    value_format: "$0.00"
    type: sum
    sql: ${TABLE}.metrics_cost ;;
  }

  measure: clicks {
    label: "Clicks"
    type: sum
    sql: ${TABLE}.metrics_clicks ;;
  }

  measure: impressions {
    label: "Impressions"
    type: sum
    sql: ${TABLE}.metrics_impressions ;;
  }

  measure: conversions {
    label: "Conversions"
    type: sum
    sql: ${TABLE}.metrics_conversions ;;
  }

  measure: conversions_value {
    label: "Conv.Value"
    value_format: "$0.00"
    type: sum
    sql: ${TABLE}.metrics_conversions_value ;;
  }

  measure: avg_cpc {
    label: "Avg.CPC"
    type: number
    value_format_name: decimal_2
    sql:if (${clicks}=0,null, ${cost}/${clicks} );;
  }

  measure: ctr {
    label: "CTR"
    type: number
    value_format_name: percent_2
    sql: if (${impressions}=0,null,${clicks}/${impressions}) ;;
  }

  measure: cvr {
    label: "CVR"
    type: number
    value_format_name: percent_2
    sql: if (${clicks}=0,null,${conversions}/${clicks}) ;;
  }

  measure: roas {
    label: "ROAS"
    type: number
    value_format_name: percent_2
    sql:if (${cost}=0,null, ${conversions_value}/${cost} );;
  }

  measure: conversion_rate {
    type: number
    value_format_name: percent_2
    sql: if (${clicks}=0,null, ${conversions}/${clicks} );;
  }

  measure: cpi {
    label: "CPI"
    type: number
    value_format_name: decimal_2
    sql:if( ${conversions}=0,null, ${cost}/${conversions}) ;;
  }

  measure: placements {
    label: "Placements"
    type: count_distinct
    sql: ${group_placement_view_target_url} ;;
  }

  measure: campaigns {
    label: "Campaigns"
    type: count_distinct
    sql: ${campaign_id} ;;
  }

  measure: mobile_app_impressions {
    type: sum
    sql:
      case
        when ${TABLE}.group_placement_view_placement_type = 'MOBILE_APPLICATION' then ${TABLE}.metrics_impressions
        else 0
      end ;;
  }

  measure: youtube_channel_impressions {
    type: sum
    sql:
      case
        when ${TABLE}.group_placement_view_placement_type = 'YOUTUBE_CHANNEL'
          and ${TABLE}.group_placement_view_display_name <> ''
          then ${TABLE}.metrics_impressions
        else 0
      end ;;
  }


}
