class CreateClassTeacherMappings < ActiveRecord::Migration
  def change
    create_table :class_teacher_mappings do |t|
      t.integer :grade_master_id
      t.integer :section_master_id
      t.integer :faculty_master_id

      t.timestamps
    end
  end
end
