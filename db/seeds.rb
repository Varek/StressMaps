# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

departments_locations = { "Administration" => [[37.483542,-122.149977]],
  "Finance/Accounting" => [[37.483432,-122.149334]],
  "Product Development" => [[37.486007,-122.14714],[37.484279,-122.149387],[37.484977,-122.148867],[37.485543,-122.148186],[37.485105,-122.147504]],
  "Marketing" => [[37.486007,-122.14714]],
  "Human Resources" => [[37.486007,-122.14714]],
  "Cafeteria" => [[37.48433,-122.148524]],
  "Theater" => [[37.484602,-122.147955]],
  "Gym" => [[37.486007,-122.14714]]
}

departments = departments_locations.keys.map { |e| [e,e[0]+'01'] }.flatten

company = Company.create(
            area: [[37.48642, -122.151416], [37.483006, -122.145343]] ,
            departments: Hash[*departments],
            name: "Facebook",
            postions: ["CEO", "COO", "CTO", "Product Manager", "Developer", 'Accountant', 'CMO'])

selectable_departments =[["Administration",0], ["Finance/Accounting",1], ["Product Development",2],["Product Development",2],["Product Development",2],["Product Development",2],["Product Development",2],["Marketing",7],["Human Resources",8]]
200.times do | time |
  dep_number = SecureRandom.random_number(9)
  selected_department = selectable_departments[dep_number]
  employee = Employee.new(:department => selected_department[0],:location => departments_locations[selected_department[0]][dep_number - selected_department[1]], :working_hours =>[9,18])
  company.employees << employee
  employee.save
  start_time = DateTime.new(2012,11,1,8) + SecureRandom.random_number(3).hours
  54.times do | timestep|
    time = start_time + (timestep*10).minutes
    modifier = employee.department == 'Administration' ? 2.0 : 0.0
    changer = SecureRandom.random_number(3)
    location = employee.location
    if  DateTime.new(2012,11,1,9) < time && DateTime.new(2012,11,1,10) > time || SecureRandom.random_number >= 0.5
      if SecureRandom.random_number(changer) == changer-1
        modifier += changer
      end
    elsif DateTime.new(2012,11,1,12) < time && DateTime.new(2012,11,1,14) > time || SecureRandom.random_number >= 0.5
      if SecureRandom.random_number(changer) == changer-1
        modifier += changer
        location = departments_locations["Cafeteria"].first
      end
    elsif DateTime.new(2012,11,1,19) < time && DateTime.new(2012,11,1,21) > time || SecureRandom.random_number >= 0.5
      if SecureRandom.random_number(changer) == changer-1
        modifier += changer
        if SecureRandom.random_number >= 0.5
          location = departments_locations["Theater"].first
        else
          location = departments_locations["Gym"].first
        end
      end
    else
      modify_dep_number = SecureRandom.random_number(9)
      modify_selected_department = selectable_departments[modify_dep_number]
      location = departments_locations[modify_selected_department[0]][modify_dep_number - modify_selected_department[1]]
    end
    bs = BioSignal.new(:location => location, :stress_level => (SecureRandom.random_number * (10.0 - modifier)).round(2), :created_at => time, :employee_id => employee.id)
    bs.save
  end
end
