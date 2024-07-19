class EmployeesController < ApplicationController
  def index
    @employees = Employee.order(:id)
  end

  def fetch
    api_client = ApiClientService.new
    employees_data = api_client.fetch_employees

    employees_data.each do |data|
      Employee.find_or_create_from_api(data)
    end

    redirect_to employees_path, notice: "Employees data fetched and saved successfully."
  end
end