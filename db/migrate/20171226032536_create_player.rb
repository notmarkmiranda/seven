class CreatePlayer < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.references :game, foreign_key: true
      t.integer :finishing_place
      t.float :additional_expense
      t.float :score
      t.references :user, foreign_key: true
      t.timestamp :finished_at

      t.timestamps null: false
    end
  end
end
