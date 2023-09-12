require 'rails_helper'

RSpec.describe Inflow, type: :model do
  describe "ActiveRecord associations" do
		it { should have_many(:inflow_items) }
		it { should accept_nested_attributes_for(:inflow_items).allow_destroy(true) }
		it { should validate_presence_of(:payment_method)}
	end

	describe ".generate_total" do
		it "generates the value for the 'total' attribute by adding subtotals" do
			@product      = create(:product, price: 2)
			@inflow       = create(:inflow)
			@inflow_item1 = create(:inflow_item, quantity: 5)
			@inflow_item2 = create(:inflow_item, quantity: 3)
			@inflow_item3 = create(:inflow_item, quantity: 2)
			@inflow.generate_total
			@inflow.total == 20
		end
	end

	describe ".notification_builder" do
		it "creates a notification if the associated product's stock falls below the notification threshold" do
			@product = create(:product, stock: 10, notification_threshold: 5)
			@last_notification = Notification.last

			@inflow = create(:inflow)
			@inflow_item1 = create(:inflow_item, quantity: 7)
			Notification.stock_alert(@product)

			expect(Notification.last).not_to eq(@last_notification)
		end
	end

	describe ".update_stocks" do
		# This method takes one parameter, 'subtract' (boolean).
		# When subtract == true, stock is subsracted from its associated product (when an inflow is created)
		# Otherwise, it's restored (when an inflow is deleted, stock is set back to its previous value).
		# This logic is determined in the model to avoid two very similar methods and improve controller legibility.

		it "subtracts from products' stock when an inflow is created" do
			@product       = create(:product, stock: 10)
			@product.stock == 10

			@inflow        = create(:inflow)
			@inflow_item1  = create(:inflow_item, quantity: 5)
			@product.stock == 5
		end

		it "restores to products' stock when an inflow is deleted" do
			@product       = create(:product, stock: 10)
			@product.stock == 10

			@inflow        = create(:inflow)
			@product.stock == 5

			@inflow.destroy 
			@product.stock == 10
		end
	end
end