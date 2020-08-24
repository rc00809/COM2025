class DataToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :stripe_subbed_id, :string
    add_column :users, :end_digits, :string
    add_column :users, :card_expiry_month, :integer
    add_column :users, :card_expiry_year, :integer
    add_column :users, :card_type, :string
    add_column :users, :admin, :boolean
    add_column :users, :subbed, :boolean

  end
end
