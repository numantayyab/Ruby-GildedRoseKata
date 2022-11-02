=begin
 --The following class will be refactored in steps. 
  -We will first split each conditional into small functions
  - Each function then will be converted into classes / helper actions for the sake of clarity
  - test cases will be added to ensure maximum coverage of the code
  - If time allowed, a MAKE file will be added with instructions on how to setup the project / run tests
=end

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item_name = item.name.downcase
      case 
        when item_name.include?("sulfuras")
          item
        when item_name.include?("backstage passes")
          item.backstage_pass_calculation
        when item_name.include?("aged brie")
          item.aged_brie_calculation
        when item_name.include?("conjured")
          2.times{item.normal_item_calculation}
        else
          item.normal_item_calculation
      end
      item.sell_in -= 1
    end
  end
end

##Item Class - not touched
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

##A child class of item to implement further methods
class ItemImplementation < Item
  
  MAX_QUALITY = 50
  MIN_QUALITY = 0
  
  def normal_item_calculation
    decrease_by = -1
    decrease_by = -2 if self.sell_in <= 0
    amend_quality_by_number(decrease_by)
    set_min_quality
  end

  def backstage_pass_calculation
    amend_quality_by_number
    amend_quality_by_number if sell_in <= 5
    amend_quality_by_number if sell_in <= 10
    set_min_quality(true)
    set_max_quality
  end

  def aged_brie_calculation
    increase_by = 1
    increase_by = 2 if self.sell_in <= 0
    amend_quality_by_number(increase_by)
    set_max_quality
  end

  private
  def amend_quality_by_number(num=1)
    self.quality += num
  end

  def set_max_quality
    self.quality = MAX_QUALITY if self.quality > MAX_QUALITY
  end

  def set_min_quality(check_sell_in = false)
    self.quality = MIN_QUALITY if check_sell_in && self.sell_in <= 0
    self.quality = MIN_QUALITY if self.quality < MIN_QUALITY
  end

end
