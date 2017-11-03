require 'spec_helper'

describe PaymentTypeModel do

    before(:all) do
        @ptm = PaymentTypeModel.new
    end

    context "@ptm" do
        it "is an instance of PaymentTypeModel" do
            expect(@ptm).to be_a PaymentTypeModel
        end
    end

    context ".create_new_payment_type" do
        it "it accepts one argument" do
            expect(@ptm).to respond_to(:create_new_payment_type).with(1).arguments
        end

        it "fails with 0 arguments" do
            expect{@ptm.create_new_payment_type}.to raise_error(ArgumentError)
        end
        
        it "fails with more than 1 argument" do
            expect{@ptm.create_new_payment_type("arg1", "arg2")}.to raise_error(ArgumentError)
        end
    end


end