connection: "dd_lego"

# include all the views
include: "/views/**/*.view"

datagroup: dd_lego_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: dd_lego_default_datagroup

access_grant : can_view_marketing_table {
  user_attribute : can_view_marketing_table
  allowed_values : ["yes"]
}

explore: asset_performance_report {
  required_access_grants : [ can_view_marketing_table ]

  access_filter: {
    field: app_id
    user_attribute: app_id
  }

  description: "Asset Performance Report表为依据谷歌Lego报表数据对应制作的Looker报表。"
}

explore: placement_report_agg {
  required_access_grants : [ can_view_marketing_table ]

  access_filter: {
    field: app_id
    user_attribute: app_id
  }

  description: "Placement Report Agg表为依据谷歌Lego报表数据对应制作的Looker报表，已于2021.6停止更新。"
}

explore: placement_report_list {
  required_access_grants : [ can_view_marketing_table ]

  access_filter: {
    field: app_id
    user_attribute: app_id
  }

  description: "Placement Report List表为依据谷歌Lego报表数据对应制作的Looker报表，已于2021.6停止更新。"
}

explore: placement_conversion_report {
  required_access_grants : [ can_view_marketing_table ]

  access_filter: {
    field: app_id
    user_attribute: app_id
  }

  description: "Placement Conversion Report表为依据谷歌Lego报表数据对应制作的Looker报表，已于2021.6停止更新。"
}


explore: uac_report_gas {
  required_access_grants : [ can_view_marketing_table ]

  access_filter: {
    field: app_id
    user_attribute: app_id
  }

  description: "Uac Report Gas表为谷歌提供的数据表，该表呈现前一天形成的最近31天的数据。"
}

explore: uac_report_gas_list {
  required_access_grants : [ can_view_marketing_table ]

  access_filter: {
    field: app_id
    user_attribute: app_id
  }

  description: "Uac Report Gas List 是Uac Report Gas形成的每日表的集合，可查看历史数据，选择date filter指定查看某一天形成的数据表，用Date Date字段筛选查看那天之前31天内的历史数据。"
}
