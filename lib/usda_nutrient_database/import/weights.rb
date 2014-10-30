module UsdaNutrientDatabase
  module Import
    class Weights < Base

      private

      def find_or_initialize(row)
        UsdaNutrientDatabase::Weight.find_or_initialize_by(
          id:      (row[0].to_i * 100 + row[1].to_i),
          food_id: row[0],
          seq:     row[1]
        )
      end

      def filename
        'WEIGHT.txt'
      end

      def columns
        @columns ||= [
          :food_id, :seq, :amount,
          :description, :gram_weight, :num_data_points,
          :stddev
        ]
      end

      def log_import_started
        UsdaNutrientDatabase.log 'Importing weights'
      end
    end
  end
end
