# frozen_string_literal: true

# Handles adding products, applying offers, and calculating total cost
class Basket
  def initialize(products:, delivery_rules:, offers:)
    # Map product codes to product objects for quick lookup
    @products_catalog = products.index_by(&:code)

    # Sort delivery rules by ascending threshold so we can pick the first match
    @delivery_rules = delivery_rules.sort_by(&:threshold)

    # List of all available offers (each has custom logic)
    @offers = offers

    # Items added to this basket
    @items = []
  end

  # Add a product to the basket using its product code
  def add(product_code)
    product = @products_catalog[product_code]
    raise ArgumentError, "Invalid product code: #{product_code}" unless product

    @items << product
  end

  # Calculate final basket total after offers and delivery charges
  def total
    subtotal = @items.sum(&:price)

    # Apply each offer and sum up total discounts
    offer_discount = @offers.sum { |offer| offer.apply(@items) }

    # Apply delivery rule based on discounted subtotal
    total_after_offer = subtotal - offer_discount
    delivery_charge = calculate_delivery_charge(total_after_offer)

    # Round final total to 2 decimal places
    (total_after_offer + delivery_charge).round(2)
  end

  private

  # Finds the delivery rule based on the total and returns the charge
  def calculate_delivery_charge(amount)
    rule = @delivery_rules.find { |r| amount < r.threshold }
    rule ? rule.charge : 0.0
  end
end
