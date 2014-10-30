module UsdaNutrientDatabase
  module Import
    class Nutrients < Base

      private

      def find_or_initialize(row)
        UsdaNutrientDatabase::Nutrient.
          find_or_initialize_by(id: row[0])
      end

      def columns
        @columns ||= [
          :id, :units, :tagname, :description,
          :frac_digits, :sortorder
        ]
      end

      def filename
        'NUTR_DEF.txt'
      end

      def log_import_started
        UsdaNutrientDatabase.log 'Importing nutrients'
      end
    end
  end
end
