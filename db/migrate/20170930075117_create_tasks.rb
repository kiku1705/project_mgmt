class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
    	t.string :name
    	t.text :description
    	t.integer :user_id, index: true
      t.integer :project_id, index: true
      t.string :status, default: 'todo'
      t.timestamps null: false
    end
  end
end
