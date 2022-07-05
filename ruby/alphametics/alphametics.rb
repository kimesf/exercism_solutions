# started with ajoshguy's solution
# https://exercism.org/tracks/ruby/exercises/alphametics/solutions/ajoshguy
module Alphametics
  def self.solve(puzzle)= Puzzle.new(puzzle).solution

  class Puzzle
    REGEX = {
      all_words: /\w+/,
      letters: /\w/
    }

    private_constant :REGEX

    private

    attr_reader :all_words,
                :letters_used,
                :me,
                :solver

    def initialize(puzzle)
      @me           = puzzle.downcase
      @all_words    = me.scan(REGEX[:all_words])
      @letters_used = letters_used_starting_from_most_likely_to_be_one

      @solver = DynamicSolver.new(
        disallowed_zeros: all_words.filter_map { |word| word.chars.first },
        result_factor: all_words.pop,
        sum_factors: all_words,
        uniq_letters: letters_used
      )

      @solution = find_solution || {}
    end

    def find_solution
      raw_solution = eval(solver.generate) # rubocop:disable Security/Eval
      return if raw_solution.nil?

      @solution = solution_keys.zip(raw_solution).sort.to_h
    end

    def solution_keys
      letters_used.map(&:upcase)
    end

    def letters_used_starting_from_most_likely_to_be_one
      letters          = me.scan(REGEX[:letters]).uniq
      likely_to_be_one = all_words.last.chars.first
      index            = letters.index likely_to_be_one

      letters[0], letters[index] = letters[index], letters[0]

      letters
    end

    public

    attr_reader :solution
  end

  class DynamicSolver
    # Dinamically builds a puzzle solver ONCE (and not for every iteration)
    #
    # Given a puzzle like 'SEND + MORE == MONEY', #generate returns a literal string
    # similar (because it's not formatted to better readability) to this:
    #
    # [1, 2, 3, 4, 5, 6, 7, 8, 9, 0].permutation(8).find do |m, e, n, d, s, o, r, y|
    #   next if s.zero? || m.zero?
    #
    #   send  =              s * 1000 + e * 100 + n * 10 + d
    #   more  =              m * 1000 + o * 100 + r * 10 + e
    #   money = m * 10_000 + o * 1000 + n * 100 + e * 10 + y
    #
    #   send + more == money
    # end
    def generate
      <<~HEREDOC
        #{permutations_starting_from_one}.find do |#{arguments}|
          next if #{disallowed_zeros_guard_clause}

          #{valid_solution_clause}
        end
      HEREDOC
    end

    private

    attr_reader :disallowed_zeros,
                :result_factor,
                :sum_factors,
                :uniq_letters

    def initialize(disallowed_zeros:, result_factor:, sum_factors:, uniq_letters:)
      @disallowed_zeros = disallowed_zeros
      @result_factor    = result_factor
      @sum_factors      = sum_factors
      @uniq_letters     = uniq_letters
    end

    def permutations_starting_from_one
      integers = [*1..9].push 0

      "#{integers}.permutation(#{uniq_letters.count})"
    end

    def arguments
      uniq_letters.join(', ')
    end

    def disallowed_zeros_guard_clause
      disallowed_zeros.map { |letter| "#{letter}.zero?" }.join(' || ')
    end

    def valid_solution_clause
      math_equation_of_result = to_literal_math_equation(result_factor)
      math_equations_of_sums  = sum_factors.map(&method(:to_literal_math_equation))

      "#{math_equations_of_sums.join(' + ')} == #{math_equation_of_result}"
    end

    def to_literal_math_equation(word)
      chars_starting_from_unity = word.chars.reverse

      chars_starting_from_unity
        .each_with_index
        .map { |letter, index| "#{letter} * #{10**index}" }
        .join(' + ')
    end
  end

  private_constant :Puzzle, :DynamicSolver
end
