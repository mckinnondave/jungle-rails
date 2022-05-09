require 'rails_helper'

RSpec.describe Product, type: :model do
    before do
      @category = Category.new({:name => "Plant Seeds"})
      @product = Product.new({:name => "Aspen Tree Seeds", :price_cents => "200", :quantity => 3000, :category => @category})
    end

    describe "Validations" do

      it "Should save a new product if all 4 fields are set" do
        @product.save
        expect(@product).to be_valid
      end

      it "Should not save if name is not set" do
        @product.name = nil
        @product.save
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end

      it "Should not save if price is not set" do
        @product.price_cents = nil
        @product.save
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end

      it "Should not save if quantity is not set" do
        @product.quantity = nil
        @product.save
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end

      it "Should not save if category is not set" do
        @product.category = nil
        @product.save
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end
end
