#based on http://www.jpstacey.info/blog/2011/09/17/trying-out-drupal-aegir-using-vagrant-virtual-machine-automation
# note that this FAILS but passes with
# sudo su -s /bin/sh aegir -c "drush -y hostmaster-install" at the end
#but repo moved to koumbit http://community.aegirproject.org/discuss/debian-archive-migrated-debianaegirprojectorg
 # Add the aegir package repository
e = execute "echo deb http://debian.aegirproject.org stable main | tee -a /etc/apt/sources.list.d/aegir-stable.list" do
    action :run
end

e = execute "echo deb http://backports.debian.org/debian-backports squeeze-backports main | sudo tee -a /etc/apt/sources.list.d/squeeze.list" do
    action :run
end

# Add Koumbit's secure key and update
e = execute "wget http://debian.aegirproject.org/key.asc && apt-key add key.asc && apt-get update" do
    action :run
end
# Put drush pin stuff in place 
template "/etc/apt/preferences.d/drush" do
    source "drush"
    mode 0755
    owner "root"
    group "root"
end

# Configure debian default selections for Postfix and Aegir
package "debconf-utils" do
    action [:install]
end
# Put debconf.selections.conf in /tmp, then debconf-set-selections it
template "/tmp/debconf.selections.conf" do
    source "debconf.selections.erb"
    mode 0755
    owner "root"
    group "root"
end
e = execute "debconf-set-selections /tmp/debconf.selections.conf" do
    action :run
end

package "mysql-server" do
    action [:install]
end
package "mysql-client" do
    action [:install]
end
# Now see if we can install Aegir with no user input required
#package "aegir" do
#    action [:install]
#end
#http://drupal.org/node/1727440
#sudo su -s /bin/sh aegir -c "drush -y hostmaster-install"