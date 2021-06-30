class RatingConsole
  extend DataLoader

  def self.add_data(result)
    save_data(result)
  end

  def self.recorded_data
    records = load_data.sort_by do |record|
      [
        Constants::DIFFICULTY_RATING[record[:difficulty]],
        record[:attempts_left],
        record[:hints_left],
        record[:name]
      ]
    end
    records.map.with_index { |record, index| { rating: index + 1 }.merge(record) }
  end
end
