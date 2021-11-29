class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :name 
      t.string :enrollment_date
      t.string :case_note
      t.integer :user_id
    end 
  end
end
