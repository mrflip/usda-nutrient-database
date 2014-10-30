module UsdaNutrientDatabase
  class Nutrient < ActiveRecord::Base
    self.table_name = 'usda_nutrients'

    validates :units,         presence: true
    # validates :tagname
    validates :description,   presence: true
    validates :frac_digits,   presence: true
    validates :sortorder,     presence: true,   numericality: { allow_blank: true }

    has_many :foods_nutrients, class_name: 'UsdaNutrientDatabase::FoodsNutrient',  foreign_key: :nutrient_id,  dependent: :nullify
    has_many :foods,           class_name: 'UsdaNutrientDatabase::Food',           through: :foods_nutrients
    has_many :footnotes,       class_name: 'UsdaNutrientDatabase::Footnote',       foreign_key: :nutrient_id
  end
end
