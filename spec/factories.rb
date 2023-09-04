FactoryBot.define do

  factory(:inflow_item) do
    quantity { 3 }
    product_id { 1 }
    inflow_id { 1 }
  end

  factory(:inflow) do
    total { 900 }
    payment_method { 1 }
  end

  factory(:outflow_item) do
    quantity { 2 }
    supply_id { 1 }
    outflow_id { 1 }
  end

  factory(:outflow) do
    total { 360 }
    paid { 340 }
    payment_method { 0 }
    supplier_id { 1 }
  end

  factory(:product) do
    name { "Alitas" }
    price { 300 }
    unit { 0 }
    stock { 100 }
    notification_threshold { 5 }
  end

  factory(:reminder) do
    title { "1kg milanesas" }
    text { "Juan pidió un kilo de milanesas de pollo" }
    done { false }
    due_date { DateTime.now + 10.days }
  end

  factory(:supplier) do
    name { "Juan Pérez" }
    phone_number { "11 22334455" }
    account_balance { 0 }
    notification_threshold { -10000 }
  end

  factory(:supply) do
    name { "Pollo" }
    price { 180 }
    unit { 0 }
    stock { 100 }
  end

  factory(:supply_product_link) do
    product_id { 1 }
    supply_id { 1 }
  end

  factory(:user) do
    email { "user1@example.com" }
    password { "password" }
    password_confirmation { "password" }
    name { "Administradorx" }
    role { 4 }
  end
end