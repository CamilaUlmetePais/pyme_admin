require 'rails_helper'

RSpec.describe SupplyProductLink, type: :model do
  describe "validations" do
		it { should validate_presence_of(:product_id) }
		it { should validate_presence_of(:supply_id) }

		it "should create a record when both attributes are unique" do
			@product							= create(:product)
			@supply 							= create(:supply)

			@supply_product_link	= SupplyProductLink.new(product_id: 1, supply_id: 1)
			expect(@supply_product_link).to be_valid
		end

		it "should validate uniqueness of product_id" do
			@product							= create(:product)
			@supply 							= create(:supply)
			@supply2 							= create(:supply, name: "Marineras", price: 100, unit: 1, stock: 100)

			@supply_product_link	= create(:supply_product_link, product_id: 1, supply_id: 1)
			@supply_product_link2 = SupplyProductLink.new(product_id: 1, supply_id: 2)
			expect(@supply_product_link2).not_to be_valid
		end

		it "should validate uniqueness of supply_id" do
			@product							= create(:product)
			@supply 							= create(:supply)
			@product2 						= create(:product, name: "Miel", price: 200, unit: 1, stock: 100)

			@supply_product_link	= create(:supply_product_link, product_id: 1, supply_id: 1)
			@supply_product_link2 = SupplyProductLink.new(product_id: 2, supply_id: 1)
			expect(@supply_product_link2).not_to be_valid
		end
	end
end