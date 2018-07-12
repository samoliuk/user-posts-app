# API requests:

# create a post
POST http://localhost:3000/api/v1/posts params: { post: { title: 'Post 1', body: 'Post 1 Body', author_ip: '10.0.0.10', user_login: 'my_user' }, format: :json }

# rate the post
POST http://localhost:3000/api/v1/ratings params: { rating: { value: 5, post_id: 1 }, format: :json }

# get top N posts
GET http://localhost:3000/api/v1/posts/top_rated_posts params { posts_number: 5, format: :json }

# get all IPs multiple authors used
GET http://localhost:3000/api/v1/posts/shared_ips params { format: :json }
