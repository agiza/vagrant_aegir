vagrant_aegir
=============

Vagrant box with Aegir

At the moment I am stuck on getting Aegir to install silently - If I leave the following lines uncommented

# Now see if we can install Aegir with no user input required
package "aegir" do
    action [:install]
end

It fails, but subsequently running 
sudo su -s /bin/sh aegir -c "drush -y hostmaster-install"

does cause it to complete.

It seems it can't complete apt-get install aegir if run as part of chef or via sudo. However, it does create the aegir 
account adequately for the install to complete when the aegir user is su'd

#http://drupal.org/node/1727440
