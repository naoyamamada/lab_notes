This page explains
1. The power-save function of slurm
2. The wake-on-lan function of computer
3. The way to activate wake-on-lan and slurm power-saver.

To our knowledge, virtualbox does not emulate wake-on-lan. So, use real machines to test the functionality.


## 1. power-save function of slurm
Each node in our cluster consumes approximately 50 watts, even when it does no task.
Slurm has [power-save functionality](https://slurm.schedmd.com/power_save.html), which suspends nodes when there are no tasks to be processed.


## 2. The wake-on-lan function of computer
Read [this](https://www.splashtop.co.jp/knowhow/30/).


## 3. The way to activate wake-on-lan and slurm power-saver.
### Activate wake-on-lan
#### BIOS-level activation
Read motherboard's manual.

#### perpetuation of wake-on-lan (worker nodes)
This section is based on [this](https://ez-net.jp/article/03/CGPZ9mBE/05gYsU6tOny7/). Works on ubuntu 22.04.
If you encounter errors, and cannot manage to resolve, recheck motherboard setting.

#### Place suspend programs (worker nodes)
For each worker node, place ```suspend_this``` in ```/usr/sbin```.
```sudo chmod u+x /usr/sbin/suspend_this``` to make it executable.  
command ```sudo /usr/sbin/suspend_this``` to suspend the node.
From controller node or your local machine, ```wakeonlan ${MAC}``` to wake the node up. Here, ```MAC``` is the mac address of the node.
You can check node's MAC address by ```ip a```.

![Screenshot from 2022-08-29 22-40-39](https://user-images.githubusercontent.com/80142550/187215305-13e08b7f-d7d1-4841-ac64-c9b128b2efc0.png)


For r395x2, ```MAC = 18:c0:4d:ab:31:59```
If you could not wake the node up, press power button mechanically to wake it up.


Then command ```sudo visudo``` to edit ```sudoers```.
Add line ```worker ALL=NOPASSWD: /usr/sbin/suspend_this``` to the last line of the file and reboot.
By editing sudoers, we can execute ```suspend_this``` from ssh without password, like ```ssh -t r395x2 sudo /usr/sbin/suspend_this```
(Why the last line? read [this](https://blog.pinkumohikan.com/entry/use-sudo-command-without-password))

#### Place suspend program (controller node)
Place ```suspend_worker``` in ```/usr/bin/```.


#### Place wakeup program (controller node)
Place ```resume_worker``` and ```wakeonlan_worker``` in ```/usr/bin```
In ```/projects/setup/host_mac```, write each node's host name and MAC address, like
```
r395x1, 18:c0:4d:ab:31:54
r395x2, 18:c0:4d:ab:31:59
```
TODO: automate file creation


#### Configure slurm (All nodes)
powersaver-related setting is below. Rewrite it according with current slurm version.

```
SuspendProgram=/usr/bin/suspend_worker
ResumeProgram=/usr/bin/resume_worker
SuspendTimeout=120
ResumeTimeout=120
ResumeRate=2
SuspendExcNodes=r390x0
SuspendRate=2
SuspendTime=10
```
