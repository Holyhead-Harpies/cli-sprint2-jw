require_relative './customer_controller.rb'
require_relative './payment_types_controller.rb'
require_relative './product_controller.rb'
require_relative './order_controller.rb'

class MainMenuController

    attr_accessor :active_customer

    def initialize(active_customer = nil)
        @active_customer = active_customer
    end

    def get_user_input
        STDIN.gets.chomp
    end

    def display_main_menu(message)
        # system "clear"
        puts message
        puts "*********************************************************"
        puts "**  Welcome to Bangazon! Command Line Ordering System  **"
        puts "*********************************************************"
        puts "1. Create a customer account"
        puts "2. Choose active customer"
        puts "3. Create a payment option"
        puts "4. Add product to sell"
        puts "5. Add product to shopping cart"
        puts "6. Complete an order"
        puts "7. Remove customer product"
        puts "8. Update product information"
        puts "9. Show stale products"
        puts "10. Show customer revenue report"
        puts "11. Show overall product popularity"
        puts "12. Leave Bangazon!"
        puts "> "

        option = get_user_input
        case option
        when '1'
            @active_customer = CustomerController.new.create_new_customer
            message = "Customer add successully."
            display_main_menu(message)
        when '2'
            @active_customer = CustomerController.new.show_all_customers
            message = "Successfully activated customer."
            display_main_menu(message)
        when '3'
            if @active_customer
                PaymentTypeController.new.ask_for_payment_type_info(@active_customer)
                message = "Payment Type added successfully."
                display_main_menu(message)
            else
                message = "Must set an active customer."
                display_main_menu(message)
            end
        when '4'
            if @active_customer
                ProductController.new.create_product(@active_customer)
                display_main_menu(message)
            else
                message = "Must set an active customer."
                display_main_menu(message)
            end
        when '5'
        when '6'
            if @active_customer
                OrderController.new.complete_current_customer_open_order(@active_customer)
                message = "Order Successfully completed."
                display_main_menu(message)
            else 
                message = "Must set an active customer."
                display_main_menu(message)
            end
        when '7'
            if @active_customer
                ProductController.new.remove_product(@active_customer)
                message = ''
                display_main_menu(message)
            else
              message = 'Must set an active customer'
              display_main_menu(message)
            end
        when '8'
            if @active_customer
                ProductController.new.update_product(@active_customer)
                message = "Product edited successfully."
                display_main_menu(message)
            else
                message = "Must set an active customer."
                display_main_menu(message)
            end
        when '9'
            if @active_customer
                ProductController.stale_products
                message = "Here are the stale products."
                display_main_menu(message)
            end
        when '10'
        when '11'
        when '12'
            system "clear"
            return
        else
        end

    end


end