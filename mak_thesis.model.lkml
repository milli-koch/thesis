connection: "lookerdata_standard_sql"

include: "explores.lkml"

datagroup: mak_datagroup {
  max_cache_age: "1 hour"
  sql_trigger: SELECT FLOOR((TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),'1970-01-01 00:00:00',SECOND)) / (2*60*60)) ;;
}

persist_with: mak_datagroup
