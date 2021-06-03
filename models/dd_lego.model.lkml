connection: "dd_lego"

# include all the views
include: "/views/**/*.view"

datagroup: dd_lego_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: dd_lego_default_datagroup

access_grant : marketing_can_see {
  user_attribute : marketing_can_see
  allowed_values : ["yes"]
}

explore: asset_performance_report {
  required_access_grants : [ marketing_can_see ]

  access_filter: {
    field: app_id
    user_attribute: app_id
  }
}

explore: placement_report_agg {
  required_access_grants : [ marketing_can_see ]

  access_filter: {
    field: app_id
    user_attribute: app_id
  }
}

explore: placement_report_list {
  required_access_grants : [ marketing_can_see ]

  access_filter: {
    field: app_id
    user_attribute: app_id
  }
}

explore: placement_conversion_report {
  required_access_grants : [ marketing_can_see ]

  access_filter: {
    field: app_id
    user_attribute: app_id
  }
}
