# Lovevery Take Home Project

This is the take-home project for engineers at Lovevery, and thanks in advance for taking the time on this.  The
goal of this project is to try to simulate some real-world work you'll do as an engineer for us, so that we can
see you write some code from the comfort of your own computer.

## Submission Instructions

1. Please clone the repo into your own **private repo** in order to complete the assignment.
1. In addition to completing the implementation that the repo describes, please **edit this README** and provide one or two paragraphs explaining what you did, why, and how you tested it. You may include ideas for future enhancement, if you have anything to call out.
1. Share your private repo with the following email addresses when you're ready for us to take a look:

```
manisha@lovevery.com
paul@lovevery.com
tara.eckenrode@lovevery.com
ola.mork@lovevery.com
ian@lovevery.com
```

## The Project

This application is a *very* basic simulation of browsing our products and purchasing one of them.  The
application should work and it has tests to demonstrate that.  Much is simplified to keep the code minimal and
avoid making you deal with unnecessary complexity.

### The basic flow is:

1. Visit `/` and see the products
1. Select a product to view it
1. Click to purchase that product
1. Fill in the data needed to purchase it:
   - Your name
   - Your child's name and birthdate
   - Your address and zip code
   - Your credit card information
1. This will create an order in our system, as well as a record for your child if they are not already in the database.

What we'd like you to do is allow this app to support gifting.  Instead of a parent buying one of our products for
their child, we want you to *also* allow anyone to buy a product for any child. Imagine you are someone's aunt or
uncle and you want to get them a Lovevery product as a gift.

### There are three basic requirements:

* The gift giver can provide an optional message to the child.
* The gift giver must know the child's name and birthdate, as well as the child's parent's name, but does not need
to provide the child's shipping address or zipcode.
* The child must already be in the system, and we can use their previous order shipping information to know how to
ship the gift order.

Beyond that, it's up to you how to implement this and how it should look.

* There is no "one true answer" so write the code as you would normally for a job.
* Don't get fancy—this doesn't have to be a demonstration of every skill you have. Focus on solving the problem above as expediently as you can.  In the real world, that's what you'd do in order to get feedback and iterate.
* Make sure that a) your changes are well tested and b) you don't cause any of the existing tests to fail

Feel free to ask any questions of us, but you can simply make any assumptions you need to get moving. If you ask
us specifics about the requirements, we might say to use your best judgement.

## Getting Set Up

Assuming you have Ruby installed and are using a Ruby version manager like rvm or rbenv, you should be able to:

```
> bin/setup
> yarn install
> bin/rspec
```

This should install needed gems, set up your databases, and then run the tests, which should all pass.  If
anything is wrong at this stage and you can't obviously fix it, let us know.  This is *not* a test of your ability
to setup a Rails dev environment.

Once you have verified that you can run the specs, run both webpacker and rails server in seperate shells via:

```
> bin/webpack-dev-server
> bin/rails s
```

## Notes About The Code

We've kept this as free of third party dependencies as possible to keep things simple.  There are two main
dependencies this app uses that aren't part of Rails: Bootstrap and RSpec.

[Bootstrap](https://getbootstrap.com/) is used for styling the site so you don't have to write a bunch of CSS but
can still produce a decent-looking UI.  Hopefully you find it easy enough to use.

[RSpec](https://rspec.info) is a commonly used testing framework that we use, so we thought it was important to
put it into this project.  This is not a test of your ability to use every feature of RSpec, so if you are
unfamiliar with how it works, this is the very very basics that you need:

* `Rspec.describe`, `describe`, `RSpec.feature` create blocks of code and are for organization only.  They have no
other purpose
* `it` and `scenario` create blocks of code that *are* the test cases.  Each test case should be given to an `it`
or `scenario` block, and this app has many examples to follow.
* To assert things in your tests, you would write `expect(«thing to assert»).to eq(«value you expect it to be»)`, for example `expect(4 + 4).to eq(8)`.  RSpec has *many* (many) more ways to assert things, but if all you use is this one mechanism, you are fine.

Finally, while we tried to write a clean and well-tested app for you, we will go ahead and admit now that it's not
perfect and there are things that could be improved.  We might ask you about your thoughts on some of this code
later, but this is all part of the scenario - real-world code is never as nice as we'd like.

## Assignment Notes

1) The Child model didn't pass the "smell test". 
   
   The way the Child model was setup was not very extensible and it didn't follow standard code practices. The model should've focused on the primary user (i.e. the parent) rather than the child since the parent could have multiple children and is the manager of the household and any account data we add in the future.
   
   However, for a couple reasons, it is not advisable right now to transition the relationship from orders -> child to orders -> user. First, it would've required much greater changes to the code base -- controllers, views, tests, etc. We want to practice iterative development and break up any disruptions into smaller chunks. Second, we can still access all the orders and gifts for a user on a `has_many :through` relationship. Third, I mention in the "Ideas for future work" section below. We need to better understand what the actual requirements are for the Child model.

   Ultimately, with gifting, the functionality to lookup the recipients shipping information based on a previous order is not best practice. First, it requires that the user has already made an order. Second, there could be multiple addresses assigned to a specific child (e.g. separated parents). Third, it assumes that any of the addresses are still accurate. With the parent-children model, we can let the parent set the shipping address for an order from their account. Ultimately, the functionality where a user can set their preferred address requires the prerequisite account management infrastructure.

   Making this change required a lot of alerations to the database and the models. I went with the assumption that this change would affect a small production dataset, so I wanted to include data in the migration as well. If this migration were going to affect a larger table, I would explore a faster, more efficient solution, and include a implementation plan to reduce any side-effects to production operations.

2) Gifting should be flexible and extensible

   Following the single responsibility principle, we want to make sure gifting functionality is based in its own table rather than leveraging off the Orders table with a simple `is_gift` field. This allows gifting to be much more flexible and extensible going into the future.

3) Ideas for future work

   See the image titled "README -- Lovevery Architecture Diagram"

   I wanted to capture what I saw as some of the architectural stages of this code base. The starting state is the code that this repo started with. The "final" state is what I imagine the basic relationships should be after implementing the fixes I mentioned above and then some. The middle state represents what is currently in the code based on my changes.

   One important thing to note is that I have always viewed Child as a proxy for something else in this application that could be better served by other data models. Knowing what I do about Lovevery's business, I saw the Child model most closely as a proxy for the Subscription model.

   Although I didn't include the actual table fields in the image, its important to callout the major differences between the current and "final" state on tables like Gifts or Orders. 
   
   A) Gift subscriptions would need to be tied to the recipient's account. For ease and visibility, the gift giver would print or email a subscription redemption code, which would require the recipient to create an account or tie the subscription to a current account.

   B) We want to differentiate Orders from Fulfillments, especially when non-physical products and subscriptions are offered.

   C) It's pretty standard practice to allow people to purchase multiple items at once. Implement a cart.
