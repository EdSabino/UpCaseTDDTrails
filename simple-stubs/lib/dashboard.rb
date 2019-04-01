require "post"

class Dashboard

  attr_accessor :posts

  def initialize(posts:)
    @posts = posts
  end

  def todays_posts
    @posts.today
  end
end
