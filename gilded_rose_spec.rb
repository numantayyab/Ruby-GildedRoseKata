require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  describe "#normal items" do
    elixir = Item.new("Elixir of the Mongoose", 5, 15)
    gilded_rose = GildedRose.new([elixir])
    it "should deacrease quantity sequentially" do
      gilded_rose.update_quality
      expect(elixir.quality).to eq 14
    end

    it "should deacrease quantity sequentially" do
      3.times{gilded_rose.update_quality}
      expect(elixir.quality).to eq 11
    end

    it "should deacrease quantity -2 after sellIn passed" do
      2.times{gilded_rose.update_quality}
      expect(elixir.quality).to eq 8
    end

    it "Quantity shouldn't be less than 0" do
      10.times{gilded_rose.update_quality}
      expect(elixir.quality).to eq 0
    end

  end


  describe "#Backstage Passes" do
    backstage_pass = Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=12, quality=20)
    gilded_rose = GildedRose.new([backstage_pass])
    it "should increase quantity by 1" do
      1.times{gilded_rose.update_quality}
      expect(backstage_pass.quality).to eq 21
    end

    ## For number of days 10 or less, should increase by 2
    it "should increase quantity by 2" do
      3.times{gilded_rose.update_quality}
      expect(backstage_pass.quality).to eq 26
    end

    ## For number of days 6 or less, should increase by 3
    it "should increase quantity by 3" do
      7.times{gilded_rose.update_quality}
      expect(backstage_pass.quality).to eq 44
    end

    ## Once sellIn is passed, quality should be 0
    it "should set quantity to 0" do
      3.times{gilded_rose.update_quality}
      expect(backstage_pass.quality).to eq 0
    end
  end


  describe "#Aged Brie" do
    aged_brie = Item.new(name="Aged Brie", sell_in=10, quality=10)
    gilded_rose = GildedRose.new([aged_brie])
    it "should increase quantity by 1" do
      6.times{gilded_rose.update_quality}
      expect(aged_brie.quality).to eq 16
    end

    ## Once sellIn is passed, should increase by 2
    it "should increase quantity by 2" do
      5.times{gilded_rose.update_quality}
      expect(aged_brie.quality).to eq 22
    end

    ## Shouldn't exceed Maximum Quality
    it "should set quantity to 50" do
      16.times{gilded_rose.update_quality}
      expect(aged_brie.quality).to eq 50
    end
  end

  describe "#Sulfuras, Hand of Ragnaros" do
    sulfuras = Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=1, quality=80)
    gilded_rose = GildedRose.new([sulfuras])
    it "should not change quantity when sellIn decreases" do
      1.times{gilded_rose.update_quality}
      expect(sulfuras.quality).to eq 80
    end

    it "should not change quantity when sellIn has passed" do
      10.times{gilded_rose.update_quality}
      expect(sulfuras.quality).to eq 80
    end
  end

end
