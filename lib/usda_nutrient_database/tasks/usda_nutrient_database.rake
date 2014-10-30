namespace :usda do
  desc 'Import the latest USDA nutrition data'
  task import: :environment do
    UsdaNutrientDatabase::Importer.new('tmp/usda', UsdaNutrientDatabase.configuration.usda_db_version).import
  end

  [
    'Weights', 'Footnotes', 'FoodGroups', 'Foods', 'FoodsNutrients',
    'Nutrients', 'Sources'
  ].each do |importer_name|
    desc "Import the USDA #{importer_name} table"
    task "import_#{importer_name.downcase}" => :environment do
      download_and_import(importer_name)
    end
  end

  def download_and_import(importer_name)
    usda_db_version = UsdaNutrientDatabase.configuration.usda_db_version
    UsdaNutrientDatabase::Import::Downloader.new('tmp/usda', usda_db_version).
      tap do |downloader|
      downloader.download_and_unzip
      "UsdaNutrientDatabase::Import::#{importer_name}".constantize.
        new("tmp/usda/#{usda_db_version}").import
      downloader.cleanup
    end
  end
end
