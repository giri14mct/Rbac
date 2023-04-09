# Dockerfile
FROM ruby:3.0.0-alpine

# Install system dependencies
RUN apk update && apk add --no-cache build-base postgresql-dev nodejs yarn tzdata

# Set up application directory
RUN mkdir -p /app
WORKDIR /app

# Install application dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 1

# Copy application code
COPY . .

# Set environment variables
ENV RAILS_ENV=production

# Start application
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
