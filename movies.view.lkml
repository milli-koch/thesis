view: movies {
  sql_table_name: mak_movies.movies ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

# VISIBLE

  dimension: budget {
    type: number
    sql: ${TABLE}.budget ;;
    value_format_name: usd
  }

  dimension: original_language {
    type: string
    sql: ${TABLE}.original_language ;;
  }

  dimension: original_title {
    type: string
    sql: ${TABLE}.original_title ;;
  }

  dimension: overview {
    type: string
    sql: ${TABLE}.overview ;;
  }

  dimension_group: release {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      year,
      day_of_year,
      month_name,
      day_of_week
    ]
    convert_tz: no
    sql: ${TABLE}.release_date ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: runtime {
    type: number
    sql: ${TABLE}.runtime ;;
  }

  dimension: runtime_tier {
    type: tier
    tiers: [60, 90, 120]
    style: integer
    sql: ${runtime} ;;
  }

  dimension: tagline {
    type: string
    sql: ${TABLE}.tagline ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
    link: {
      label: "IMDb"
      url:"https://www.imdb.com/title/{{ ['movies.imdbid'] }}"
      icon_url: "https://imdb.com/favicon.ico"
    }
    link: {
      label: "{{ ['movies.homepage_link'] }}"
      url: "{{ ['movies.homepage'] }}"
    }
    link: {
      label: "TMDb"
      url: "https://www.themoviedb.org/movie/{{ ['movies.id'] }}"
    }
  }

  measure: tmdb_vote_count {
    view_label: "Ratings"
    type: sum
    sql: ${vote_count} ;;
    drill_fields: [title, tmdb_rating]
  }

  measure: count {
    type: count
    drill_fields: [title]
  }

  measure: average_budget {
    type: average
    sql: ${budget} ;;
    value_format_name: usd
    drill_fields: [title, average_budget]
  }

  measure: average_popularity {
    type: average
    sql: ${popularity} ;;
    value_format_name: decimal_2
    drill_fields: [title, average_popularity]
  }

  measure: average_revenue {
    type: average
    sql: ${revenue} ;;
    value_format_name: usd
    drill_fields: [title, average_revenue]
  }

  measure: total_revenue {
    type: sum
    sql: ${revenue};;
    value_format_name: usd
    drill_fields: [title, total_revenue]
  }

  measure: average_runtime {
    type: average
    sql: ${runtime} ;;
    value_format_name: decimal_2
    drill_fields: [title, average_runtime]
  }

# INVISIBLE

  dimension: has_homepage{
    hidden: yes
    type: yesno
    sql: ${homepage} is not null ;;
  }

  dimension: homepage_link {
    hidden: yes
    sql: CASE WHEN ${has_homepage} THEN "Homepage" ELSE "∅" END ;;
  }

  dimension: vote_avg {
    hidden: yes
    type: number
    sql: ${TABLE}.vote_average ;;
  }

  measure: tmdb_rating {
    hidden: yes
    type: average
    sql: ${vote_avg} ;;
  }

  measure: average_rating {
    hidden: yes
    type: number
    sql: (${imdb_ratings.imdb_rating}+${movies.tmdb_rating})/2 ;;
  }

  dimension: vote_count {
    hidden: yes
    type: number
    sql: ${TABLE}.vote_count ;;
  }

  dimension: status {
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: homepage {
    hidden: yes
    type: string
    sql: ${TABLE}.homepage ;;
  }

  dimension: imdbid {
    hidden: yes
    type: string
    sql: ${TABLE}.imdbid ;;
  }

  dimension: popularity {
    hidden: yes
    type: number
    sql: ${TABLE}.popularity ;;
  }
}

view: movies_full {
  extends: [movies]

  dimension: genres {
    type: string
    sql: ${TABLE}.genres ;;
  }

  dimension: spoken_languages {
    type: string
    sql: ${TABLE}.spoken_languages ;;
  }
  dimension: poster_path {
    type: string
    sql: ${TABLE}.poster_path ;;
  }

  dimension: production_companies {
    type: string
    sql: ${TABLE}.production_companies ;;
  }

  dimension: production_countries {
    type: string
    sql: ${TABLE}.production_countries ;;
  }

  dimension: belongs_to_collection {
    type: string
    sql: ${TABLE}.belongs_to_collection ;;
  }

}
