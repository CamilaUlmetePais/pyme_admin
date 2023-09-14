require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe "ActiveRecord associations" do
		it { should have_many(:outflows) }
	end

	describe "validations" do
		it { should validate_presence_of(:name) }
		it { should validate_presence_of(:account_balance) }
		it { should validate_numericality_of(:account_balance) }
		it { should validate_numericality_of(:notification_threshold) }
		it { should validate_uniqueness_of(:name).case_insensitive }
	end

	describe ".get_expenses" do
		it "calculates the total quantity bought from a supplier" do
			# Helper for the 'get_operative_expenses' method in the Supply model.
			@supplier      = create(:supplier, name: "Supplier")
			@supply        = create(:supply, name: "Supply")
			@outflow       = create(:outflow)
			@outflow_item1 = create(:outflow_item, quantity: 5)
			@outflow_item2 = create(:outflow_item, quantity: 7)
			@outflow_item3 = create(:outflow_item, quantity: 3)

			@supplier.get_expenses(@supply.id, @supply.name) == {supply_name:"Supply", supplier_name: "Supplier", expenses: 15}
		end
	end

		describe ".notification?" do
		it "returns true if account_balance is equal to or less than notification_threshold" do
			@supplier1 = create(:supplier, account_balance: -200, notification_threshold: -100)
			expect(@supplier1.notification?).to be(true)
		end

		it "returns false if account_balance is greater than notification_threshold" do
			@supplier2 = create(:supplier, account_balance: 25, notification_threshold: -100)
			expect(@supplier2.notification?).to be(false)
		end
	end

	describe ".update_balance" do
		it "calculates the new value for the account_balance attribute" do
			@supplier = create(:supplier, account_balance: 100)
			@outflow  = create(:outflow, paid: 150, total: 100)

			@supplier.update_balance(@outflow)

			@supplier.account_balance == 50
		end
	end
end