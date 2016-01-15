class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null:false
      t.string :description, null:false
      t.date :date_rem, null:false
      t.boolean :private, default: false
      t.boolean :daily, default: false
      t.boolean :weekly, default: false
      t.boolean :monthly, default:false
      t.boolean :yearly, default: false
      t.timestamps null: false
    end
  end
end
