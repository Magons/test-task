class AddPollToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :poll, :boolean, default: false
  end
end
