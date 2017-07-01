function rt
    pushd ~/rt
    sudo make config-install dirs files-install fixperms
    sudo rm -rf /opt/rt4/var/mason_data
    sudo /opt/rt4/sbin/standalone_httpd
    popd
end

