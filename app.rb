class Dweet < Sinatra::Base

  get '/' do

  end

  get '/:username' do
    @user = TwitterUser.find_or_create_by_username(params[:username])
    if @user.tweets_stale?
      @user.fetch_tweets!
    end

    @tweets = @user.tweets.limit(10).map {|tweet| tweet.body}
    erb :index
  end

end

class Tweet < ActiveRecord::Base 
  belongs_to :twitter_user

end

class TwitterUser < ActiveRecord::Base 
  has_many :tweets

  def fetch_tweets!
    Client.user_timeline(self.username).each do |tweet|
      self.tweets.create(:body => tweet.text)
    end
  end

  def tweets_stale?
    self.tweets.empty? ? true : (self.tweets.last.created_at - Chronic.parse('60 minutes ago')) <= 0
  end

end
