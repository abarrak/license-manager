class CreateLicenseExpiries < ActiveRecord::Migration[7.0]
  def change
    create_table :license_expiries do |t|
      t.references :license, null: false, foreign_key: true
      t.integer :days_count

      t.timestamps
    end
  end
end
