class Changedefaultalbumstable < ActiveRecord::Migration[5.2]
  def change
    change_column_default :albums, :live, default: false
  end
end
