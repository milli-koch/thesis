view: sql_runner_query_2 {
  derived_table: {
    sql: SELECT cast(yesno as bool) FROM `lookerdata.mak_movies.boolean_test` LIMIT 10
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: f0_ {
    type: string
    sql: ${TABLE}.f0_ ;;
  }

  set: detail {
    fields: [f0_]
  }
}
