#!/bin/sh
set -e

# Ensure the app's dependencies are installed
echo "bundle install --without=production..."
gem update --system
gem update bundler
bundle install --without=production

# Start the web server
echo "bin/rails s -p 3000 -b '0.0.0.0'..."
rm -f tmp/pids/server.pid
bin/rails s -p 3000 -b '0.0.0.0'