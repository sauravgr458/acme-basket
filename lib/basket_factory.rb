# frozen_string_literal: true

require 'active_support/all'

# Responsible for creating a fully-wired basket with products, offers, and rules
class BasketFactory
  def self.build
    # Define static product catalog
    products = [
      Product.new(code: "R01", name: "Red Widget", price: 32.95),
      Product.new(code: "G01", name: "Green Widget", price: 24.95),
      Product.new(code: "B01", name: "Blue Widget", price: 7.95)
    ]

    # Define delivery pricing based on subtotal
    delivery_rules = [
      DeliveryRule.new(threshold: 50.0, charge: 4.95),
      DeliveryRule.new(threshold: 90.0, charge: 2.95)
    ]

    # "Buy 1 Red Widget, get 2nd at half price"
    offers = [
      Offer.new(applicable_code: "R01") do |items|
        red_items = items.select { |item| item.code == "R01" }
        eligible_pairs = red_items.count / 2

        if eligible_pairs.positive?
          red_price = red_items.first&.price || 0
          (eligible_pairs * (red_price / 2.0)).round(2)
        else
          0.0
        end
      end
    ]

    Basket.new(products: products, delivery_rules: delivery_rules, offers: offers)
  end
end
