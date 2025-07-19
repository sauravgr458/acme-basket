# frozen_string_literal: true

# Represents a product in the catalog with a code, name, and price
class Product
  attr_reader :code, :name, :price

  def initialize(code:, name:, price:)
    @code = code
    @name = name
    @price = price
  end
end
