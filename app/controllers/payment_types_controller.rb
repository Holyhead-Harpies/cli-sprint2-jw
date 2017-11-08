require_relative '../models/payment_types_model.rb'


##
## @brief      Controls the data flow from PaymentTypeModel to Menu
##
class PaymentTypeController

    attr_accessor :payment_type_info

    def initialize(payment_type_info = Hash.new)
        @payment_type_info = payment_type_info
    end

    ##
    ## @brief Method is called when option 3 of the main menu is selected.
    ## It prompts the user for two pieces of information: 'Payment Type' and 'Account Number'.
    ## Once the information is obtained, it calls the model's method to write a new record to the PaymentType table.
    ##
    ## @author M. Lindstrom
    ##
    ## @params One parameter for the ID of the active customer.
    ##
    ## @returns Inherent return back to the main menu.
    ##
    def ask_for_payment_type_info(customerId)
        system "clear"
        set_payment_type_customer_id(customerId)
        puts "Enter payment type (e.g. AmEx, Visa, Checking):"
        get_payment_type_name
        puts "Enter account number:"
        get_payment_type_account_number
        PaymentTypeModel.new.create_new_payment_type(@payment_type_info)
    end

    ##
    ## @brief Method is called in ask_for_payment_type_info. This method gets a user's input for payment type name and calls the appropriate method.
    ##
    ## @author M. Lindstrom
    ##
    ## @params
    ##
    ## @returns One or two methods. If successfully it will call the method to set the correct info.
    ## If unsuccessful, it will call itself to prompt the user to input correct information.
    ##
    def get_payment_type_name
        name = STDIN.gets.chomp
        if name == ''
            puts "Payment Type cannot be blank."
            get_payment_type_name
        else
            set_payment_type_name(name)
        end
    end

    ##
    ## @brief Method is called in ask_for_payment_type_info. This method gets a user's input for account number and calls the appropriate method.
    ##
    ## @author M. Lindstrom
    ##
    ## @params
    ##
    ## @returns One or two methods. If successfully it will call the method to set the correct info.
    ## If unsuccessful, it will call itself to prompt the user to input correct information.
    ##
    def get_payment_type_account_number
        account = STDIN.gets.chomp
        if account == ''
            puts "Account Number cannot be blank."
            get_payment_type_account_number
        else
            set_payment_type_account_number(account)
        end
    end

    ##
    ## @brief Method is called in get_payment_type_name. Sets the :name in the payment_type_info hash
    ##
    ## @author M. Lindstrom
    ##
    ## @params One parameter for the payment type name inputed by the user.
    ##
    ## @returns
    ##
    def set_payment_type_name(name)
        @payment_type_info[:name] = name
    end

    ##
    ## @brief Method is called in get_payment_type_account_number. Sets the :account_number in the payment_type_info hash
    ##
    ## @author M. Lindstrom
    ##
    ## @params One parameter for the account number inputed by the user.
    ##
    ## @returns
    ##
    def set_payment_type_account_number(account_number)
        @payment_type_info[:account_number] = account_number
    end

    ##
    ## @brief Method is called in ask_for_payment_type_info. Sets the :customer_id in the payment_type_info hash
    ##
    ## @author M. Lindstrom
    ##
    ## @params One parameter for the ID of the active customer.
    ##
    ## @returns
    ##
    def set_payment_type_customer_id(customerId)
        @payment_type_info[:customer_id] = customerId
    end

end