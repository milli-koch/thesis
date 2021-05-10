view: title_type {
  sql_table_name: mak_movies.title_type ;;

# VISIBILE

  dimension: title_type {
    view_label: "Movies"
    type: string
    sql: ${TABLE}.title_type ;;
  }

# INVISIBLE

  dimension: end_year {
    type: string
    sql: ${TABLE}.end_year ;;
  }

  dimension: genres {
    type: string
    sql: ${TABLE}.genres ;;
  }

  dimension: is_adult {
    type: string
    sql: ${TABLE}.is_adult ;;
  }

  dimension: orig_title {
    type: string
    sql: ${TABLE}.orig_title ;;
  }

  dimension: runtime {
    type: string
    sql: ${TABLE}.runtime ;;
  }

  dimension: start_year {
    type: string
    sql: ${TABLE}.start_year ;;
  }

  dimension: tconst {
    primary_key: yes
    type: string
    sql: ${TABLE}.tconst ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
