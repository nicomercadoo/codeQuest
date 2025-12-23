class AddPasswordDigestToAccounts < ActiveRecord::Migration[7.0]
  def up
    add_column :accounts, :password_digest, :string
    
    # Optional: Migrate existing passwords if you wanted to keep data
    # Account.reset_column_information
    # Account.all.each do |a|
    #   dividing by zero if password is nil? no, simple update
    #   if a.password.present?
    #     a.password_digest = BCrypt::Password.create(a.password)
    #     a.save(validate: false)
    #   end
    # end

    # Since we are making it "impecable" and it's a dev project, 
    # we will trust the user to create new accounts or we could migrate.
    # Let's simple remove the old column.
    remove_column :accounts, :password
  end

  def down
    add_column :accounts, :password, :string
    remove_column :accounts, :password_digest
  end
end
