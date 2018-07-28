view: writers {
  derived_table: {
    sql: SELECT row_number() over (order by name) as id, writer_id, name, birth_year, death_year, movie_id
      from `lookerdata.mak_movies.writers`
      join `lookerdata.mak_movies.names`
      on `lookerdata.mak_movies.writers`.writer_id = `lookerdata.mak_movies.names`.nconst
      group by 2,3,4,5,6
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: prim_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: writer_id {
    hidden: yes
    type: string
    sql: ${TABLE}.writer_id ;;
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
    hidden: yes
    type: string
    sql: ${TABLE}.movie_id ;;
  }

  set: detail {
    fields: [name, movies.title]
  }
}
