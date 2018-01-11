module Concerns::IndexTime
  def self.generate
    now = Time.now
    [now.to_s(:number), now.usec.to_s.ljust(6, '0')].join
  end

  def self.index_day(time)
    time.strftime('%Y%m%d').to_i
  end

  def self.index_month(time)
  	time.strftime('%Y%m').to_i
  end

  def self.index_year(time)
  	time.strftime('%Y').to_i
  end

  def self.index_hour(time)
  	time.strftime('%H').to_i
  end

end