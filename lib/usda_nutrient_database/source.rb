module UsdaNutrientDatabase
  class Source < ActiveRecord::Base
    validates :description, presence: true
  end
end
