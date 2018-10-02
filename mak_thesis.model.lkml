connection: "lookerdata_standard_sql"

include: "*.view"

datagroup: mak_datagroup {
  max_cache_age: "1 hour"
  sql_trigger: SELECT CURDATE() ;;
}

persist_with: mak_datagroup

explore: movies{
  persist_with: mak_datagroup
#   extends: [custom_functions]

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

#   join: topn {
#     sql_on: ${directors.name} = ${topn.name} ;;
#     relationship: one_to_one
#   }
}

# explore: custom_functions {
#   persist_with: mak_datagroup
#   extension: required
#   sql_preamble:
#
#      -- take a dimension, number pair and aggregate as a sum
#       CREATE TEMP FUNCTION pairs_sum(a ARRAY<STRUCT<key STRING, value FLOAT64>>)
#       RETURNS ARRAY<STRUCT<key STRING, value FLOAT64>> AS ((
#         SELECT
#            ARRAY_AGG(STRUCT(key,total_value as value))
#         FROM (
#           SELECT
#             key
#             , SUM(value) as total_value
#           FROM UNNEST(a)
#           GROUP BY 1
#           ORDER BY 2 DESC
#         )
#       ));
#
#       -- convert a array to a shortened array with an 'Other'.  Keep the ordering by Num and make other last
#       --  by using a row number.
#       CREATE TEMP FUNCTION pairs_top_n(a ARRAY<STRUCT<key STRING, value FLOAT64>>, n INT64, use_other BOOL)
#       RETURNS ARRAY<STRUCT<key STRING, value FLOAT64>> AS ((
#         SELECT
#           ARRAY(
#             SELECT
#               STRUCT(key2 as key ,value2 as value)
#             FROM (
#               SELECT
#                 CASE WHEN rn <= n THEN key ELSE 'Other' END as key2
#                 , CASE WHEN rn <= n THEN n ELSE n + 1 END as n2
#                 , SUM(value) as value2
#               FROM (
#                 SELECT
#                   ROW_NUMBER() OVER() as rn
#                   , *
#                 FROM UNNEST(a)
#                 ORDER BY value DESC
#               )
#               GROUP BY 1,2
#               ORDER BY 2
#             ) as t
#             WHERE key2 <> 'Other' or use_other
#             ORDER BY n2
#           )
#       ));
#
#
#       -- take a set of string, number pairs and convert the number to percentage of max or total
#       -- pass 'total' or 'max' as type to change behaviour
#       CREATE TEMP FUNCTION pairs_convert_percentage(a ARRAY<STRUCT<key STRING, value FLOAT64>>,type STRING)
#       RETURNS ARRAY<STRUCT<key STRING, value FLOAT64>> AS ((
#         SELECT
#           ARRAY_AGG(STRUCT(key,new_value as value))
#         FROM (
#           SELECT
#             key
#             , 100.0*value/total
#              as new_value
#           FROM UNNEST(a)
#           CROSS JOIN (
#             SELECT
#               CASE
#                WHEN type='total' THEN SUM(b.value)
#                WHEN type='max' THEN MAX(b.value)
#               END
#               as total FROM UNNEST(a) as b
#           ) as t
#           ORDER BY 2 DESC
#         )
#       ));
#
#       -- formats a STR N into String(number)
#       CREATE TEMP FUNCTION format_result(key STRING, value FLOAT64, format_str STRING)
#       RETURNS STRING AS ((
#         SELECT
#            CONCAT(key, '(',
#             CASE
#               WHEN format_str = 'decimal_0'
#                 THEN FORMAT("%0.0f", value)
#               WHEN format_str = 'percent_0'
#                 THEN FORMAT("%0.2f%%", value)
#             END,
#             ')' )
#       ));
#
#       -- convert pairs into a string ('Other' is always last)
#       CREATE TEMP FUNCTION pairs_to_string(a ARRAY<STRUCT<key STRING, value FLOAT64>>, format_str STRING)
#       RETURNS STRING AS ((
#         SELECT
#           STRING_AGG(value2,", ")
#         FROM (
#           SELECT (
#             format_result(key,value,format_str)) as value2
#             ,rn
#           FROM (
#             SELECT
#               ROW_NUMBER() OVER (ORDER BY CASE WHEN key='Other' THEN -1 ELSE value END DESC) as rn
#               , *
#             FROM
#               UNNEST(a)
#           )
#           ORDER BY rn
#         )
#       ));
#
#       -- take pairs sum, topn then and convert to a string
#       CREATE TEMP FUNCTION pairs_sum_top_n(a ARRAY<STRUCT<key STRING, value FLOAT64>>, n INT64)
#       RETURNS STRING AS ((
#         pairs_to_string( pairs_top_n(pairs_convert_percentage(pairs_sum(a),'total'), n, true), 'percent_0' )
#       ));
#
#   ;;
# }
