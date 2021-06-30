module Constants
  SCENARIO_COMMANDS = %w[start rules rating exit].freeze
  GAME_COMMANDS = %w[hint exit].freeze
  EXIT_COMMAND = %w[exit].freeze
  APPROVAL_COMMANDS = %w[yes no].freeze
  AGREE_COMMAND = 'yes'.freeze
  DATA_FILE = File.join(__dir__, '../data/rating.yml').freeze
  DIFFICULTY_RATING = {
    easy: 3,
    medium: 2,
    hard: 1
  }.freeze
end
