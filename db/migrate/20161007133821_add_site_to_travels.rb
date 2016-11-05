class AddSiteToTravels < ActiveRecord::Migration[5.0]
  def change
    add_column :travels, :site, :string
  end
end
