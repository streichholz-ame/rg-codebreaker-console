class RatingConsole
  extend DataLoader

  class << self
    def add_data(result)
      save_data(result)
    end

    def records
      records = load_data.sort_by do |record|
        [
          Constants::DIFFICULTY_RATING[record[:difficulty]],
          record[:attempts_left],
          record[:hints_left],
          record[:name]
        ]
      end
      recorded_data(records)
    end

    private

    def recorded_data(records)
      records.map.with_index { |record, index| { rating: index + 1 }.merge(record) }
    end
  end
end
