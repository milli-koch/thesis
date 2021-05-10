view: sql_runner_query {
  derived_table: {
    sql: SELECT * FROM `lookerdata.mak_movies.boolean_test` LIMIT 10
      ;;
  }

  dimension: yesno {
    type: string
    sql: ${TABLE}.yesno ;;
  }

  dimension: number {
    type: number
    sql: ${TABLE}.number ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [number, yesno]
  }
}
