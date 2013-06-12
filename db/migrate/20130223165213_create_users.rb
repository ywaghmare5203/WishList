class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :name
      t.string :email
      t.string :city
      t.string :phone
      t.string :address
      t.string :fb_token
      t.string :provider
      t.string :facebook_id
      t.text :bio
      t.string :country
      t.string :password_hash
      t.string :password_salt
      t.boolean :privacy
      t.string :gender
      t.date :birthday
      t.string :website
      t.string :twitter_id
      t.string :screen_name
      t.boolean :is_active
      t.date :last_login_time
      t.string :registration_id
      t.float :lat
      t.float :longitude
      t.string :nationality
      t.boolean :terms
      t.string :locale, :default => "en"

      t.timestamps
    end
  end
end
