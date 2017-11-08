require 'sqlite3'
require 'date'
##
## @brief PaymentTypeModel class. This class handles the database interaction with the PaymentTypes table.
##
class PaymentTypeModel

    def initialize
        @db = SQLite3::Database.open('./db/sprint2.sqlite')
        @db.results_as_hash = true
    end

    ##
    ## @brief Method is called from PaymentTypeController after all user input is gathered to create a payment type for the current user.
    ##
    ## @author M. Lindstrom
    ##
    ## @params One parameter with a hash containing the payment_type_name as :name, the account_number as :account_number, and current_customer_id as :customer_id
    ##
    ## @returns
    ##
    def create_new_payment_type(payment_type_info)
        d = DateTime.now
        ct = "#{d.month}/#{d.day}/#{d.year}"
        @db.execute("insert into PaymentTypes (CustomerId, Card_Name, Card_Number, created_at, updated_at) values (#{payment_type_info[:customer_id]}, '#{payment_type_info[:name]}', '#{payment_type_info[:account_number]}', '#{ct}', '#{ct}')")
        @db.close
    end

    ## @brief gets the payment types for the customer when trying to complete an open order
    ## @params takes the customerID as an integer
    ## @returns an array of hashes of the payment types for the current customer
    def get_current_customer_payment_types(current_id)
        payment_types = @db.execute("select pt.* from PaymentTypes pt where CustomerId = #{current_id}")
        @db.close
        payment_types
    end

end