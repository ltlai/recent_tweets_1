class Dweet < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/:username' do
    erb :index
  end

  post '/check' do
    @user = TwitterUser.find_or_create_by(username: params[:username])
    puts ' - '*50
    puts @user.tweets_stale?.to_s
    @user.tweets_stale?.to_s
  end

  post '/fetch' do
     @user = TwitterUser.find_or_create_by(username: params[:username])
     @user.fetch_tweets!
     @tweets = @user.tweets.limit(10).map {|tweet| tweet.body}
     erb :tweet_index
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
