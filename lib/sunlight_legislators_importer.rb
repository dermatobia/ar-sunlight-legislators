require 'csv'
require 'pry'
require './app/models/legislator.rb'

class SunlightLegislatorsImporter
  def self.import(filename)
    atts = [
    :title,
    :firstname,
    :lastname,
    :party,
    :state,
    :in_office,
    :gender,
    :phone,
    :twitter_id,
    :birthdate]
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      hash = {}
      row.each do |field, value|
        if atts.include?(field.to_sym)
          hash[field.to_sym] = value
        end
      end
      Legislator.create(hash)
    end
  end
end

# SunlightLegislatorsImporter.import("./db/data/legislators.csv")

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
