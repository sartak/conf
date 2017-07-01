function new-vm
    if count $argv > /dev/null
        mkdir -p $argv
        cd $argv
    end

    echo 'Set($rtname, "example.com");
Set($WebDomain, "localhost");
Set($WebPort, 8888);
Set($LogToFile, "debug");
Set($MailCommand, "testfile");
Set($LogoURL, "http://sartak.org/img/sartak-200x200.jpg");
Set($LogoLinkURL, "/");
Set(@LexiconLanguages, qw(en));
Set($DevelMode, 1);
Set($StatementLog, "debug");

1;
' > RT_SiteConfig.pm

    echo 'VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "rt"
    config.vm.network "forwarded_port", guest: 8888, host: 8888
    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.linked_clone = true
    end
end
' > Vagrantfile

    vs
end
