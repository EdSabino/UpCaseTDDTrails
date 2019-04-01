require "post"

class Dashboard

  attr_accessor :posts, :user
  def initialize(posts:, user:)
    @posts = posts
    @user = user
  end

  def posts
    @posts.visible_to(@user)
  end
end
