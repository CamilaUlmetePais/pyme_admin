# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#User.create!({email: "admin@example.com", password: "password", password_confirmation: "password", admin: true})
#User.create!({email:"user@example.com", password: "password", password_confirmation: "password"})
supply1 = Supply.create!({name: "Queso", price: 80, unit: 0, stock: 100})
supply2 = Supply.create!({name: "Huevos", price: 25, unit: 1, stock: 100})
supply3 = Supply.create!({name: "Marineras", price: 50, unit: 1, stock: 100})
supply4 = Supply.create!({name: "Servicios", price: 1, unit: 2, stock: 100})
supply5 = Supply.create!({name: "Impuestos", price: 1, unit: 2, stock: 100})
supply6 = Supply.create!({name: "Salarios", price: 1, unit: 2, stock: 100})
supply7 = Supply.create!({name: "Pollo", price: 100, unit: 0, stock: 100})
supply8 = Supply.create!({name: "Pan rallado", price: 300, unit: 2, stock: 100})
supplier1 = Supplier.create!({
  name: "Juan", phone_number: "11 12345678", account_balance: 0, notification_threshold: -1000})
supplier2 = Supplier.create!({
  name: "Norma", phone_number: "11 12345678", account_balance: 0, notification_threshold: -1000})
supplier3 = Supplier.create!({
  name: "Santiago", phone_number: "11 12345678", account_balance: 0, notification_threshold: -1000})
supplier4 = Supplier.create!({
  name: "Edén", phone_number: "11 12345678", account_balance: 0, notification_threshold: -1000})
supplier5 = Supplier.create!({
  name: "AySA", phone_number: "11 12345678", account_balance: 0, notification_threshold: -1000})
supplier6 = Supplier.create!({
  name: "Monotributo", phone_number: "11 12345678", account_balance: 0, notification_threshold: -1000})
supplier7 = Supplier.create!({
  name: "ABL", phone_number: "11 12345678", account_balance: 0, notification_threshold: -1000})
supplier8 = Supplier.create!({
  name: "Alquiler", phone_number: "11 12345678", account_balance: 0, notification_threshold: -1000})
product1 = Product.create!(
  {name: "Queso", price: 80, unit: 0, stock: 100, notification_threshold: 5})
product2 = Product.create!(
  {name: "Huevos", price: 25, unit: 1, stock: 100, notification_threshold: 5})
product3 = Product.create!(
  {name: "Marineras", price: 50, unit: 1, stock: 100, notification_threshold: 5})
product4 = Product.create!(
  {name: "Milanesas", price: 150, unit: 0, stock: 100, notification_threshold: 5})
product5 = Product.create!(
  {name: "Alitas", price: 80, unit: 0, stock: 100, notification_threshold: 5})
product6 = Product.create!(
  {name: "Pechuga", price: 180, unit: 0, stock: 100, notification_threshold: 5})
product7 = Product.create!(
  {name: "Pata y muslo", price: 150, unit: 0, stock: 100, notification_threshold: 5})
product8 = Product.create!(
  {name: "Miel", price: 75, unit: 1, stock: 100, notification_threshold: 5})
SupplyProductLink.create!({product_id: 1 , supply_id: 1})
SupplyProductLink.create!({product_id: 2, supply_id: 2})
SupplyProductLink.create!({product_id: 3, supply_id: 3})
inflow_item1 = {quantity: 10, product_id: 7, inflow_id: 1 }   # subtotal = 10*150=1500
inflow_item2 = {quantity: 5, product_id: 4, inflow_id: 1 }    # subtotal = 5*150=750
inflow_item3 = {quantity: 2.35, product_id: 5, inflow_id: 2 } # subtotal = 2.35*80=188
inflow_item4 = {quantity: 3, product_id: 6, inflow_id: 3 }    # subtotal = 3*180=540
inflow_item5 = {quantity: 2.5, product_id: 4, inflow_id: 3 }  # subtotal = 2.5*150=375
inflow_item6 = {quantity: 5, product_id: 1, inflow_id: 4 }    # subtotal = 5*180=900
inflow_item7 = {quantity: 1, product_id: 1, inflow_id: 5 }    # subtotal = 80
inflow_item8 = {quantity: 2, product_id: 2, inflow_id: 5 }    # subtotal = 2*25=50
inflow_item9 = {quantity: 3, product_id: 3, inflow_id: 5 }    # subtotal = 3*50=150
inflow_item10 = {quantity: 4, product_id: 4, inflow_id: 5 }   # subtotal = 4*150=600
inflow_item11 = {quantity: 5, product_id: 5, inflow_id: 5 }   # subtotal = 5*80=400
inflow_item12 = {quantity: 6, product_id: 6, inflow_id: 5 }   # subtotal = 6*180=1080
inflow_item13 = {quantity: 7, product_id: 7, inflow_id: 5 }   # subtotal = 7*150=1050
inflow_item14 = {quantity: 8, product_id: 8, inflow_id: 5 }   # subtotal = 8*75=600
Inflow.create!({total: 2250, payment_method: 0, inflow_items_attributes: [inflow_item1, inflow_item2] })
Inflow.create!({total: 188, payment_method: 1, inflow_items_attributes: [inflow_item3] })
Inflow.create!({total: 915, payment_method: 0, inflow_items_attributes: [inflow_item4, inflow_item5] })
Inflow.create!({total: 900, payment_method: 0, inflow_items_attributes: [inflow_item6] })
Inflow.create!({total: 4010, payment_method: 2, inflow_items_attributes: [
  inflow_item7, inflow_item8, inflow_item9, inflow_item10, inflow_item11, inflow_item12, inflow_item13, inflow_item14]})
outflow_item1 = {quantity: 500, supply_id: 4, outflow_id: 1 } # subtotal = 500*1=500
outflow_item2 = {quantity: 20, supply_id: 7, outflow_id: 2 }  # subtotal = 20*100=2000
outflow_item3 = {quantity: 2, supply_id: 8, outflow_id: 2 }   # subtotal = 2*300=600
Outflow.create!({total: 500, paid: 500, payment_method: 1, supplier_id: 4, outflow_items_attributes: [outflow_item1]})
Outflow.create!({total: 2600, paid: 2600, payment_method: 0 , supplier_id: 1, outflow_items_attributes: 
  [outflow_item2, outflow_item3]})