view: imdb_ratings {
  view_label: "Ratings"
  sql_table_name: imdb_rating ;;

  dimension: tconst {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.tconst ;;
  }

# VISIBLE

  dimension: ratings_tier {
    type: tier
    tiers: [1,2,3,4,5,6,7,8,9]
    style: integer
#     sql: ${rating_trunc} ;;
  }

  dimension: vote_count {
    label: "IMDb Vote Count"
    view_label: "Ratings"
    type: number
    sql: ${TABLE}.vote_count ;;
  }

  parameter: rating_selector {
    description: "Use with Ratings measure"
    type: string
    allowed_value: {
      label: "IMDb Rating"
      value: "imdb_rating"
    }
    allowed_value: {
      label: "TMDb Rating"
      value: "tmdb_rating"
    }
    allowed_value: {
      label: "Average Rating"
      value: "average_rating"
    }
  }

  measure: rating {
    description: "Use with Rating Selector"
    label_from_parameter: rating_selector
    type: number
    value_format_name: decimal_2
    sql:
      CASE
      WHEN {% parameter rating_selector %} = 'average_rating' THEN
          ${movies.average_rating}
        WHEN {% parameter rating_selector %} = 'imdb_rating' THEN
          ${imdb_rating}
        WHEN {% parameter rating_selector %} = 'tmdb_rating' THEN
          ${movies.tmdb_rating}
        ELSE
          NULL
      END ;;
      drill_fields: [movies.title, directors.name, movies.average_rating, imdb_ratings.imdb_rating, movies.tmdb_rating]
  }

# INVSIBLE

  dimension: avg_rating {
    hidden: yes
    type: number
    sql: ${TABLE}.avg_rating ;;
  }

  measure: imdb_rating {
    hidden: yes
    type: average
    sql: ${avg_rating} ;;
  }

}
