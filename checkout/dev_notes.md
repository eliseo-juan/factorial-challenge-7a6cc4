#Dev notes

(This is a thinking-out-loud document, not a proper readme. It will help later to build the proper readme and help
reviewers to understand the decisions made and the train of thought)

It looks like a simple cart application with rules. Backend can be as easy as Cart + Product + Rule classes.

Some questions to answer later, how to present the data and how to ingest the products. For now it can be hardcoded

CLI is tricky, rails provide it but looks overkill, sinatra could work too and is simpler. Or a pure ruby app with a
bunch of gets and prints. Or even try to use some gui like shoes to create a proper app. I think for now i'd try the
simple ruby app + ugly ui as is simpler but leaving it open for an easy change.

Dealing with money (and floats in general) is tricky too. There is a gem to deal with it 'money' but I just need a
single currency. I'll use price in cents + a decorator.

There is a test case provided, i'd use it as starting point for tdding. I'm going to use rspec because i've not touched
it in a while and I need refreshing

Test tell me that i need a Product and a Cart class. For products I can use a Struct. There should be some kind of data
validation. Sorbet? It should work but what if we want to add some custom rule for the product code? Or name lenght?
I'll add a validator class for now and sorbet can be added later.

Product class is added but i'm not sure about the validator because there is no way to create products. I'll decide
later to cut it or extend it in a validator class instead of a simple method.

Pricing rules. I can see a Promo class with the logic to apply it. It should tied to a product or a cart? Both makes
sense, a product is in offer or a cart applying a promo code. If I think how a real shop works, they have a set
of "rules" and create promotions for products or cart based in them. For example, the buy 3+ and get a discount seems
to be the same rule for strawberries and coffee.

I don't like the idea of creating products with a promotion, too coupled. I think is better to go with a global+cart
approach.

Refactoring Promo. Instead of be linked to a product directly, it will use product codes. And as the logic of the
different promotions are different, i'll create a separate class for each one.

After creating the specs for promos, I've seen that I can't apply them directly as they need to know the cart aswell.
Cart shouldn't know about promos, so I'll create a new action to do it. CheckoutService looks a good name for it.

"valid?" methods now look quite ugly. Now it makes more sense to refactor it and have proper validators

Names for promos are quite ugly. I'll rename them to something shorter using modules. I don't like the name Promo either
let's go with Discount

Going deeper with discounts, I think is going to be easier to return the discounted amount and have both, the original
and the discounted one in the checkout. Totals should be moved from Cart to Checkout as they make more sense there.

The discounts are very similar in logic and I believe that they all could be merged in a single logic. You buy X and
get a new Y price. buy-one-get-one-free is just a 50% discount if you buy 2, for example. But that could complicate
the user experience and could lead to edge cases.

For bulk discounts, you can have a fixed price or a percentage over the original price. They can be 2 rules or a single
one with the 2 params and a logic to get the final price. 2 rules seems cleaner and easier to understand but it will
duplicate a lot of code, a base class is needed.

For the checkout, we need a cart with items and a list of discounts. It will calculate the total price and apply
discounts to get the discounted price.

Now is time to provide a basic cli. A simple CLI class with a loop to get the user input and and a bunch of decorators
to print the data in a nice way. It should be tested but I don't think is really mandatory.

if I want to print the discounts in a nice way, they must be readable. Either i add a message or add a custom
decorator for each class. This option feels like too much because the number of files is getting higher but is a
little more extendable.

There are several places where money is displayed. I'll create a decorator for it too.

Checking the app in general, it feels "crowded", it has a lot of files and classes. I'm not sure if I should clean
decorators as it seems the less useful feature (the data is introduced by us). Is already done so I'll leave them, but
probably I'll clean them in a real app. There was validator without usage, adding it.

There is no error handling but it doesn't feel like needed. The only way to crash it is with bad data.

Currently the data is hardcoded in the app class. I don't like it but is good for now. I'll add a data reader if I
have time. With products is kind of easy write a reader from yaml/json but for discounts either is several files
again or some polimorphism.

Some refactor and cleanup in the end. Added a data reader that could be replaced with a proper connector. Test and
methods are simpler now. I'm still undecided about validators, but they will stay.

Writting the documentation i've noticed that could be good to have an interface to add discounts easily.
