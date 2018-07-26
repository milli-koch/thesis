connection: "lookerdata_standard_sql"

include: "*.view"

datagroup: mak_thesis_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: mak_thesis_default_datagroup

explore: movies {
  sql_always_where: ${movies.title} is not null and ${movies.status} = "Released";;
  join: keywords {
    sql_on: ${movies.id} = ${keywords.movieid} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: genres {
    sql_on: ${movies.id} = ${genres.movieid} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: countries {
    sql_on: ${movies.id} = ${countries.movieid} ;;
    relationship: many_to_one
    type: left_outer
  }

  join: spoken_languages {
    sql_on: ${movies.id} = ${spoken_languages.movieid} ;;
    relationship: one_to_many
    type: full_outer
  }

  join: collections {
    sql_on: ${movies.id} = ${collections.movieid} ;;
    relationship: many_to_one
    type: left_outer
  }

  join: production_companies {
    sql_on: ${movies.id} = ${production_companies.movieid} ;;
    relationship: many_to_many
    type: left_outer
  }

  join: directors {
    sql_on: ${movies.imdbid} = ${directors.movie_id} ;;
    relationship: many_to_many
    type: left_outer
  }

  join: writers {
    sql_on: ${movies.imdbid} = ${writers.movie_id} ;;
    relationship: many_to_many
  }

}

explore: names{}
explore: crew {}
explore: directors {}
