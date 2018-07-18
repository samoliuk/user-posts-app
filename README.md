There is a blog app with the following entities:
1. User, has only login.
2. Post, belongs to User, has title, body, author IP (saved separately for each User).
3. Rating, belongs to Post, can only be in range from 1 to 5.


The aim is create JSON API with the following actions:
1. Create a post. Accepts title and body, user login and IP. If user doesn't exist, it should be created. Returns either the post's attributes with status 200, or validation error with status 422.
2. Rate a post. Accepts the post id and the value, returns new average rating.
3. Get top N posts, returns an array of titles and bodies.
4. Get the list of IPs that were used by multiple authors. Returns an array of hashes with author ip as the key and array of appropriate logins.


The database should be seeded with 200_000 posts, 100 authors, 50 different IPs.
seeds.rb should use the same code the controllers use.


Installation instructions:

1. install ruby, rails, postgresql. Tested on ruby 2.5, rails 5.2, postgresql 9.5
2. clone the repository with `git clone https://github.com/samoliuk/user-posts-app.git`
3. change to user-posts-app directory with `cd user-posts-app`
2. run `bundle` to install gems
3. run `puma` to start the application server


# API requests:

# create a post
POST http://localhost:3000/api/v1/posts params: { post: { title: 'Post 1', body: 'Post 1 Body', author_ip: '10.0.0.10', user_login: 'my_user' }, format: :json }

# rate the post
POST http://localhost:3000/api/v1/ratings params: { rating: { value: 5, post_id: 1 }, format: :json }

# get top N posts
GET http://localhost:3000/api/v1/posts/top_rated_posts params { posts_number: 5, format: :json }

# get all IPs multiple authors used
GET http://localhost:3000/api/v1/posts/shared_ips params { format: :json }
