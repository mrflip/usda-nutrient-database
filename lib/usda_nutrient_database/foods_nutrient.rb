module UsdaNutrientDatabase
  class FoodsNutrient < ActiveRecord::Base
    self.table_name = 'usda_foods_nutrients'

    validates :food_id,     presence: true,  uniqueness: { scope: :nutrient_id, allow_blank: true }
    validates :nutrient_id, presence: true,  uniqueness: { scope: :food_id, allow_blank: true }
    validates :val,         presence: true,  numericality: true
    validates :source_id,   presence: true,  numericality: true

    belongs_to :food,       class_name: 'UsdaNutrientDatabase::Food',       foreign_key: :food_id
    belongs_to :nutrient,   class_name: 'UsdaNutrientDatabase::Nutrient',   foreign_key: :nutrient_id
    belongs_to :source,     class_name: 'UsdaNutrientDatabase::Source',     foreign_key: :source_id
  end
end
