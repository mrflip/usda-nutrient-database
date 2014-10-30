module UsdaNutrientDatabase
  class Footnote < ActiveRecord::Base
    self.table_name = 'usda_footnotes'

    validates :food_id,      presence: true # , uniqueness: { allow_blank: true }
    # validates :nutrient_id,                  numericality: { allow_blank: true }
    validates :seq,          presence: true
    validates :kind,         presence: true
    validates :body,         presence: true

    belongs_to :food,     class_name: 'UsdaNutrientDatabase::Food',   foreign_key: :food_id
    belongs_to :nutrient, class_name: 'UsdaNutrientDatabase::Nutrient',    foreign_key: :nutrient_id
  end
end
