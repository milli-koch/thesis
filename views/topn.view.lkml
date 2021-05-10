view: topn {
  derived_table: {
    sql:select director_id, (rating + 1.1) as rating from
      (select directors.director_id, (avg(imdb.avg_rating)+avg(movies.vote_average))/2 as rating
      from mak_movies.movies  join mak_movies.imdb_ratings imdb
      on imdb.tconst = movies.imdbid
      join mak_movies.directors
      on movies.imdbid = directors.movie_id
      group by 1)
      group by 1,2  ;;
  }

  dimension: director_id {
    primary_key: yes
  }

  dimension: rating {
    type: number
  }

#   measure: top_5_directors {
#     description: "Top 5 Directors Based on Average IMDB Rating"
#     type: string
#     sql: pairs_sum_top_n(ARRAY_AGG(STRUCT(${name} as key, ${average_rating} as value)), 5) ;;
#     drill_fields: [directors.name, imdb_ratings.avg_rating]
#   }

}

# explore: topn {}
