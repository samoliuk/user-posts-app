module Scopable
  extend ActiveSupport::Concern

  included do
    scope :shared_ips, -> {
      select("author_ip, array_agg(distinct login order by login) as user_list")
      .joins(:user)
      .group(:author_ip)
      .having("count(author_ip) > 1")
    }
    scope :top_posts, ->(post_num) { order(avg_rating: :desc).limit(post_num) }
  end
end
