class Supply < ApplicationRecord
	has_many        :outflow_items
	has_many        :outflows, through: :outflow_items
	has_many        :suppliers, through: :outflows
	alias_attribute :items, :outflow_items
	validates       :name, :price, :unit, :stock, presence: true
	validates 			:stock, numericality: true
	validates       :price, numericality: { greater_than: 0 }
	validates       :name, uniqueness: { case_sensitive: false }

	enum unit: [:kg, :u, :ars] # kg: 0, u: 1, ars: 2

  # Calculates Cost of Goods Sold
	def cogs
		self.units_bought * self.price
	end

	# Supply -> [{keys: supplier_id, value: quantity}]
	def get_operative_expenses
		self.suppliers.uniq.map{|supplier| supplier.get_expenses(self.id, self.name)}
	end

	def mass_stock_update(quantity)
		value = self.stock - quantity
		self.update(stock: value)
	end

	def units_bought
		self.outflow_items.sum('quantity')
	end

	def update_stock(quantity)
		value = self.stock + quantity
		self.update(stock: value)
	end
end