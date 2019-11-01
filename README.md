# syn-detect

Python daemon and fail2ban scripts to detect syn floods.

## Installation

```
sudo apt install python3-psutil
sudo make install
sudo service syn-detect start
```

## Known bugs

Since syn-detect doesn't have historical data of what is already
banned, it cannot associate single hosts with previously banned subnets.
