require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    let(:name) { 'normal' }

    it "decreases the SellIn value by 1" do
      items = [Item.new(name, 6, 9)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 5
    end

    it "decreases quality by 1" do
      items = [Item.new(name, 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 9
    end

    it "does not decrease quality below 0" do
      items = [Item.new(name, 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end


    it "quality does not go above 50" do
      items = [Item.new(name, 2, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to be <= 50
    end


    context "when SellIn <= 0" do
      it "decreases in quality twice as fast" do
        items = [Item.new(name, 0, 10 )]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 8
      end
    end

    context "when item is Aged Brie" do
      let(:name) { 'Aged Brie' }

      it "increases quality by 1" do
        items = [Item.new(name, 10, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 11
      end
      context "when SellIn <=0" do
        it "increases quality by 2" do
          items = [Item.new(name, 0, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 12
        end
      end
    end

    context "when item is Backstage passes to a TAFKAL80ETC concert" do
      let(:name) { "Backstage passes to a TAFKAL80ETC concert" }

      context "when SellIn value is greater than 10" do
        it "increases quality by 1" do
          items = [Item.new(name, 12, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 11
        end
      end

      context "and SellIn value is greater than 5 and equal or less than 10" do
        it "increases quality by 2" do
          items = [Item.new(name, 10, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 12
        end
      end

      context "and SellIn value is greater than 0 and equal or less than 5" do
        it "increases quality by 3" do
          items = [Item.new(name, 3, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 13
        end
      end

      context "and SellIn = 0" do
        it "makes quality 0" do
          items = [Item.new(name, 0, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 0
        end
      end
    end


    context "when item is Sulfuras, Hand of Ragnaros" do
      let(:name) { "Sulfuras, Hand of Ragnaros" }

      it "will not change quality" do
        items = [Item.new(name, 10, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 80
      end

      it "will not change SellIn" do
        items = [Item.new(name, 10, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 10
      end
    end
  end

end