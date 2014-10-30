require 'zip'

module UsdaNutrientDatabase
  module Import
    class Downloader

      attr_reader :directory, :version

      class_attribute :usda_hostname; self.usda_hostname = 'http://www.ars.usda.gov'

      def initialize(directory, version)
        @directory = directory
        @version = version
      end

      def cleanup
        unless UsdaNutrientDatabase.configuration.keep_data?
          UsdaNutrientDatabase.log "Cleaning up data in #{directory}"
          FileUtils.rm_rf(directory)
        end
      end

      def download_and_unzip
        return true if File.exists?(files_path('WEIGHT.txt'))
        download and unzip
      end

      def zipfile_basename
        "#{version}asc.zip"
      end

      def url_path
        # https://www.ars.usda.gov/SP2UserFiles/Place/12354500/Data/SR27/dnload/sr27asc.zip
        File.join(
          'SP2UserFiles', 'Place', '12354500', 'Data', version.upcase,
          'dnload', zipfile_basename)
      end

      def url
        File.join(usda_hostname, url_path)
      end

      def zipfile_path
        File.join(directory, zipfile_basename)
      end

      def files_path(filename=nil)
        File.join(*[directory, version, filename].compact)
      end

      def download
        if File.exists?(zipfile_path) && false
          UsdaNutrientDatabase.log "#{zipfile_path} exists, skipping"
        else
          UsdaNutrientDatabase.log "Downloading USDA data version #{version} from #{url} into #{zipfile_path}"
          FileUtils.mkdir_p(File.dirname(zipfile_path))
          File.open(zipfile_path, 'w+b') do |file|
            file.write connection.get(url_path).body
          end
        end
      end

      def unzip
        UsdaNutrientDatabase.log "Unzipping data from #{zipfile_path} into #{files_path}"
        FileUtils.mkdir_p(files_path)
        Zip::File.open(zipfile_path) do |zipfile|
          zipfile.each do |file|
            unless File.exist?(files_path(file.name))
              zipfile.extract(file, files_path(file.name))
            end
          end
        end
      end

      def connection
        @connection ||= Faraday.new(url: usda_hostname)
      end
    end
  end
end
