connection: "lookerdata_standard_sql"

include: "explores.lkml"

datagroup: mak_datagroup {
  max_cache_age: "1 hour"
  sql_trigger: SELECT CURDATE() ;;
}

persist_with: mak_datagroup
