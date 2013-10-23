class AddRepo < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.string :description
      t.datetime :created_at
    end
  end
end
