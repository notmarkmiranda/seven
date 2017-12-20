class AddPrivateToLeague < ActiveRecord::Migration[5.1]
  def change
    add_column :leagues, :privated, :boolean, default: false
  end
end
