view: imdb_ratings {
  sql_table_name: mak_movies.imdb_ratings ;;
  view_label: "Ratings"

  dimension: avg_rating {
    hidden: yes
    type: number
    sql: ${TABLE}.avg_rating ;;
  }

  measure: imdb_rating {
    type: average
    sql: ${avg_rating} ;;
    value_format_name: decimal_1
    drill_fields: [movies.title, imdb_rating, imdb_vote_count]
  }

  dimension: tconst {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.tconst ;;
  }

  dimension: vote_count {
    hidden: yes
    type: number
    sql: ${TABLE}.vote_count ;;
  }

  measure: imdb_vote_count {
    type: sum
    sql: ${vote_count} ;;
  }

  measure: average_rating {
    type: number
    sql: (${imdb_rating}+${movies.tmdb_rating})/2 ;;
    value_format_name: decimal_2
    drill_fields: [movies.title, directors.name, imdb_rating, movies.tmdb_rating]
  }

}
