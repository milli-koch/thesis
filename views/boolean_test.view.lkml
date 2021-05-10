view: boolean_test {
  sql_table_name: mak_movies.boolean_test ;;

  dimension: number {
    type: number
    sql: ${TABLE}.number ;;
  }

  dimension: yesno {
    type: yesno
    sql: ${TABLE}.yesno ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
