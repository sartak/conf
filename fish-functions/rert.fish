function rert
    pushd ~/rt
    rm -rf autom4te.cache
    bash ./configure.ac

    if [ "$argv[1]" = "mysql" ]
        set -Ux RT_DBA_USER root
        bash ./configure --enable-developer --enable-graphviz --enable-gd --enable-gpg --enable-smime --with-db-type=mysql --with-my-user-group
    else
        set -Ux RT_DBA_USER postgres
        bash ./configure --enable-developer --enable-graphviz --enable-gd --enable-gpg --enable-smime --with-db-type=Pg --with-my-user-group
    end

    sudo rm -rf /opt/rt4
    sudo make install
    sudo cp /vagrant/RT_SiteConfig.pm /opt/rt4/etc/RT_SiteConfig.pm
    sudo make regression-reset-db
end
