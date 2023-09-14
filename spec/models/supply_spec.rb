require 'rails_helper'

RSpec.describe Supply, type: :model do
  describe "ActiveRecord Associations" do
		it { should have_many(:outflow_items) }
	end

	describe "validations" do
		it { should validate_presence_of(:name) }
		it { should validate_presence_of(:price) }
		it { should validate_presence_of(:unit) }
		it { should validate_presence_of(:stock) }
		it { should validate_numericality_of(:stock) }
		it { should validate_numericality_of(:price).is_greater_than(0) }
		it { should validate_uniqueness_of(:name).case_insensitive }
	end

	describe ".cogs and .units_bought" do
		it "calculates the amount of units bought and the cost of goods sold (COGS)" do
			@supply        = create(:supply, price: 2)
			@supplier			 = create(:supplier)
			@outflow       = create(:outflow)
			@outflow_item1 = create(:outflow_item, quantity: 5)
			@outflow_item2 = create(:outflow_item, quantity: 10)
			@outflow_item3 = create(:outflow_item, quantity: 6)

			@supply.units_bought == 21
			@supply.cogs         == 42
		end
	end

	describe ".update_stock" do
		it "updates the 'stock' attribute" do
			@supply        = create(:supply, stock: 10)
			@supplier			 = create(:supplier)
			@outflow       = create(:outflow)
			@outflow_item1 = create(:outflow_item, quantity: 10)

			@supply.update_stock(@outflow_item1.quantity)
			@supply.stock == 20
		end
	end
end