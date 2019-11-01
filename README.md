# syn-detect

Python daemon and fail2ban scripts to detect syn floods.

## Installation

```
sudo apt install python3-psutil
sudo make install
sudo service syn-detect start
```

## Known bugs

Due to https://github.com/fail2ban/fail2ban/issues/2559, we cannot properly
fail2ban distributed syn attacks from different hosts on the same subnet,
even though syn-detect can detect hosts that share /24.

The workaround is to ban singletons (as individual hosts) if syn-detect
detects many many hosts from the same subnet.

However, this has problems; if it is a very large distributed syn attack,
it could end up with thousands of banned hosts, so currently a singleton
is only banned if syn-detect sees a host with 2 attacks.

Also, since syn-detect doesn't have historical data of what is already
banned, it cannot associate singletons with previously banned subnets.
