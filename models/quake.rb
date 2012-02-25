class Quake
  include Mongoid::Document

  field :place, :type => String
  field :time, :type => Time
  field :point, :type => Hash
  field :depth, :type => Float
  field :magnitude, :type => Float

  def time
    self[:time].getlocal
  end

  def self.find_by_date(date)
    where(:time.gt => date, :time.lt => date+1)
  end

  def to_json
    {
      :place => place,
      :time => time,
      :point => point,
      :depth => depth,
      :magnitude => magnitude
    }.to_json
  end
end
