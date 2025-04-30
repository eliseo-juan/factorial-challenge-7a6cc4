# Technical Evaluation  Problem to Solve

This is the solution for the [problem](original_problem.md) provided. It's a simple CLI app to add products to a cart and compute the total price.

## Requirements

- ruby 3.0+

## Usage

```bash
$ bundle install
$ ./bin/run
```

## Tests

```bash
$ bundle exec rspec
```

## Assumptions
* There is no need to remove items from the cart
* Any discount can be applied more than once
* Products and discounts are fixed and can't be changed
* There is no need to add new products or discounts
* The buy-one-get-one-free discount is equivalent to have a 100% discount in one item if you add 2 to the cart

## Description

**Product** contains the information about a product. It has a code, name and price. All prices are in cents to avoid problems with floats.

**Discount** is the base class for all discounts. The only mandatory methods are the validation and the discount application. With it, is possible to define complex discount rules and create new ones easily.
**Discount::BuyXPayY** is a discount that defines rules like buy-one-get-one-free or buy-2-get-3.
**Discount::BuyInBulk** is a discount that applies a discount to the price if you buy more than a certain amount.
**Discount::BuyInBulk::WithFixedPrice** is a buy-in-bulk rule that sets the price to a fixed value.
**Discount::BuyInBulk::WithPercentage** is a buy-in-bulk rule that sets the price to a percentage of the original price.

**Cart** is the class that contains the items to purchase. An item is a product in this case.

**Checkout** is the class that simulates the action of finishing the purchase. It contains the cart and the discounts to apply. It calculates the total price and the discounted price.
