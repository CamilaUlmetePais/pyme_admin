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
			@product          = create(:product, unit: 0, name: "Alitas")
			@inflow           = create(:inflow)
			@inflow_item      = create(:inflow_item, quantity: 2)

			expect(@inflow_item.list).to eq("Alitas: 2.0 kg")
		end
	end

	describe ".receipt_list" do
		it "creates a concatenated string with its attributes in a more detailed manner than .list, to be used in inflow#show for printing receipts" do
			@product          				= create(:product, name: "Alitas", unit: 0, price: 100)
			@inflow           				= create(:inflow)
			@inflow_item     	 				= create(:inflow_item, quantity: 2)

			expect(@inflow_item.receipt_list).to eq("Alitas: 2.0kg x $100.0 = $200.0")
		end
	end

	describe ".subtotal" do
		it "calculates the a partial subtotal for an inflow in process" do
			@product              = create(:product, price: 5)
			@inflow               = create(:inflow)
			@inflow_item          = create(:inflow_item, quantity: 5)
			
			expect(@inflow_item.subtotal).to eq(25)
		end
	end
end