view: crew {
  sql_table_name: mak_movies.crew ;;

  dimension: director_id {
    type: string
    sql: ${TABLE}.string_field_1 ;;
  }

  dimension: movie_id {
    type: string
    sql: ${TABLE}.string_field_0 ;;
  }

  dimension: writer_id {
    type: string
    sql: ${TABLE}.string_field_2 ;;
  }

}
