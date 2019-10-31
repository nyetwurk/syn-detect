SERVICE_ACCOUNT:=syn-detect

.PHONY: all install fail2ban adduser deluser restart status

all:
	@echo one of install, fail2ban, adduser, deluser

install: adduser fail2ban
	mkdir -p /usr/local/sbin
	cp -f syn-detect /usr/local/sbin/
	mkdir -p /etc/systemd/system
	cp -f syn-detect.service /etc/systemd/system/
	systemctl daemon-reload
	systemctl enable syn-detect

fail2ban:
	if [ -d /etc/fail2ban/filter.d -a -d /etc/fail2ban/jail.d ]; then \
	    cp -f syn-detect.filter.conf /etc/fail2ban/filter.d/syn-detect.conf; \
	    cp -f syn-detect.jail.conf /etc/fail2ban/jail.d/99-syn-detect.conf; \
	    fail2ban-client reload; \
	fi

adduser:
	if ! id -u $(SERVICE_ACCOUNT) >/dev/null 2>&1; then \
	    addgroup $(SERVICE_ACCOUNT) || true; \
	    adduser --system --no-create-home --disabled-password --disabled-login --ingroup $(SERVICE_ACCOUNT) $(SERVICE_ACCOUNT); \
	fi

deluser:
	deluser $(SERVICE_ACCOUNT) || true
	delgroup $(SERVICE_ACCOUNT)

restart:
	sudo service syn-detect restart

status:
	sudo fail2ban-client status syn-detect
