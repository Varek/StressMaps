class BioSignal
  include MongoMapper::Document


  key :stress_level, Float
  key :heart_rate, Float

  key :location, Array
  timestamps!

  belongs_to :employee
  #ensure_index [[:location,'2d']]


end
