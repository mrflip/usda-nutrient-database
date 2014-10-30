module UsdaNutrientDatabase
  class Configuration
    attr_accessor :logger
    attr_writer   :perform_logging
    class_attribute :usda_db_version ; self.usda_db_version = 'sr27'
    class_attribute :keep_data       ; self.keep_data       = true

    def keep_data?
      !! keep_data
    end

    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def perform_logging?
      @perform_logging ||= false
    end
  end
end
