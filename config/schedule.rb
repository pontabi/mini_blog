require File.expand_path(File.dirname(__FILE__) + "/environment")

# .zshrcとrbenvのパスを指定するrakeを定義
job_type :rake, "source /Users/takaho/.zshrc; export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

set :output, "log/crontab.log"
rails_env = ENV["RAILS_ENV"] || :development
set :environment, rails_env

every 1.day, at: "7:00 am" do
  rake "tweet:notify_yesterday_top_liked_tweets"
end
