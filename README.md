# Acme Widget Basket System

### Description

Proof of concept for a widget sales system built using Ruby 3.2.2 and Rails 8 (API mode).  
This system calculates the total price for a basket of products, applying delivery rules and special offers.

### Features

- Products with unique codes and prices
- Delivery charges based on basket total
- Special offer: **"Buy one Red Widget (R01), get second half price"**
- No UI or database — designed for CLI or test-based interaction
- Easily extendable for new offers or rules

---

### Setup

```
bundle install
```

### How to Run (from Rails Console)

```
bin/rails console
```

Then inside the console:
```
basket = BasketFactory.build
basket.add("R01")
basket.add("R01")
puts basket.total
```

### How to Run Tests

```
bundle exec rspec
```

### Example Scenarios (for quick testing)

```
BasketFactory.build.tap { |b| b.add("B01"); b.add("G01"); puts b.total }       # => 37.85
BasketFactory.build.tap { |b| b.add("R01"); b.add("R01"); puts b.total }       # => 54.37
BasketFactory.build.tap { |b| b.add("R01"); b.add("G01"); puts b.total }       # => 60.85
BasketFactory.build.tap { |b| b.add("B01"); b.add("B01"); b.add("R01"); b.add("R01"); b.add("R01"); puts b.total } # => 98.27
```
