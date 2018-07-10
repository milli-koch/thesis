connection: "lookerdata_standard_sql"

# include all the views
include: "*.view"

datagroup: mak_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: mak_thesis_default_datagroup

explore: keywords {}

explore: movies {}
