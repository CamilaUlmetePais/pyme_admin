class Notification < ApplicationRecord

	scope :last_60_days, -> { where('created_at >= ?', 60.days.ago) }

	def self.stock_alert(product)
		params = {
			title: I18n.t('notification.stock_alert.title', product: product.name),
			text: I18n.t('notification.stock_alert.text', product: product.name, stock: product.stock),
		}
		self.create(params)
	end

	def self.balance_alert(supplier)
		difference = supplier.notification_threshold - supplier.account_balance
		params     = {
			title: I18n.t('notification.balance_alert.title', supplier: supplier.name),
			text: I18n.t('notification.balance_alert.text',
				supplier: supplier.name,
				balance: supplier.account_balance,
				difference: difference
				)
		}
		self.create(params)
	end
end

