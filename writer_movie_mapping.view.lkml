view: writer_movie_mapping {
  derived_table: {
    sql: select movies.imdbid, writers.writer_id
          from `lookerdata.mak_movies.movies` as movies
          join `lookerdata.mak_movies.writers` as writers
          on movies.imdbid = writers.movie_id
          group by 1,2
          ;;
    datagroup_trigger: mak_datagroup
  }

  dimension: imdbid {}

  dimension: writer_id {}
}
