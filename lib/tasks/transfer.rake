namespace :db do
  desc "######### Transfer users from old database to new"

  task :transfer => :environment do
    # regex to extract the index
    REGEX = /^(.+)_(\d+)/

    # Adjustment for transfer only happens if the old user id has an higher index number than
    # new user name
    #
    # Higher new user name cannot be adjusted for
    def adjust_transfer(old, new)
      Rails.logger.info "Adjusting from old (#{old.user_id}) to new user (#{new.user_name})"

      max = REGEX.match(old.user_id)[2].to_i
      count = REGEX.match(new.user_name)[2].to_i
      
      if count <= max
        filler = nil

        begin
          # Loop through until the user name saved matches the new username
          u = new.dup
          u.user_name = nil
          u.save!
          Rails.logger.info "Filler: #{u.user_name}"
          filler = u
          count = REGEX.match(u.user_name)[2].to_i
        end while count < max

        return true # TODO there's so cases where this is not true
      else
        new.save
      end
    end

    ActiveRecord::Base.transaction do
      # Loop through all entries from the old database and save each to the new database
      # after altering the attributes through mapping (OldUsers.get_all)
      old_users = OldUsers.all(:order => "user_id ASC")
      
      # Correct sort the users
      # First, sort by the username part
      # Then, sort by the index
      old_users.sort! do |a,b|
        match = REGEX.match a.user_id
        a_username = match[1]
        a_index = match[2].to_i

        match = REGEX.match b.user_id
        b_username = match[1]
        b_index = match[2].to_i

        if a_username == b_username
          a_index <=> b_index
        else
          a_username <=> b_username
        end
      end

      old_users.each do |user|
        Rails.logger.info "----------Transfering: #{user.user_id} | #{user.Location}"

        new_user = User.new(user.get_all)
        new_user.valid? # To create the user_name

        Rails.logger.info "#{user.user_id} => #{new_user.user_name}"
      
        if user.user_id == new_user.user_name
          new_user.save
        else
          # Need to adjust for transfering
          unless adjust_transfer(user, new_user)
            raise "INCORRECT TRANSFER: #{user.user_id} => #{new_user.user_name}\n... Terminating Transfer "
          end
        end

        new_user
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
          "Homewood" => "HW",
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
