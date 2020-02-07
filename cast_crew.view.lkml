view: cast_crew {
  view_label: "Cast and Crew"
  derived_table: {
    sql: select * from `lookerdata.mak_movies.cast_crew`
    where category not in ("director", "writer");;
    datagroup_trigger: mak_datagroup
  }

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
