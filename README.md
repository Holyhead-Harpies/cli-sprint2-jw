# Bangazon API (Sprint #2)
This is the CLI for interacting with the Bangazon database. The database includes tables for data about customers, products, orders, and payment types.  

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites
The Bangazon API uses Ruby version 2.4.2 and SQLite version 3.1.6.  

### Installing
* Clone the Bangazon CLI repository and move to the cli directory
```
git clone https://github.com/Holyhead-Harpies/cli-sprint2-jw.git
```
* Set up the database tables

```
ruby db/create_tables.rb
```

## Testing
The Bangazon CLI makes use of the Rspec gem. To set up the Rspec directories, run:
```
gem install rspec
```

To run tests enter:
```
rspec
```

## Using the CLI
The CLI has the following functionality for the USER:
 1. **Create a Customer**  -  Create a new Customer with Name, Address, City, State, Postal Code, and Phone Number attributes.
 2. **Activate a Customer**  -  Select an active Customer from a list of Customers.
 3. **Add a Payment Type**  -  On an active Customer a Payment Type with Account Number can be entered.
 4. **Add a New Product**  -  On an active Customer a Product can be added with Title, Description, Price, and Quantity 
 attributes.
 5. **Add a Product to an Order**  -  On an active Customer, a list of all the Products are given and the User can add it to 
 an active Customer's order. 
 6. **Complete an Order**  - On an active Customer the User can choose to make an Order complete. Then the User is given the 
 Order total and prompted to choose the Customer's Payment Type which is added to the open Order.  If no products are 
 added the User receives the message "Please add some products to your order first. Press any key to return to main menu."
 7. **Remove a Product**  -  On an active Customer the User is presented with a list of Products in the Customer's order and 
 can delete a Product from that list. 
 8. **Update an Order**  -  On an active Customer the User selects to update a Product.  The User is given a list of all the 
 Customer's products and when selected is given the option in a submenu to update Title, Description, Price, Quantity.
 9. **Product Popularity** - The User can see the three most popular products in the system. 


## Contributors

[Gilbert Diaz](https://github.com/diazgilberto)

[Bryon Larrance](https://github.com/beelarr)

[Michael Lindstromm](https://github.com/michaellindstromm)

[Fang W. Shen](https://github.com/fang-w-shen)

[Jeremy Wells](https://github.com/jsheridanwells)

