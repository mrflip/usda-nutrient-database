module UsdaNutrientDatabase
  module Import
    class FoodGroups < Base

      private

      def find_or_initialize(row)
        UsdaNutrientDatabase::FoodGroup.find_or_initialize_by(id: row[0])
      end

      def columns
        @columns ||= %w(id description)
      end

      def filename
        'FD_GROUP.txt'
      end

      def log_import_started
        UsdaNutrientDatabase.log 'Importing food groups'
      end
    end
  end
end
