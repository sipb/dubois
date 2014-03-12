class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.references :parent, index: true
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
