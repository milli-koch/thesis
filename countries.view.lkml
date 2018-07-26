view: countries {
  derived_table: {
    sql: SELECT `lookerdata.mak_movies.production_countries`.id as row_id, sub.id as country_id,
    `lookerdata.mak_movies.production_countries`.production_country, code, movieid
      FROM
      (SELECT row_number() over(order by production_country) as id, production_country
          FROM `lookerdata.mak_movies.production_countries` group by production_country) as sub
          inner join `lookerdata.mak_movies.production_countries`
          on `lookerdata.mak_movies.production_countries`.production_country = sub.production_country
          left join `lookerdata.mak_movies.country_codes`
          on sub.id = `lookerdata.mak_movies.country_codes`.id
          order by row_id
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: row_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.row_id ;;
  }

  dimension: country_id {
    hidden: yes
    type: number
    sql: ${TABLE}.country_id ;;
  }

  dimension: production_country {
    type: string
    sql: ${TABLE}.production_country ;;
  }

  dimension: code {
    description: "Use with Map Visualization"
    map_layer_name: countries
    sql: ${TABLE}.code ;;
  }

  dimension: movieid {
    hidden: yes
    type: number
    sql: ${TABLE}.movieid ;;
  }

  set: detail {
    fields: [row_id, country_id, production_country, code, movieid]
  }
}
