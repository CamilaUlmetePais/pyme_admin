require 'rails_helper'

RSpec.describe Outflow, type: :model do
  describe "ActiveRecord association" do
		it { should have_many(:outflow_items).dependent(:destroy) }
		it { should belong_to(:supplier) }
		it { should accept_nested_attributes_for(:outflow_items).allow_destroy(true) }
	end

	describe "validations" do
		it { should validate_presence_of(:total) }
		it { should validate_presence_of(:paid) }
		it { should validate_presence_of(:supplier_id) }
		it { should validate_numericality_of(:total) }
		it { should validate_numericality_of(:paid) }
	end

	describe ".generate_total" do
		it "generates the value for the 'total' attribute by adding subtotals" do
			@supply					= create(:supply, price: 5)
			@supplier				= create(:supplier)
			@outflow       	= create(:outflow)
			@outflow_item1 	= create(:outflow_item, quantity: 5)
			@outflow_item2 	= create(:outflow_item, quantity: 3)
			@outflow_item3 	= create(:outflow_item, quantity: 2)

			@outflow.generate_total
			@outflow.total == 50
		end
	end

	describe ".notification_builder" do
		it "calls for the creation of a notification if conditions given in Supplier are true" do
			@supplier = create(:supplier, account_balance: 0, notification_threshold: -100)
			@last_notification = Notification.last

			@outflow = create(:outflow, total: 300, paid: 100)
			Notification.balance_alert(@supplier)

			expect(Notification.last).not_to eq(@last_notification)
		end
	end
end