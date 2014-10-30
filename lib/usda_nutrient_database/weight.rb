module UsdaNutrientDatabase
  class Weight < ActiveRecord::Base
    self.table_name = 'usda_weights'

    validates :food_id,         presence: true, uniqueness: { scope: :seq     }
    validates :seq,             presence: true, uniqueness: { scope: :food_id }
    validates :amount,          presence: true
    validates :description,     presence: true
    validates :gram_weight,     presence: true
    validates :stddev,          numericality: { allow_blank: true }

    belongs_to :food, class_name: 'UsdaNutrientDatabase::Food',
      foreign_key: :nutrient_databank_number
  end
end
