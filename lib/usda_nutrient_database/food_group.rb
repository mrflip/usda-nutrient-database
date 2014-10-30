module UsdaNutrientDatabase
  class FoodGroup < ActiveRecord::Base
    self.table_name = 'usda_food_groups'

    validates :description, presence: true

    has_many :foods, class_name: 'UsdaNutrientDatabase::Food', dependent: :destroy, foreign_key: :foodgrp_id
  end
end
