class BioSignal
  include MongoMapper::EmbedDocument


  key :stress_level, Integer
  key :heart_rate, Integer

  key :location, Array
  timestamps!

  ensure_index [[:location,'2d']]


end
