namespace :db do
  desc "Transfer users from old database to new"

  task :transfer => :environment do
    ActiveRecord::Base.transaction do
      OldUsers.all(:order => "user_id ASC").each do |user|
        Rails.logger.info "Transfering: #{user.user_id} | #{user.Location}"

        success = User.create(user.get_all)

        Rails.logger.info "... #{success && success.site.abbr}"

        success
      end
    end
  end

  class Transfer < ActiveRecord::Base
    establish_connection Rails.configuration.database_configuration["old"]
    self.abstract_class = true

    # Maps the older table fields to new table fields
    def map_to_new
      result = {}
      self.m.each do |key, value|
        result[value] = self.send(key.to_sym)
      end
      return result
    end
  end

  class OldUsers < Transfer
    self.table_name = "Users"

    def m
      { "FirstName" => "first",
        "LastName" => "last",
        "MiddleInitial" => "middle",
        "BirthDate" => "birth_date",
        "Gender" => "gender",
        "Ethnicity" => "ethnicity",
        "Location" => "registered_at"
      }
    end

    def transfer
      User.create(self.convert, :as => :admin)
    end

    # Gather all relevant information into a hash that can be consumed by
    # the registration form as params
    def get_all
      # Acquire all of the old users with information fields mapped from old to new
      mapped = self.map_to_new

      map = {
        "ethnicity" => {
          "biR" => "BR",
          "black" => "B",
          "asian" => "API",
          "white" => "W",
          "other" => "O",
          "bi-racial" => "BR",
          "native" => "NA",
          "hispanic" => "H",
          "blackNon" => "B",
          "whiteNon" => "W"
        },
        
        "registered_at" => {
          "EastEnd" => "BGC",
          "HillHouse" => "HH",
          "Homewood" => "HY",
          "HillTop" => "HT"
        },

        "gender" => {
          "female" => "F",
          "male" => "M",
          "other" => "O",
          "none" => ""
        }
      }

      # Then map the values from old format to new format
      map.each do |field, value_map|
        mapped[field] = value_map[mapped[field]]
      end

      # Add necessary fields
      mapped[:password] = mapped[:password_confirmation] = 'connects'

      return mapped
    end
  end
end
