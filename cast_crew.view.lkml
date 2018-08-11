view: cast_crew {
  sql_table_name: mak_movies.cast_crew ;;
  view_label: "Cast and Crew"

# VISIBLE

  dimension: job {
    type: string
    sql: ${TABLE}.category ;;
  }

# INVISIBLE

  dimension: characters {
    type: string
    sql: ${TABLE}.characters ;;
  }

  dimension: nconst {
    type: string
    sql: ${TABLE}.nconst ;;
  }

  dimension: ordering {
    type: string
    sql: ${TABLE}.ordering ;;
  }

  dimension: tconst {
    type: string
    sql: ${TABLE}.tconst ;;
  }

}
