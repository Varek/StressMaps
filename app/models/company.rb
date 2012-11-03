class Company
  include MongoMapper::Document

  key :name, String
  key :departments, Hash
  key :postions, Array
  key :area, Array
  timestamps!

  many :employees

  ensure_index [[:area,'2d']]

end
