class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null:false
      t.string :description, null:false
      t.date :date_rem, null:false
      t.boolean :public, default: false
      t.boolean :everyday, default: false
      t.boolean :everyweek, default: false
      t.boolean :everymonth, default:false
      t.boolean :everyyear, default: false
      t.timestamps null: false
    end
  end
end
