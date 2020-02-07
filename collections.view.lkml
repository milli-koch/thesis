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
    sql: rtrim(${TABLE}.collection, "Collection") ;;
  }


  measure: count {
    type: count
    drill_fields: [movies.title, collection]
  }

# INVISIBLE

  dimension: movieid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.movieid ;;
  }

}
