view: placement_report_agg {
  sql_table_name: ads_reports_data.snd_placement_report_agg ;;

  dimension: app_id {
    type: string
    sql: ${TABLE}.campaign_app_campaign_setting_app_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: placement_type {
    type: string
    sql: ${TABLE}.group_placement_view_placement_type ;;
  }

  dimension: segments_date {
    type: date
    datatype: date
    convert_tz: no
    sql: date(${TABLE}.segments_date) ;;
  }

  dimension: placement_type_display {
    type: string
    sql:
      case
        when ${TABLE}.group_placement_view_placement_type = "UNSPECIFIED" then "UNSPECIFIED"
        when ${TABLE}.group_placement_view_placement_type = "UNKNOWN" then "UNKNOWN"
        when ${TABLE}.group_placement_view_placement_type = "WEBSITE" then "Website"
        when ${TABLE}.group_placement_view_placement_type = "MOBILE_APP_CATEGORY" then "Mobile App Category"
        when ${TABLE}.group_placement_view_placement_type = "MOBILE_APPLICATION" then "Mobile App"
        when ${TABLE}.group_placement_view_placement_type = "YOUTUBE_VIDEO" then "Youtube Video"
        else "Youtube Channel"
      end
    ;;
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
    sql:
      case
        when ${clicks} = 0 then null
        else ${cost}/${clicks}
      end ;;
  }

  measure: ctr {
    label: "CTR"
    type: number
    value_format_name: percent_2
    sql:
      case
        when ${impressions} = 0 then null
        else ${clicks}/${impressions}
      end ;;
  }

  measure: cvr {
    label: "CVR"
    type: number
    value_format_name: percent_2
    sql:
      case
        when ${clicks} = 0 then null
        else ${conversions}/${clicks}
      end ;;
  }

  measure: cpi {
    label: "CPI"
    type: number
    value_format_name: decimal_2
    sql:
      case
        when ${conversions} = 0 then null
        else ${cost}/${conversions}
      end ;;
  }

  measure: campaigns {
    label: "Campaigns"
    type: count_distinct
    sql: ${campaign_id} ;;
  }


}
