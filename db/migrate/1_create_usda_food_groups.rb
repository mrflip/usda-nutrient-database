class CreateUsdaFoodGroups < ActiveRecord::Migration
  def change
    create_table :usda_food_groups do |t|
      # :id
      t.string  :description, null: false
    end
  end
end
