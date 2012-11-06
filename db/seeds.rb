# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
#

# -- Populate table with CONNECTS Site information.
# -- checkout config/pghconnects.yml for editing initial sites.

CONNECTS = YAML.load_file("#{Rails.root}/config/pghconnects.yml")

CONNECTS[:sites].each do |site_hash|
    site = Site.new
    site.assign_attributes site_hash
    site.save!
end

CONNECTS[:super].each do |super_hash|
  User.create(super_hash.merge(
    { :birth_date => Date.today,
      :clearance_level => 'S',
      :user_name => super_hash[:first].downcase }),
      :as => :admin)
end
