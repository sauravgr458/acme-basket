# frozen_string_literal: true

# An offer wraps logic that can be applied to a set of basket items
class Offer
  def initialize(applicable_code:, &block)
    @applicable_code = applicable_code
    @logic = block
  end

  def apply(items)
    @logic.call(items)
  end
end
