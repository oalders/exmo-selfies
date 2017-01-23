# NAME

ExMo::Selfies - Create ExMo Selfie Image Galleries

[![Build Status](https://travis-ci.org/oalders/exmo-selfies.png?branch=master)](https://travis-ci.org/oalders/exmo-selfies)

# VERSION

version 0.000001

# DESCRIPTION

Scan the ["r/exmormon"](#r-exmormon) subreddit for selfie posts and create an image gallery of them.

# SETUP

Check out this module.  It includes submodules, so make sure you do a recursive
clone.

    git clone --recursive

To use a VM, install [Vagrant](https://www.vagrantup.com/) and
[VirtualBox](https://www.virtualbox.org/).  Then, at the command line:

    vagrant up

This will do all of the required setup.  Log in to your VM:

    vagrant ssh

All of the files will be in /vagrant

    cd /vagrant

To get an OAuth token, first make sure you have created a Reddit App.  Go to
[https://www.reddit.com/prefs/apps/](https://www.reddit.com/prefs/apps/) and create a new app.  Use the following
`redirect_uri`:

    http://127.0.0.1:3000/auth/reddit/callback

Note that you don't need to request Reddit to approve your app in order for you
to use it.  Once the app has been created, you can connect immediately.

Now, on your Vagrant VM, issue the following command:

    reddit-oauth daemon -m development -l http://*:3000

If you are not prompted at the command line to enter your app's key and secret, crtrl-C out of this app and copy/paste the credentials.

    vi ~/.pit/default.yaml

The contents of the file should look like:

    ---
    "reddit":
      "key": 'my-app-key'
      "secret": 'my-app-secret'

Now save the file and try again:

    reddit-oauth daemon -m development -l http://*:3000

You should now be able to log in via your Reddit app.  Note the `access_token`
and `refresh_token` values which are printed to the screen once you log in.
You'll need those in order to fetch posts from the Reddit API.

# AUTHOR

Olaf Alders <olaf@wundercounter.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Olaf Alders.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
