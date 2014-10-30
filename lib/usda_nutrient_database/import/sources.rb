module UsdaNutrientDatabase
  module Import
    class Sources < Base

      private

      def find_or_initialize(row)
        UsdaNutrientDatabase::Source.find_or_initialize_by(id: row[0])
      end

      def columns
        [:id, :description]
      end

      def log_import_started
        UsdaNutrientDatabase.log 'Source import started'
      end

      def filename
        'SRC_CD.txt'
      end
    end
  end
end
