require 'rails_helper'

RSpec.describe Basket do
  let(:basket) { BasketFactory.build }

  it "calculates total for B01, G01" do
    basket.add("B01")
    basket.add("G01")
    expect(basket.total).to eq(37.85)
  end

  it "calculates total for R01, R01 with offer applied" do
    basket.add("R01")
    basket.add("R01")
    expect(basket.total).to eq(54.37)
  end

  it "calculates total for R01, G01 (no offer on G01)" do
    basket.add("R01")
    basket.add("G01")
    expect(basket.total).to eq(60.85)
  end

  it "calculates total for B01, B01, R01, R01, R01 (1 R01 gets half price)" do
    basket.add("B01")
    basket.add("B01")
    basket.add("R01")
    basket.add("R01")
    basket.add("R01")
    expect(basket.total).to eq(98.27)
  end

  it "raises error for invalid product code" do
    expect { basket.add("X99") }.to raise_error(ArgumentError)
  end
end
