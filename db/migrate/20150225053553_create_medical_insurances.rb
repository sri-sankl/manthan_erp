class CreateMedicalInsurances < ActiveRecord::Migration
  def change
    create_table :medical_insurances do |t|
      t.integer :faculty_master_id
      t.integer :salary_tax_id
      t.integer :amount
      t.string :bill_no
      t.date :bill_date
      t.boolean :parent_included
      t.boolean :parent_senior_citizen
      t.string :attachement
    end
  end
end
