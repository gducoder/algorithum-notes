class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.2]
  def change



    change_table(:users) do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Tokens
      t.json :tokens
    end
    User.reset_column_information
    User.find_each do |user|
      if user.uid.blank?
        user.uid = ""
        user.provider = 'email'

        user.save!
      end
    end


    add_index :users, [:uid, :provider],     unique: true

    # add_index :users, :unlock_token,       unique: true
  end
end
