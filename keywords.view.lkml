view: keywords {
  sql_table_name: mak_movies.keywords ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: keywords {
    type: string
    sql: ${TABLE}.keywords ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
