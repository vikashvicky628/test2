# Short-url-app
Ruby on Rails application that runs in Docker and acts as a url shortening service

Data is stored in a Postgres database

A `docker-compose` file has been provided that will bring up the app and the database together

### Build instructions
1. Build image: `docker-compose build`
2. Setup DB: `docker-compose run short-url-app rails db:setup`
3. Migrate DB: `docker-compose run short-url-app rails db:migrate`
4. Run webserver: `docker-compose up`

### How to Use
1. Browse to http://localhost:3000/
2. Credentials: `admin:password`
3. Click New
4. Enter a URL to generate a shortcode and click Save Shortcode
5. Once redirected to http://localhost:3000/ click on the shortcode to be redirected to the original URL

### Useful security tools
1. `docker scan` (uses Snyk.io)
2. Brakeman
3. Burp Suite/OWASP Zap