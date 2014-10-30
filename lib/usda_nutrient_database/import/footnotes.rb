module UsdaNutrientDatabase
  module Import
    class Footnotes < Base

      private

      def find_or_initialize(row)
        UsdaNutrientDatabase::Footnote.find_or_initialize_by(
          food_id:     row[0],
          seq:         row[1],
          nutrient_id: row[3]
        )
      end

      def filename
        'FOOTNOTE.txt'
      end

      def columns
        @columns ||= [
          :food_id, :seq, :kind, :nutrient_id, :body
        ]
      end

      def log_import_started
        UsdaNutrientDatabase.log 'Importing footnotes'
      end
    end
  end
end
