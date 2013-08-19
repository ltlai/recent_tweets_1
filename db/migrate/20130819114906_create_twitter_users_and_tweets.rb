class CreateTwitterUsersAndTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :twitter_user

      t.string :body

      t.timestamps
    end

    create_table :twitter_users do |u|
      u.references :tweets

      u.string :username

      u.timestamps
    end
  end
end
