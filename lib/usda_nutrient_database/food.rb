module UsdaNutrientDatabase
  class Food < ActiveRecord::Base
    self.table_name = 'usda_foods'

    validates :food_group_id, presence: true

    validates :desc_full, presence: true
    validates :desc_abbr, presence: true

    has_many :footnotes,       class_name: 'UsdaNutrientDatabase::Footnote',      foreign_key: :nutrient_id
    has_many :weights,         class_name: 'UsdaNutrientDatabase::Weight',        foreign_key: :nutrient_id
    has_many :foods_nutrients, class_name: 'UsdaNutrientDatabase::FoodsNutrient', foreign_key: :nutrient_id, dependent: :nullify
    has_many :nutrients,       class_name: 'UsdaNutrientDatabase::Nutrient',      through: :foods_nutrients
    belongs_to :food_group,    class_name: 'UsdaNutrientDatabase::FoodGroup',     foreign_key: :food_group_id
  end
end
