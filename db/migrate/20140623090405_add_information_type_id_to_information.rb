class AddInformationTypeIdToInformation < ActiveRecord::Migration
  def change
    add_column :information, :information_type_id, :string
    add_index :information, :information_type_id
  end
end
