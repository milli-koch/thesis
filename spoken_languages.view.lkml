view: spoken_languages {
  sql_table_name: mak_movies.spoken_languages ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

# VISBIBLE

  dimension: spoken_language {
    type: string
    sql: ${TABLE}.spoken_language ;;
  }

  measure: count {
    type: count
    drill_fields: [movies.title, spoken_language]
  }

# INVISBLE

  dimension: movieid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.movieid ;;
  }

}
