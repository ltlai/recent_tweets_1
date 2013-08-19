class Dweet < Sinatra::Base

  get '/' do

  end

  get '/:username' do
    @user = TwitterUser.find_by_username(params[:username])
    if @user.tweets_stale?
      # User#fetch_tweets! should make an API call
      # and populate the tweets table
      #
      # Future requests should read from the tweets table 
      # instead of making an API call
      @user.fetch_tweets!
    end

    @user.tweets.limit(10)
  end

end

class Tweet < ActiveRecord::Base 
  belongs_to :twitter_user

end

class TwitterUser < ActiveRecord::Base 
  has_many :tweets

  def fetch_tweets!
    Client.user_timeline(self.username)
  end

end
