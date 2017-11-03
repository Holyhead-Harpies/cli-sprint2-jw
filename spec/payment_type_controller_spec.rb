require 'spec_helper'

describe PaymentTypeController do

    before(:all) do
        @pt = PaymentTypeController.new
    end

    context "on initialization" do
        it "@pt is an instance of PaymentTypeController" do
            expect(@pt).to be_a PaymentTypeController
        end
    end

    context ".ask_for_payment_type_info" do
        it "takes only one argument" do
            expect(@pt).to respond_to(:ask_for_payment_type_info).with(1).arguments
        end

        it "fails with 0 arguments" do
            expect{@pt.ask_for_payment_type_info}.to raise_error(ArgumentError)
        end
        
        it "fails with more than 1 argument" do
            expect{@pt.ask_for_payment_type_info("arg1", "arg2")}.to raise_error(ArgumentError)
        end
    end

    context ".set_payment_type_name" do
        it "takes only one argument" do
            expect(@pt).to respond_to(:set_payment_type_name).with(1).arguments
        end

        it "fails with 0 arguments" do
            expect{@pt.set_payment_type_name}.to raise_error(ArgumentError)
        end
        
        it "fails with more than 1 argument" do
            expect{@pt.set_payment_type_name("arg1", "arg2")}.to raise_error(ArgumentError)
        end

        it "sets the @payment_type_info[:name] to the user input" do
            @pt.set_payment_type_name("Visa")
            expect(@pt.payment_type_info).to include(:name => "Visa")
        end

    end

    context ".set_payment_type_account_number" do
        it "takes only one argument" do
            expect(@pt).to respond_to(:set_payment_type_account_number).with(1).arguments
        end

        it "fails with 0 arguments" do
            expect{@pt.set_payment_type_account_number}.to raise_error(ArgumentError)
        end
        
        it "fails with more than 1 argument" do
            expect{@pt.set_payment_type_account_number("arg1", "arg2")}.to raise_error(ArgumentError)
        end

        it "sets the @payment_type_info[:name] to the user input" do
            @pt.set_payment_type_account_number("11111111")
            expect(@pt.payment_type_info).to include(:account_number => "11111111")
        end

    end

    context ".set_payment_type_customer_id" do
        it "takes only one argument" do
            expect(@pt).to respond_to(:set_payment_type_customer_id).with(1).arguments
        end

        it "fails with 0 arguments" do
            expect{@pt.set_payment_type_customer_id}.to raise_error(ArgumentError)
        end
        
        it "fails with more than 1 argument" do
            expect{@pt.set_payment_type_customer_id("arg1", "arg2")}.to raise_error(ArgumentError)
        end

        it "sets the @payment_type_info[:name] to the user input" do
            @pt.set_payment_type_customer_id(123)
            expect(@pt.payment_type_info).to include(:customer_id => 123)
        end

    end

end