module UsdaNutrientDatabase
  module Import
    class FoodsNutrients < Base

      private

      def columns
        [
          :food_id, :nutrient_id, :val,
          :num_data_points, :standard_error, :source_id, :derivation_code,
          :ref_food_id, :enrichment, :num_studies, :min,
          :max, :degrees_of_freedom, :lower_error_bound, :upper_error_bound,
          :statistical_comments, :add_mod_date
        ]
      end

      def find_or_initialize(row)
        UsdaNutrientDatabase::FoodsNutrient.find_or_initialize_by(
          id: (row[0].to_i * 10_000 + row[1].to_i),
          food_id: row[0], nutrient_id: row[1]
        )
      end

      def filename
        'NUT_DATA.txt'
      end

      def log_import_started
        UsdaNutrientDatabase.log 'Importing foods_nutrients'
      end
    end
  end
end


# LOAD DATA INFILE '/Users/flip/ics/site/eatlesswell/tmp/usda/sr27/NUT_DATA.txt'
#   REPLACE INTO TABLE usda_foods_nutrients_copy CHARACTER SET 'latin1'
#     FIELDS TERMINATED BY '^' OPTIONALLY ENCLOSED BY '~' LINES TERMINATED BY '\r\n'
#         (food_id, nutrient_id, val, num_data_points, @standard_error, @source_id, derivation_code, @ref_food_id, @enrichment, @num_studies, @min, @max, @degrees_of_freedom, @lower_error_bound, @upper_error_bound, @statistical_comments, @add_mod_date, @confidence_code)
#         SET id = (food_id * 10000 + nutrient_id),
#           standard_error               = IF(@standard_error='', NULL, @standard_error),
#           source_id                    = IF(@source_id='', NULL, @source_id),
#           ref_food_id                  = IF(@ref_food_id='', NULL, @ref_food_id),
#           enrichment                   = IF(@enrichment='', NULL, @enrichment),
#           num_studies                  = IF(@num_studies='', NULL, @num_studies),
#           min                          = IF(@min='', NULL, @min),
#           max                          = IF(@max='', NULL, @max),
#           degrees_of_freedom           = IF(@degrees_of_freedom='', NULL, @degrees_of_freedom),
#           lower_error_bound            = IF(@lower_error_bound='', NULL, @lower_error_bound),
#           upper_error_bound            = IF(@upper_error_bound='', NULL, @upper_error_bound),
#           statistical_comments         = IF(@statistical_comments='', NULL, @statistical_comments),
#           add_mod_date                 = IF(@add_mod_date='', NULL, @add_mod_date),
#           confidence_code              = IF(@confidence_code='', NULL, @confidence_code),
#           created_at = TIMESTAMP( IF(@add_mod_date='', '2014-08-02', CONCAT(RIGHT(@add_mod_date,4),'-',LEFT(@add_mod_date,2),'-01'))),
#           updated_at = TIMESTAMP( IF(@add_mod_date='', '2014-08-02', CONCAT(RIGHT(@add_mod_date,4),'-',LEFT(@add_mod_date,2),'-01')))
#           ;

# SELECT uc.id, uu.id, uc.nutrient_databank_number, uu.nutrient_databank_number, uc.nutrient_number, uu.nutrient_number, uc.nutrient_value, uu.nutrient_value, uc.num_data_points, uu.num_data_points, uc.standard_error, uu.standard_error, uc.src_code, uu.src_code, uc.derivation_code, uu.derivation_code, uc.ref_nutrient_databank_number, uu.ref_nutrient_databank_number, uc.add_nutrient_mark, uu.add_nutrient_mark, uc.num_studies, uu.num_studies, uc.min, uu.min, uc.max, uu.max, uc.degrees_of_freedom, uu.degrees_of_freedom, uc.lower_error_bound, uu.lower_error_bound, uc.upper_error_bound, uu.upper_error_bound, uc.statistical_comments, uu.statistical_comments, uc.add_mod_date, uu.add_mod_date, uc.confidence_code, uu.confidence_code FROM usda_foods_nutrients_copy uc, usda_foods_nutrients uu
#         WHERE uc.id = uu.id
#         AND   ((uu.id != uc.id) OR (uu.nutrient_databank_number != uc.nutrient_databank_number) OR (uu.nutrient_number != uc.nutrient_number) OR (uu.nutrient_value != uc.nutrient_value) OR (uu.num_data_points != uc.num_data_points) OR (uu.standard_error != uc.standard_error) OR (uu.src_code != uc.src_code) OR (uu.derivation_code != uc.derivation_code) OR (uu.ref_nutrient_databank_number != uc.ref_nutrient_databank_number) OR (uu.add_nutrient_mark != uc.add_nutrient_mark) OR (uu.num_studies != uc.num_studies) OR (uu.min != uc.min) OR (uu.max != uc.max) OR (uu.degrees_of_freedom != uc.degrees_of_freedom) OR (uu.lower_error_bound != uc.lower_error_bound) OR (uu.upper_error_bound != uc.upper_error_bound) OR (uu.statistical_comments != uc.statistical_comments) OR (uu.add_mod_date != uc.add_mod_date) OR (uu.confidence_code != uc.confidence_code))
#         LIMIT 100

# id
# food_id
# nutrient_id
# val
# num_data_points
# standard_error
# src_code
# derivation_code
# ref_food_id
# enrichment
# num_studies
# min
# max
# degrees_of_freedom
# lower_error_bound
# upper_error_bound
# statistical_comments
# add_mod_date
# confidence_code
