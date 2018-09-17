# Jungle

A mini e-commerce application built with Rails 4.2 for purposes of teaching Rails by example.

## Final Product

![Landing page with all products](https://github.com/geoffmphillips/jungle-rails/blob/master/img/products.png)

View all products on the landing page. Each product has reviews and ratings. Admins can log in to create new products and categories.

![Checkout with Stripe](https://github.com/geoffmphillips/jungle-rails/blob/master/img/checkout.png)

Checkout with Stripe!

![Users can create reviews and delete their own reviews](https://github.com/geoffmphillips/jungle-rails/blob/master/img/reviews.png)

Logged in users can create reviews. They delete reviews they've created.

## Getting Started

1. Clone this repo
1. Run `bundle install` to install dependencies
1. Run `bin/rake db:reset` to create, load and seed db

## Stripe Testing

Use Credit Card # 4242 4242 4242 4242 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2
* PostgreSQL 9.x
* Stripe
