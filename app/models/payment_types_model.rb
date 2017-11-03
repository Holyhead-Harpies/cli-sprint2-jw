require 'sqlite3'
require 'date'
##
## @brief PaymentTypeModel class. This class handles the database interaction with the PaymentTypes table.
##
class PaymentTypeModel

    def initialize
        @db = SQLite3::Database.open('sprint2.sqlite')
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

end