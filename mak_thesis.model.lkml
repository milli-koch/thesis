connection: "lookerdata_standard_sql"

include: "*.view"

datagroup: mak_thesis_default_datagroup {
  max_cache_age: "1 hour"
  sql_trigger: SELECT CURDATE() ;;
}

persist_with: mak_thesis_default_datagroup

explore: movies {
  always_filter: {
    filters: {
      field: title_type.title_type
      value: "movie"
    }
  }

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
    type: left_outer
  }

  join: imdb_ratings {
    sql_on: ${movies.imdbid} = ${imdb_ratings.tconst} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: title_type {
    sql_on: ${movies.imdbid} = ${title_type.tconst} ;;
    relationship: one_to_one
    type: left_outer
    fields: [title_type.title_type]
  }

  join: director_facts {
    sql_on: ${movies.imdbid} = ${director_facts.movie_id}
    and ${directors.name} = ${director_facts.name};;
    relationship: many_to_many
    type: left_outer
  }

  join: cast_crew {
    sql_on: ${movies.imdbid} = ${cast_crew.tconst} ;;
    relationship: many_to_many
    fields: [cast_crew.job]
  }

  join: names {
    sql_on: ${cast_crew.nconst} = ${names.nconst};;
    relationship: one_to_one
    fields: [names.name, names.nconst, names.birth_year, names.death_year]
  }

}
