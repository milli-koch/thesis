view: collections {
  sql_table_name: mak_movies.collections ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

# VISIBLE

  dimension: collection {
    type: string
    sql: ${TABLE}.collection ;;
  }

  measure: count {
    type: count
    drill_fields: [movies.title]
  }

# INVISIBLE

  dimension: movieid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.movieid ;;
  }

}
