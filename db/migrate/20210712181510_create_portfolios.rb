class CreatePortfolios < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolios do |t|
      t.string :name, null: false
      t.string :website
      t.text :description
      t.date :start_date, null: false
      t.date :end_date
      t.boolean :actively_working, default: false

      t.timestamps
    end
  end
end
