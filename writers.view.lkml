view: writers {
  derived_table: {
    sql: SELECT row_number() over (order by name) as id, writer_id, name,
    case when birth_year like '%N' then null else birth_year end as birth_year, death_year, movie_id
      from `lookerdata.mak_movies.writers`
      join `lookerdata.mak_movies.names`
      on `lookerdata.mak_movies.writers`.writer_id = `lookerdata.mak_movies.names`.nconst
      group by 2,3,4,5,6;;
    datagroup_trigger: mak_datagroup
  }

  dimension: prim_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

# VISIBLE

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
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
    list_field: name
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
    hidden: yes
    type: string
    sql: ${TABLE}.movie_id ;;
  }

}
