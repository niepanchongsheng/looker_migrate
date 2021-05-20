view: placement_conversion_report {
  sql_table_name: ads_reports_data.snd_placement_conversion_report
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

  dimension: group_placement_view_display_name {
    type: string
    sql: ${TABLE}.group_placement_view_display_name ;;
  }

  dimension: group_placement_view_target_url {
    type: string
    sql: ${TABLE}.group_placement_view_target_url ;;
  }


  dimension: segments_date {
    type: date
    datatype: date
    convert_tz: no
    sql: date(${TABLE}.segments_date) ;;
  }

  dimension: conversion_name {
    label: "Conv.Name"
    type: string
    sql: ${TABLE}.segments_conversion_action_name ;;
  }

  measure: conversions {
    label: "Conversions"
    type: sum
    sql: ${TABLE}.metrics_conversions ;;
  }

  measure: sum_conversion_value {
    label: "Conv.Value"
    value_format: "$0.00"
    type: sum
    sql: ${TABLE}.metrics_conversions_value ;;
  }


}
