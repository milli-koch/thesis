view: movies {
  sql_table_name: mak_movies.movies ;;

  dimension: id {
    primary_key: yes
    hidden: no
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: belongs_to_collection {
    type: string
    sql: ${TABLE}.belongs_to_collection ;;
  }

  dimension: budget {
    type: number
    sql: ${TABLE}.budget ;;
    value_format_name: usd
  }

  measure: average_budget {
    type: average
    sql: ${budget} ;;
    value_format_name: usd
  }

  dimension: homepage {
    type: string
    sql: ${TABLE}.homepage ;;
  }

  dimension: imdbid {
    hidden: yes
    type: string
    sql: ${TABLE}.imdbid ;;
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

  dimension: popularity {
    type: number
    sql: ${TABLE}.popularity ;;
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
    datatype: date
    sql: ${TABLE}.release_date ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  measure: average_revenue {
    type: average
    sql: ${revenue} ;;
    value_format_name: usd
  }

  measure: total_revenue {
    type: sum
    sql: ${revenue};;
    value_format_name: usd
  }

  dimension: runtime {
    type: number
    sql: ${TABLE}.runtime ;;
  }

  measure: average_runtime {
    type: average
    sql: ${runtime} ;;
    value_format_name: decimal_2
  }

  dimension: status {
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
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

  dimension: has_homepage{
    hidden: yes
    type: yesno
    sql: ${homepage} is not null ;;
  }

  dimension: homepage_link {
    hidden: yes
    sql: CASE WHEN ${has_homepage} THEN "Homepage" ELSE "∅" END ;;
  }

  measure: vote_average {
    type: average
    sql: ${TABLE}.vote_average ;;
    value_format_name: decimal_2
  }

  dimension: vote_count {
    hidden: yes
    type: number
    sql: ${TABLE}.vote_count ;;
  }

  measure: total_vote_count {
    type: sum
    sql: ${vote_count} ;;
  }

  measure: movie_count {
    type: count
    drill_fields: [title]
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
}
