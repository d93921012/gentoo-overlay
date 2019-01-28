# "Shutdown VMs in the AutoStart Sequence"
	HOHO_ADMIN="$(/opt/vmware/bin/vmware-wssc-adminTool "/etc/vmware/hostd/authorization.xml" 2>/dev/null)"

	if [ "x" != "x${HOHO_ADMIN}" ]; then
		/opt/vmware/bin/vmware-vim-cmd -U "${HOHO_ADMIN}" hostsvc/autostartmanager/autostop
	fi
