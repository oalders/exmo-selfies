package ExMo::Selfies;

use Moo;

1;

# ABSTRACT: Create ExMo Selfie Image Galleries

=pod

=head1 DESCRIPTION

Scan the L</r/exmormon> subreddit for selfie posts and create an image gallery of them.

=head1 SETUP

Check out this module.  It includes submodules, so make sure you do a recursive
clone.

    git clone --recursive

To use a VM, install L<Vagrant|https://www.vagrantup.com/> and
L<VirtualBox|https://www.virtualbox.org/>.  Then, at the command line:

    vagrant up

This will do all of the required setup.  Log in to your VM:

    vagrant ssh

All of the files will be in /vagrant

    cd /vagrant

To get an OAuth token, first make sure you have created a Reddit App.  Go to
L<https://www.reddit.com/prefs/apps/> and create a new app.  Use the following
C<redirect_uri>:

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

You should now be able to log in via your Reddit app.  Note the C<access_token>
and C<refresh_token> values which are printed to the screen once you log in.
You'll need those in order to fetch posts from the Reddit API.

