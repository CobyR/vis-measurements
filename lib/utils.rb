class Time
  def round_off seconds = 60
    Time.at((self.to_f / seconds).round * seconds)
  end

  def floor seconds = 60
    Time.at((self.to_f / seconds).floor * seconds)
  end

  def ceiling seconds = 60
    Time.at((self.to_f / seconds).ceil * seconds)
  end
end

class TSData
  attr_accessor :count
  attr_accessor :sum

  def initialize
    @sum = 0
    @count = 0
  end

  def average
    sum / count unless count == 0
  end

  def add value
    unless value.nil?
      self.sum += value
      self.count += 1
    end
  end
end

module Utils
  def self.get_categories_time_sliced_data widget, limit
    # last hour
    parts = limit.split("|")
    limit_type = parts[0].upcase
    limit_value = parts[1].to_i

    max_points = 60

    case limit_type
    when "H"
      p_count = limit_value * 60
    when "D"
      p_count = limit_value * 60 * 24
    when "W"
      p_count = limit_value * 60 * 24 * 7
    end

      if p_count > max_points
        interval = p_count / max_points
      else
        interval = 1
      end


    now = Time.now
    start = now.floor - p_count.minutes
    stop = now.floor

    puts "#{start} to #{stop}"
    ds_points = []

    widget.data_sources.each do |ds|
      data = ds.time_series(limit_value * 100)

      #points = Hash.new {|hash, key| hash[key] = TSData.new }
      points = Hash.new
      (0..(p_count)).each do |moment|
        points[(start + moment.minutes).floor(interval.minutes).to_f] = TSData.new
        puts "#{start + moment.minutes} #{(start + moment.minutes).to_f}"
      end

      data.reverse.each do |d|
        point_time = Time.parse(d[0]).floor(interval.minutes)

        puts "\t#{interval} #{point_time}"

        points[point_time.to_f].add d[1] unless points[point_time.to_f].nil?
      end

      puts "Point count: #{points.count}"

      ds_points << points
    end

    return ds_points
  end
end
