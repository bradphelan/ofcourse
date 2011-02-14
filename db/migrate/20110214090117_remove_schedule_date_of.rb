class RemoveScheduleDateOf < ActiveRecord::Migration
  def self.up
    remove_column :courses, :date_of
  end

  def self.down
  end
end
