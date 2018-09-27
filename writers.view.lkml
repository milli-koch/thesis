view: writers {
  sql_table_name: mak_movies.writers ;;

  dimension: prim_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

# VISIBLE

  dimension: name {
    type: string
    sql: ${TABLE}.names_name ;;
  }

  dimension: birth_year {
    type: string
    sql: cast(${TABLE}.birth_year as int64) ;;
  }

  dimension: death_year {
    type: string
    sql: ${TABLE}.death_year ;;
  }

  dimension: age {
    type: number
    sql: cast(${movies.release_year} as int64) - ${birth_year} ;;
  }

  measure: writers {
    type: list
    list_field: writers.name
  }

  measure: count {
    type: count
    drill_fields: [name, movies.title]
  }

# INVISIBLE

  dimension: writer_id {
    hidden: yes
    type: string
    sql: ${TABLE}.writer_id ;;
  }

  dimension: movie_id {
    hidden: no
    type: string
    sql: ${TABLE}.movie_id ;;
  }

}
