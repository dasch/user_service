class CreateSuspensions < ActiveRecord::Migration
  def change
    create_table :suspensions do |t|
      t.references :user, null: false
      t.timestamp :imposed_at, null: false
      t.timestamp :lifted_at
    end
  end
end
