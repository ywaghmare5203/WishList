class CreateAuthServices < ActiveRecord::Migration
  def change
    create_table :auth_services do |t|
       t.string :first_name
      t.string :last_name
      t.string :email
      t.string :fb_token
      t.string :provider
      t.string :facebook_id

      t.timestamps
    end
  end
end
