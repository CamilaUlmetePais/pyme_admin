class Outflow < ApplicationRecord
	before_update 								:generate_total
	has_many 											:outflow_items, dependent: :destroy
	belongs_to 										:supplier
	alias_attribute 							:items, :outflow_items
	accepts_nested_attributes_for :outflow_items, allow_destroy: true, reject_if: :all_blank
	validates 										:total, :paid, :supplier_id, presence: true
	validates 										:total, :paid, numericality: true

	scope :date_range, -> (start_date, end_date) { where(
		'created_at >= ? AND created_at <= ?', start_date, end_date) }

	enum payment_method: [:cash, :debit, :credit, :pay_pal] # cash: 0, debit: 1, credit: 2, pay_pal: 3

	def add_stock
		self.items.each do |item|
			item.add_stock
		end
	end

	def generate_total
		self.total = 0
		self.items.each do |item|
			self.total += item.subtotal
		end
	end

	def notification_builder
		AutoNotification.balance_alert(supplier) if supplier.notification?
	end

	def restore_stock
		self.items.each do |item|
			item.restore_stock
		end
	end

end