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

			expect(@supply.units_bought).to eq(21)
			expect(@supply.cogs).to         eq(42)
		end
	end

	describe ".get_operative_expenses" do
		xit "maps all units bought from all suppliers" do
			@supply        = create(:supply, price: 2, name: "Queso")

			@supplier			 = create(:supplier, name: "Camila")
			@outflow       = create(:outflow)
			@outflow_item1 = create(:outflow_item, quantity: 5)
			
			@supplier2		 = create(:supplier, name: "Santiago")
			@outflow2      = create(:outflow, supplier_id: 2)
			@outflow_item2 = create(:outflow_item, quantity: 10)

			@operative_expenses = @supply.get_operative_expenses
			
			#should list all suppliers with amount of units bought from each, instead shows the first supplier and all units as if bought from that supplier alone. fix
		end
	end

	describe ".mass_stock_update" do
		#
	end

	describe ".update_stock" do
		it "updates the 'stock' attribute" do
			@supply        = create(:supply, stock: 10)
			@supplier			 = create(:supplier)
			@outflow       = create(:outflow)
			@outflow_item1 = create(:outflow_item, quantity: 10)

			@supply.update_stock(@outflow_item1.quantity)
			
			expect(@supply.stock).to eq(20)
		end
	end
end