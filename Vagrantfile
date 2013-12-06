# vi: set ft=ruby :

nodes = {
    'keystone' => [1, 20],
    'proxy'    => [1, 30],
}

Vagrant.configure("2") do |config|
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"
    config.vm.provision :shell, :path => 'puppet.sh'


    nodes.each do |prefix, (count, ip_start)|
        count.times do |i|
            hostname = "%s-%02d" % [prefix, (i+1)]

            config.vm.provider :virtualbox do |v|
                v.customize ["modifyvm", :id, "--memory", 1024]
            end

            config.vm.define "#{hostname}" do |box|
                puts "working on #{hostname} with ip of 192.168.10.#{ip_start+i}"
            
                box.vm.hostname = "#{hostname}.example.com"

                #
                # Networks
                # 

                # Public
                box.vm.network :private_network, :ip => "192.168.10.#{ip_start+i}", :netmask => "255.255.255.0" 

            end
        end
    end
end
