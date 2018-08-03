view: production_companies {
  sql_table_name: mak_movies.production_companies ;;
  view_label: "Movies"

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

# VISIBLE

  dimension: production_company {
    type: string
    sql: ${TABLE}.production_company ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }

# INVISBLE

  dimension: movieid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.movieid ;;
  }

}
