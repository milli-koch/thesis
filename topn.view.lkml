view: topn {
  derived_table: {
    explore_source: movies{
      column: name {field:directors.name}
      column: rating {field:ratings_tier.curved_rating}
      derived_column: average_rating {sql:avg(rating);;}
    }
  }

  dimension: name {
    primary_key: yes
  }

  dimension: rating {
    type: number
  }

  dimension: average_rating {
    type: number
  }

  measure: top_5_directors {
    description: "Top 5 Directors Based on Average IMDB Rating"
    type: string
    sql: pairs_sum_top_n(ARRAY_AGG(STRUCT(${name} as key, ${average_rating} as value)), 5) ;;
    drill_fields: [directors.name, imdb_ratings.avg_rating]
  }

}

explore: topn {}
