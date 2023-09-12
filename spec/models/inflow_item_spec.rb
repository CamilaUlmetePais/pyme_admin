require 'rails_helper'

RSpec.describe InflowItem, type: :model do
  describe "ActiveRecord associations" do
		it { should belong_to(:inflow).optional }
		it { should belong_to(:product) }
	end

	describe "validations" do
		it { should validate_presence_of(:quantity) }
		it { should validate_presence_of(:product_id) }
		it { should validate_numericality_of(:quantity).is_greater_than(0)}
	end

	describe ".list" do
		it "creates a concatenated string with its attributes for improved legibility" do
			@product          = create(:product, unit: 0)
			@inflow           = create(:inflow)
			@inflow_item      = create(:inflow_item, quantity: 2)
			@inflow_item.list == "Test: 2kg"
		end
	end

	describe ".receipt_list" do
		it "creates a concatenated string with its attributes in a more detailed manner than .list, to be used in inflow#show for printing receipts" do
			@product          				= create(:product, name: "Alitas", unit: 0, price: 100)
			@inflow           				= create(:inflow)
			@inflow_item     	 				= create(:inflow_item, quantity: 2)
			@inflow_item.receipt_list == "Alitas: 2kg x $100 = $ 200"
		end
	end

	describe ".subtotal" do
		it "calculates the a partial subtotal for an inflow in process" do
			@product              = create(:product, price: 5)
			@inflow               = create(:inflow)
			@inflow_item          = create(:inflow_item, quantity: 5)
			@inflow_item.subtotal == 25
		end
	end
end