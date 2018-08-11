view: movies {
  sql_table_name: mak_movies.movies ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  measure: count_movies {
    type: count_distinct
    sql: ${title} ;;
    drill_fields: [title]
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
      day_of_week,
      week,
      year,
      month_name,
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.release_date ;;
  }

  dimension: decade {
    type: tier
    tiers: [1900,1910,1920,1930,1940,1950,1960,1970,1980,1990,2000,2010]
    style: integer
    sql: ${release_year} ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: runtime {
    description: "In Minutes"
    type: number
    sql: ${TABLE}.runtime ;;
  }

  dimension: runtime_tier {
    type: tier
    tiers: [60, 90, 120, 150]
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
  }

  dimension: popularity {
    type: number
    sql: ${TABLE}.popularity ;;
    value_format_name: decimal_2
  }

  dimension: popularity_tier{
    type: tier
    tiers: [0,5,10,15,20,25,30,35,40,45,50,100,150,200,250,300,350,400,450,500,550]
    style: interval
    sql: ${popularity} ;;
  }

  dimension: vote_count {
    label: "TMDb Vote Count"
    view_label: "Ratings"
    type: number
    sql: ${TABLE}.vote_count ;;
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
    description: "TMDb Popularity Score"
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

#   measure: tmdb_vote_count {
#     view_label: "Ratings"
#     type: sum
#     sql: ${vote_count} ;;
#     drill_fields: [title, tmdb_rating]
#   }
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
