view: spoken_languages {
  sql_table_name: mak_movies.spoken_languages ;;
  view_label: "Movies"

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

  measure: language_count {
    type: count
    drill_fields: [movies.title]
  }

# INVISBLE

  dimension: movieid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.movieid ;;
  }

}
