SERVICE_ACCOUNT:=syn-detect

.PHONY: install adduser deluser

all:

install: # adduser
	mkdir -p /usr/local/sbin
	cp -f syn-detect /usr/local/sbin/
	mkdir -p /etc/systemd/system
	cp -f syn-detect.service /etc/systemd/system/
	systemctl daemon-reload
	systemctl enable syn-detect

adduser:
	addgroup $(SERVICE_ACCOUNT) || true
	adduser --system --no-create-home --disabled-password --disabled-login --ingroup $(SERVICE_ACCOUNT) $(SERVICE_ACCOUNT)

deluser:
	deluser $(SERVICE_ACCOUNT)
	delgroup $(SERVICE_ACCOUNT)
