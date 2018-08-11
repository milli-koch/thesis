view: names {
  sql_table_name: mak_movies.names ;;
  view_label: "Cast and Crew"

  dimension: nconst {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.nconst ;;
  }

# VISIBLE

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    link: {
      label: "IMDb"
      url: "https://www.imdb.com/name/{{ ['nconst'] }}"
      icon_url: "https://imdb.com/favicon.ico"
    }
  }

  measure: count {
    type: count
    drill_fields: [name]
  }

# INVISIBLE

  dimension: birth_year {
    type: string
    sql: ${TABLE}.birth_year ;;
  }

  dimension: death_year {
    type: string
    sql: ${TABLE}.death_year ;;
  }

  dimension: primary_profession {
    type: string
    sql: ${TABLE}.primary_profession ;;
  }

#   dimension: known_for {
#     type: string
#     sql: ${TABLE}.known_for ;;
#   }

}
