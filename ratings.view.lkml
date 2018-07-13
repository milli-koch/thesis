view: ratings {
  sql_table_name: imdb.ratings ;;

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension: director {
    type: string
    sql: ${TABLE}.Director ;;
  }

  dimension: metascore {
    type: number
    sql: ${TABLE}.Metascore ;;
  }

  dimension: rating {
    type: number
    sql: ${TABLE}.Rating ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.Title ;;
  }

  dimension: votes {
    type: number
    sql: ${TABLE}.Votes ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: ratings_full {
  extends: [ratings]

  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }

  dimension: revenue__millions_ {
    type: number
    sql: ${TABLE}.Revenue__Millions_ ;;
  }

  dimension: runtime__minutes_ {
    type: number
    sql: ${TABLE}.Runtime__Minutes_ ;;
  }

  dimension: genre {
    type: string
    sql: ${TABLE}.Genre ;;
  }

  dimension: actors {
    type: string
    sql: ${TABLE}.Actors ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.Rank ;;
  }

}
