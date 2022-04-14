class CreateLicenses < ActiveRecord::Migration[7.0]
  def change
    create_table :licenses do |t|
      t.string :title
      t.date :current_expire_date
      t.integer :renewal_times
      t.string :owner
      t.string :owner_email
      t.integer :owner_mobile
      t.text :description

      t.timestamps
    end
  end
end
