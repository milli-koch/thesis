view: keywords_clean {
  label: "Keywords"
  sql_table_name: mak_movies.keywords_clean ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }

  dimension: movieid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.movieid ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
