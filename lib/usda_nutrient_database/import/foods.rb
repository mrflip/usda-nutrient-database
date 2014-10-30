# encoding: utf-8

module UsdaNutrientDatabase
  module Import
    class Foods < Base

      private

      def find_or_initialize(row)
        UsdaNutrientDatabase::Food.find_or_initialize_by(
          id: row[0]
          )
      end

      def log_import_started
        UsdaNutrientDatabase.log 'Importing foods'
      end

      def filename
        'FOOD_DES.txt'
      end

      def columns
        [
          :id,  :food_group_id,
          :desc_full, :desc_abbr, :common_names,
          :manufacturer, :survey,
          :refuse_desc, :refuse_pct,
          :nitrogen_factor, :protein_factor, :fat_factor, :carbohydrate_factor
        ]
      end
    end
  end
end
