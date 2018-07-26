view: names {
  sql_table_name: mak_movies.names ;;

  dimension: id {
    primary_key: yes
    hidden: no
    type: string
    sql: ${TABLE}.nconst ;;
  }

  dimension: birth_year {
    type: string
    sql: ${TABLE}.birth_year ;;
  }

  dimension: death_year {
    type: string
    sql: ${TABLE}.death_year ;;
  }

#   dimension: known_for {
#     type: string
#     sql: ${TABLE}.known_for ;;
#   }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: primary_profession {
    type: string
    sql: ${TABLE}.primary_profession ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
