include: "/views/*.view"
explore: movies{
  persist_with: mak_datagroup

  always_filter: {
    filters: {
      field: title_type.title_type
      value: "movie"
    }
    filters: {
      field: imdb_ratings.vote_count
      value: "> 5000"
    }
    filters: {
      field: movies.vote_count
      value: ">1000"
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

  join: director_movie_mapping {
    sql_on: ${movies.imdbid} = ${director_movie_mapping.imdbid} ;;
    relationship:one_to_one
    fields: []
  }

  join: directors {
    sql_on: ${director_movie_mapping.director_id} = ${directors.director_id} ;;
    relationship: many_to_one
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
    relationship: one_to_many
    type: left_outer
    fields: [title_type.title_type]
  }

  join: cast_crew {
    sql_on: ${movies.imdbid} = ${cast_crew.tconst} ;;
    relationship: many_to_many
    fields: [cast_crew.job]
  }

  join: names {
    sql_on: ${cast_crew.nconst} = ${names.nconst};;
    relationship: one_to_one
    fields: [names.name, names.nconst, names.birth_year, names.death_year, names.count]
  }

  join: ratings_tier {
    sql_on: ${movies.imdbid} = ${ratings_tier.movieid} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: topn {
    sql_on: ${directors.director_id} = ${topn.director_id} ;;
    relationship: one_to_one
  }
}
