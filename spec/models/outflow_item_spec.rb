require 'rails_helper'

RSpec.describe OutflowItem, type: :model do
  describe "ActiveRecord associations" do
		it { should belong_to(:outflow).optional }
		it { should belong_to(:supply) }
	end

  describe "validations" do
    it { should validate_presence_of (:quantity) }
    it { should validate_presence_of (:supply_id) }
    it { should validate_numericality_of(:quantity).is_greater_than(0)}
  end

  describe ".add_stock" do
    xit "adds stock to the associated supply when an outflow is created" do
      @supply       = create(:supply, stock: 0)
      @supplier     = create(:supplier)
      @outflow      = create(:outflow)
      @outflow_item = create(:outflow_item, quantity: 25)
      @outflow.add_stock

      expect(@supply.stock).to eq(25)
    end

    xit "adds stock to the associated product when a SupplyProductLink exists linking it to the supply" do
      @supply       = create(:supply, stock: 0)
      @product      = create(:product, stock: 0)
      @link         = create(:supply_product_link)
      @supplier     = create(:supplier)
      @outflow      = create(:outflow)
      @outflow_item = create(:outflow_item, quantity: 25)

      expect(@product.stock).to eq(25) 
      expect(@supply.stock).to eq(0)
    end
  end 

  describe ".list" do
    it "creates a concatenated string with its attributes for improved legibility" do
      @supply            = create(:supply, unit: 0, name: "Pollo")
      @supplier          = create(:supplier)
      @outflow           = create(:outflow)
      @outflow_item      = create(:outflow_item, quantity: 5)
      
      expect(@outflow_item.list).to eq("Pollo: 5.0 kg")
    end
  end

  describe ".receipt_list" do
    it "creates a concatenated string with its attributes in a more detailed manner than .list, to be used in inflow#show for printing receipts" do
      @supply       = create(:supply, name: "Pollo", price: 100, unit: 0)
      @supplier     = create(:supplier)
      @outflow      = create(:outflow)
      @outflow_item = create(:outflow_item, quantity: 2)
      
      expect(@outflow_item.receipt_list).to eq("Pollo: 2.0kg x $100.0 = $200.0")
    end
  end

  describe ".restore_stock" do
    xit "restores stock to the associated supply when an outflow is deleted" do
      @supply       = create(:supply, stock: 0)
      @supplier     = create(:supplier)
      @outflow      = create(:outflow)
      @outflow_item = create(:outflow_item, quantity: 25)

      @outflow.add_stock

      expect(@supply.stock).to eq(25)

      @outflow.restore_stock

      expect(@supply.stock).to eq(0)

    end

    xit "restores stock to the associated product when a SupplyProductLink exists linking it to the supply" do
      @supply       = create(:supply, stock: 0)
      @product      = create(:product, stock: 0)
      @link         = create(:supply_product_link)
      @supplier     = create(:supplier)
      @outflow      = create(:outflow)
      @outflow_item = create(:outflow_item, quantity: 25)

      @outflow.add_stock

      expect(@product.stock).to eq(25)
      expect(@supply.stock).to eq(0)

      @outflow.restore_stock

      expect(@product.stock).to eq(0)
      expect(@supply.stock).to eq(0)
    end
  end

  describe ".subtotal" do
    it "calculates the subtotal for an outflow in process" do
      @supply                = create(:supply, price: 5)
      @supplier          = create(:supplier)
      @outflow               = create(:outflow)
      @outflow_item          = create(:outflow_item, quantity: 5)
      expect(@outflow_item.subtotal).to eq(25)
    end
  end
end