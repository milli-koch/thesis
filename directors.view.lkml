view: directors {
  derived_table: {
    sql: SELECT row_number() over (order by name) as id, director_id, name,
    case when birth_year like '%N' then null else birth_year end as birth_year,
    death_year, movie_id
      from `lookerdata.mak_movies.directors`
      join `lookerdata.mak_movies.names`
      on `lookerdata.mak_movies.directors`.director_id = `lookerdata.mak_movies.names`.nconst
      group by 2,3,4,5,6
       ;;
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
    link: {
      label: "IMDb"
      url: "https://www.imdb.com/name/{{ ['director_id'] }}"
      icon_url: "https://imdb.com/favicon.ico"
    }
  }

  dimension: birth_year {
    type: number
    sql: cast(${TABLE}.birth_year as int64);;
    }

  dimension: death_year {
    type: string
    sql: ${TABLE}.death_year ;;
  }

  dimension: age {
    type: number
    sql: ${movies.release_year} - ${birth_year} ;;
  }

  measure: years_active {
    type: number
    sql: ${movies.release_year} - min(${movies.release_year}) ;;
  }

  measure: count {
    type: count
    drill_fields: [directors.name, movies.title]
  }


# INVISIBLE

  dimension: director_id {
    hidden: yes
    type: string
    sql: ${TABLE}.director_id ;;
  }

  dimension: movie_id {
    hidden: yes
    type: string
    sql: ${TABLE}.movie_id ;;
  }

}
