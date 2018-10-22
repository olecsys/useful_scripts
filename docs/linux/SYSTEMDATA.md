# System information helps
## How to get CPU info
You can do it like this:
```
$ cat /proc/cpuinfo
```

## How to get memory info
You can do it like this:
```
$ free
$ cat /proc/meminfo
```

## How to get HDD info
You can do it like this:
```
$ df -h
```
and
```
$ sudo fdisk -l
```
and
```
$ hdparm -i /dev/device (for example sda1, hda3...)
```