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
