require 'rails_helper'

RSpec.describe Reminder, type: :model do
  describe ".stock_alert" do
		it "creates a notification when a product's stock falls below the threshold" do
			# A notification is created when product.stock falls below the notification_threshold assigned.
			@product = create(:product, name: "Pollo", stock: 10, notification_threshold: 5)
			@last_notification = Notification.last

			@inflow = create(:inflow)
			@inflow_item1 = create(:inflow_item, quantity: 7)
			@inflow.subtract_stock
			Notification.stock_alert(@product)

			expect(Notification.last).not_to eq(@last_notification)
			expect(Notification.last.title).to be == I18n.t('notification.stock_alert.title', product: @product.name)
			expect(Notification.last.text).to be == I18n.t('notification.stock_alert.text', product: @product.name, stock: @product.stock)
		end
	end

	describe ".balance_alert" do
		it "creates a notification when a supplier's account_balance falls below the threshold" do
			# A notification is created when supplier.account_balance falls below the notification_threshold assigned.
			@supplier = create(:supplier, account_balance: 0, notification_threshold: -100)
			@last_notification = Notification.last

			@outflow = create(:outflow, total: 200, paid: 50)
			@outflow.supplier.update_balance(@outflow)
			@difference = @supplier.notification_threshold - @supplier.account_balance
			Notification.balance_alert(@supplier)

			expect(Notification.last).not_to be ==(@last_notification)
			expect(Notification.last.title).to be == I18n.t('notification.balance_alert.title', supplier: @supplier.name)
			expect(Notification.last.text).to be == I18n.t('notification.balance_alert.text',
				supplier: @supplier.name,
				balance: @supplier.account_balance,
				difference: @difference
				)
		end
	end
end