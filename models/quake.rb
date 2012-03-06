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
    date = Date.parse date unless date.class == Date
    where(:time.gt => date, :time.lt => date+1)
  end

  def self.find_by_month(year, month)
    date = Date.parse("#{year}-#{month}-01")
    where(:time.gt => date, :time.lt => date.next_month)
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
