view: ratings_tier {
  view_label: "Ratings"
  derived_table: {
    sql: select imdb_ratings.tconst,
    trunc(((AVG(imdb_ratings.avg_rating ))+(AVG(movies.vote_average )))/2) as rating
from mak_movies.movies  join mak_movies.imdb_ratings
on imdb_ratings.tconst = movies.imdbid
group by imdb_ratings.tconst  ;;
  }

  dimension: movieid {
    sql: ${TABLE}.tconst ;;
  }

  dimension: truncated_rating {
    sql: ${TABLE}.rating ;;
  }


  dimension: ratings_tier {
    type: tier
    tiers: [1,2,3,4,5,6,7,8,9]
    style: integer
    sql: ${truncated_rating} ;;
  }
}
