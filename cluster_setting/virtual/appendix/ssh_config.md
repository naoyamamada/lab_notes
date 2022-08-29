This explains the way to use wildcard to configure ```~/.ssh/config```.  
Without wildcard, in real cluster system, ```~/.ssh/config``` should look like

```

Host r390x0
    HostName 192.168.1.100
    User controller
    IdentityFile ~/.ssh/id_ed25519
Host r395x1
    HostName 192.168.1.101
    User worker
    IdentityFile ~/.ssh/id_ed25519
Host r395x2
    HostName 192.168.1.102
    User worker
    IdentityFile ~/.ssh/id_ed25519
Host r395x3
    HostName 192.168.1.103
    User worker
    IdentityFile ~/.ssh/id_ed25519
Host r395x4
    HostName 192.168.1.104
    User worker
    IdentityFile ~/.ssh/id_ed25519
(the lines below are omitted.)
```

As we have 16 nodes, the file will be lengthy.
To make the file short and easy to create, we use wildcard patternm match.
Read [this.](https://www.sophia-it.com/content/%E3%83%AF%E3%82%A4%E3%83%AB%E3%83%89%E3%82%AB%E3%83%BC%E3%83%89)


wildcard ```*``` matches with any string.  
With ```*```,  ```~/.ssh/config``` becomes

```
Host r390x0
    User worker
    IdentityFile ~/.ssh/id_ed25519
Host r395*
    User worker
    IdentityFile ~/.ssh/id_ed25519
```
On the other hand, this ```.ssh/config``` lacks ip address information.
Therefore we have to save ip addresses in ```/etc/hosts```.
To do so, add the lines to ```/etc/hosts```.
```
192.168.1.100 r390x0
192.168.1.101 r395x1
192.168.1.102 r395x2
192.168.1.103 r395x3
192.168.1.104 r395x4
192.168.1.105 r395x5
(the lines below are omitted.)
```
As slurm also requires this ```/etc/hosts``` setting, in total, we can efficiently configure ssh.
