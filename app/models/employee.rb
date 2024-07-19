class Employee < ApplicationRecord
  def self.find_or_create_from_api(data)
    find_or_create_by(email: data["email"]) do |employee|
      employee.first_name = data["first_name"]
      employee.last_name = data["last_name"]
      employee.date_of_birth = data["date_of_birth"]
      employee.address = data["address"]
      employee.country = data["country"]
      employee.bio = data["bio"]
      employee.rating = data["rating"]
    end
  end
end
