view: director_facts {
  view_label: "Directors"
  derived_table: {
    sql:select director_id, name, min(movies.release_date) as first_movie,
      min(movie_id) as movie_id
      from ${directors.SQL_TABLE_NAME} join ${movies.SQL_TABLE_NAME}
      on movies.imdbid = directors.movie_id
      join mak_movies.title_type
      on title_type.tconst = movies.imdbid
      where title_type.title_type = 'movie'
      group by 1,2;;
  }

  dimension: director_id {
    primary_key: yes
    hidden: yes
  }

# VISIBLE

  dimension: is_first_movie {
    type: yesno
    sql: movies.release_date = first_movie;;
  }

# INVISIBLE

  dimension: name {
    hidden: yes
  }

  dimension: movie_id {
    hidden: yes
  }

  dimension: first_movie {
    type: number
    hidden: yes
  }

}
