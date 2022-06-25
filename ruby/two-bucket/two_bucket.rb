class TwoBucket
  attr_reader :moves, :goal_bucket, :other_bucket

  FIRST_BUCKET  = 'one'
  SECOND_BUCKET = 'two'

  def initialize(first_size, second_size, goal, main)
    @moves = 0
    @goal = goal
    
    @buckets =[
      Bucket.new(FIRST_BUCKET, first_size),
      Bucket.new(SECOND_BUCKET, second_size)
    ]
    
    @main_bucket, @secondary_bucket =
      main == FIRST_BUCKET ? @buckets : @buckets.reverse
    
    find_goal!
    set_result
  end

  private

  def find_goal!
    move!
    
    find_goal! unless goal_achived? 
  end

  def move!
    @moves += 1

    return @main_bucket.fill_up!      if @main_bucket.empty?
    return @secondary_bucket.fill_up! if @secondary_bucket.capacity == @goal
    return @secondary_bucket.empty!   if @secondary_bucket.full?
    
    @main_bucket.pour(@secondary_bucket)
  end

  def set_result
    @goal_bucket  = @buckets.find { |bct| bct.load == @goal }.name
    @other_bucket = @buckets.find { |bct| bct.name != @goal_bucket }.load
  end
      
  def goal_achived? = @buckets.map(&:load).include?(@goal)

  class Bucket
    attr_reader :load, :capacity, :name

    def initialize(name, capacity)
      @name = name
      @capacity = capacity
      @load = 0
    end
  
    def pour(bucket)
      amount_to_transfer =
        [@load, bucket.available_load].min
  
      remove(amount_to_transfer)
      bucket.add(amount_to_transfer)
    end

    def add(liters)
      @load += liters 
    end

    def remove(liters)
      @load -= liters 
    end
    
    def fill_up!
      @load = @capacity
    end

    def full? = @load == @capacity

    def empty!
      @load = 0
    end

    def empty? = @load.zero?

    def available_load = @capacity - @load
  end
end