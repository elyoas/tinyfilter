# A very effective firewall filter to block pornography

If your right eye causes you to stumble, gouge it out and throw it away. It is better for you to lose one part of your body than for your whole body to be thrown into hell. And if your right hand causes you to stumble, cut it off and throw it away. It is better for you to lose one part of your body than for your whole body to go into hell. (Matthew 5:29-30)

* * *

### Articles:
https://fightthenewdrug.org/why-porn-can-be-difficult-to-quit/

This is the most effective method of blocking pornography that I have ever achieved (word origin: porneia πορνεία, meaning "prostitution", _britannica_ definition).

The best way not to commit evil, is to avoid it, to stay far from it, and to make it difficult to reach.

The filter blocks everything except a predefined whitelist of _domains_. It forces all http/https traffic to pass through a proxy, which acts as the filter. It can be used to protect your family, or to rid yourself from addiction.

### Steps to activate filter:
The following needs experience in Linux. I use Arch. If you use another distro you might need to alter a few commands.
```
sudo pacman -S tinyproxy

cd settings

sudo cp filter /etc/tinyproxy/filter
sudo cp tinyproxy.conf /etc/tinyproxy/tinyproxy.conf

sudo systemctl start tinyproxy
sudo systemctl enable tinyproxy

sudo ./activate_firewall.sh

reboot
```
Put these 4 lines in .bashrc
```
http_proxy=127.0.0.1:8888
https_proxy=127.0.0.1:8888
export http_proxy
export https_proxy
```

Finally Add this proxy to your browser (Firefox): 127.0.0.1:8888

And use a long root password, like the Hail Mary.

### Further work:
1. The filter at its current state can do domain filtering only. I'm looking to expand it and enable filtering based on url and page content, but I need more knowledge about SSL cryptography. I already attempted to use Squid instead of Tinyproxy for this, but I ran into problems. If you can help me please see this issue, it contains all of my work and my sources:
https://bbs.archlinux.org/viewtopic.php?id=254998

2. Figure out how to implement it on Android (it is already possible to use iptables on Android). I will create another project in the future for this.

# [UPDATE: on 20201128]
A better filter (e2guardian) has since been introduced here:
https://www.youtube.com/watch?v=Y3Nw0oTgaS8

### Filter weakness:
Note that any virtualbox machine can circumvent these settings. So you need to disable users from installing software.

"Bridged networking. This is for more advanced networking needs, such as network simulations and running servers in a guest. When enabled, Oracle VM VirtualBox connects to one of your installed network cards and exchanges network packets directly, circumventing your host operating system's network stack" https://www.virtualbox.org/manual/ch06.html

### License:
You are free to copy, modify and distribute the code.
