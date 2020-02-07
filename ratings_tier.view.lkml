view: ratings_tier {
  view_label: "Ratings"
  derived_table: {
    sql: select movie_id, rating from
      (select imdb.tconst as movie_id, (avg(imdb.avg_rating)+avg(movies.vote_average))/2 as rating
      from mak_movies.movies  join mak_movies.imdb_ratings imdb
      on imdb.tconst = movies.imdbid
      group by 1)
      group by 1,2  ;;
  }

  dimension: movieid {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.movie_id ;;
  }

  dimension: rating {
    hidden: yes
    type: number
    sql: ${TABLE}.rating ;;
  }

  measure: avg_rating {
    hidden: yes
    type: average
    sql: ${rating} ;;
  }

  dimension: curved_rating {
    hidden: yes
    type: number
    sql: ${rating} + 1.1 ;;
    value_format_name: decimal_2
  }

  measure: average_rating  {
    hidden: yes
    type: average
    sql: ${curved_rating} ;;
  }

  dimension: truncated_rating {
    hidden: yes
    sql: trunc(${curved_rating}) ;;
  }

  dimension: ratings_tier {
    type: tier
    tiers: [1,2,3,4,5,6,7,8,9]
    style: integer
    sql: ${truncated_rating} ;;
  }
}
