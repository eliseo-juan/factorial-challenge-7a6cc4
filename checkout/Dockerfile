# Use the official Ruby image as the base image
FROM ruby:3.2.2

# Set the working directory to /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the image and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the application code into the image
COPY . .

# Use bin/run as the command
CMD ["bin/run"]
