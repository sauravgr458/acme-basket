# frozen_string_literal: true

# Defines a delivery pricing rule based on basket total
class DeliveryRule
  attr_reader :threshold, :charge

  def initialize(threshold:, charge:)
    @threshold = threshold
    @charge = charge
  end
end
