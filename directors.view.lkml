view: directors {
  derived_table: {
    sql: SELECT name as director, birth_year, death_year, movie_id
      from `lookerdata.mak_movies.directors`
      join `lookerdata.mak_movies.names`
      on `lookerdata.mak_movies.directors`.director_id = `lookerdata.mak_movies.names`.nconst
      group by 1,2,3,4
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: director {
    type: string
    sql: ${TABLE}.director ;;
  }

  dimension: birth_year {
    type: string
    sql: ${TABLE}.birth_year ;;
  }

  dimension: death_year {
    type: string
    sql: ${TABLE}.death_year ;;
  }

  dimension: movie_id {
    type: string
    sql: ${TABLE}.movie_id ;;
  }

  set: detail {
    fields: [director, birth_year, death_year, movie_id]
  }
}
