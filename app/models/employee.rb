class Employee
  include MongoMapper::EmbeddedDocument

  key :name, String
  key :age,  Integer
  key :chronic_condidtions, Array

  key :location, Array
  key :department, String
  key :department_room, String
  key :postion, String
  key :working_hours, Array

  timestamps!

  many :bio_signals

  ensure_index [[:location,'2d']]

  def location_lon
    location[1]
  end

  def location_lat
    location[0]
  end

  def location_lon=(lon)
    location[1] = lon.to_f
  end

  def location_lat=(lat)
    location[0] = lat.to_f
  end

end
