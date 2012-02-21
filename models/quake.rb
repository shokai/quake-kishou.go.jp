class Quake
  include Mongoid::Document

  field :place, :type => String
  field :time, :type => Time
  field :point, :type => Hash
  field :depth, :type => Float
  field :magnitude, :type => Float
end
