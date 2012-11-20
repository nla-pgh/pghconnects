namespace :db do
  desc "Transfer users from old database to new"

  task :transfer => :environment do
    puts ActiveRecord::Base.configurations["old"].inspect
    Transfer.establish_connection(ActiveRecord::Base.configurations["old"])
    puts Transfer.connected?
    puts Transfer.accessible_attributes.inspect
  end

  class Transfer < ActiveRecord::Base
    self.table_name = "User"

    @old_to_new_map =  { "User" =>  { "FirstName" => "first",
                                      "LastName" => "last",
                                      "MiddleInitial" => "middle",
                                      "BirthDate" => "birth_date",
                                      "Gender" => "gender",
                                      "Ethnicity" => "ethnicity",
                                      "Location" => "" # TODO map location
                                    },
                        "Education" =>  { "School" => "institution",
                                          "StudentID" => "school_id",
                                          "EducationLevel" => "education_level"
                                        },
                        "Email" =>  { "Username" => "address",
                                      "Domain" => "domain",
                                      "DomainRoot" => "root"
                                    },
                        "Address" =>  { "Number" => "number",
                                        "Street" => "street",
                                        "Apartment" => "apt_fl",
                                        "City" => "city",
                                        "State" => "state",
                                        "Zip" => "zip"
                                      },
                        "Phone" =>  { "AreaCode" => "area",
                                      "Prefix" => "carrier",
                                      "Line" => "line"
                                    }
                      }

    def transfer
      old_to_new_map
    end
  end
end
