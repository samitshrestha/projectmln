echo "$(ifconfig | grep Bcast | cut -d: -f 2 | cut -d' ' -f 1) $(hostname).openstacklocal $(hostname)" >> /etc/hosts
wget https://apt.puppetlabs.com/puppet6-release-xenial.deb
sudo dpkg -i puppet6-release-xenial.deb
sudo apt update
sudo apt install -y puppetserver
sudo sed -i "s/-Xms2g/-Xms512m/gi" /etc/default/puppetserver
echo "" >> /etc/puppetlabs/puppet/puppet.conf
echo "[master]" >> /etc/puppetlabs/puppet/puppet.conf
echo "dns_alt_names = $(hostname).openstacklocal,$(hostname)" >> /etc/puppetlabs/puppet/puppet.conf
echo "" >> /etc/puppetlabs/puppet/puppet.conf
echo "[main]" >> /etc/puppetlabs/puppet/puppet.conf
echo "certname = $(hostname).openstacklocal" >> /etc/puppetlabs/puppet/puppet.conf
echo "server = $(hostname).openstacklocal" >> /etc/puppetlabs/puppet/puppet.conf
echo "environment = production" >> /etc/puppetlabs/puppet/puppet.conf
echo "runinterval = 15m" >> /etc/puppetlabs/puppet/puppet.conf
sudo /opt/puppetlabs/bin/puppetserver ca setup
sudo systemctl start puppetserver
sudo systemctl enable puppetserver
