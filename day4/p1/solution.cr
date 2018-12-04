class Record
  getter timestamp : Time
  getter str : String

  def initialize(string)
    date_str = string.match(/\[(.*)\]/)
    raise "Invalid date string" unless date_str
    @timestamp = Time.parse_utc(date_str[1], "%Y-%m-%d %H:%M")
    @str = string
  end

  def guard
    match = @str.match(/Guard #(\d+)/)
    match ? match[1].to_i.as(Int32) : nil
  end

  def falling_asleep?
    @str =~ /falls asleep/
  end

  def waking_up?
    @str =~ /wakes up/
  end
end

def sleeping_guard(record_strings : Array(String))
  records = record_strings.map { |str| Record.new(str) }.sort { |a, b| a.timestamp <=> b.timestamp }

  current_guard = 0
  fell_asleep_at : (Int32 | Nil) = nil
  woke_up_at : (Int32 | Nil) = nil
  guard_schedules = {} of Int32 => Array(Int32)

  records.each do |rec|
    current_guard = rec.guard.as(Int32) if rec.guard
    guard_schedules[current_guard] ||= Array.new(60, 0)

    fell_asleep_at = rec.timestamp.minute if rec.falling_asleep?
    woke_up_at = rec.timestamp.minute if rec.waking_up?

    if fell_asleep_at && woke_up_at
      (fell_asleep_at..woke_up_at).each { |minute| guard_schedules[current_guard][minute] += 1 }
      fell_asleep_at = woke_up_at = nil
    end
  end

  biggest_sleeper = guard_schedules.max_by { |guard, schedule| schedule.sum }
  biggest_sleeper[0] * biggest_sleeper[1].each_with_index.max_by { |v, i| v }[1]
end
