view: writers {
  derived_table: {
    sql: SELECT name as writer, birth_year, death_year, movie_id
      from `lookerdata.mak_movies.writers`
      join `lookerdata.mak_movies.names`
      on `lookerdata.mak_movies.writers`.writer_id = `lookerdata.mak_movies.names`.id
      group by 1,2,3,4
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: writer {
    type: string
    sql: ${TABLE}.writer ;;
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
    fields: [writer, birth_year, death_year, movie_id]
  }
}
