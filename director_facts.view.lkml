view: director_facts {
  view_label: "Directors"
  derived_table: {
  sql:select director_id, name, min((CAST(movies.release_date  AS DATE))) as first_movie,
min(movie_id) as movie_id
from ${directors.SQL_TABLE_NAME} join ${movies.SQL_TABLE_NAME}
on movies.imdbid = directors.movie_id
join mak_movies.title_type
on title_type.tconst = movies.imdbid
where title_type = 'movie'
group by 1,2;;
  }

# VISIBLE

  dimension: is_first_movie {
    type: yesno
    sql: CAST(movies.release_date  AS DATE) = first_movie;;
  }

# INVISIBLE

  dimension: director_id {
    primary_key: yes
    hidden: yes
  }

  dimension: name {
    hidden: yes
  }

  dimension: movie_id {
    hidden: yes
  }

  dimension: first_movie {
    hidden: yes
  }

}
