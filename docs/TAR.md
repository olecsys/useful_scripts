# Zip and extract helps
## How to extract tar.gz file:
You can use standart tool **tar** like this:
```
$ tar -xvzf yourfile.tar.gz
```
It extracts files to current path as-is

## How to compress files to tar.gz file:
You can use standart tool **tar** like this:
```
$ tar -zcvf yourfile.tar.gz directory-name
```
It compress all files and directories to yourfile.tar.gz.

## How to extract tar.xz file:
You can use standart tool **tar** like this:
```
$ tar xvfJ yourfile.tar.xz
```
It extracts files to current path as-is

## How to compress files to zip file:
You can use  tool **zip** like this:
```bash
$ zip yourfile.zip file1 file2 file3
```
It compress files to yourfile.zip.

You can use tool **zip** in recursive mode like this:
```
$ zip -r yourfile.zip directory
```
It compress all files and directories to yourfile.zip.

**zip** is not standart tool so you can try install it like this:
```
$ sudo apt-get install zip
```

## How to extract zip file:
You can use  tool **unzip** like this:
```
$ unzip yourfile.zip -d /target/directory
```
It extracts files to path /target/directory.
**unzip** is not standart tool so you can try install it like this:
```
$ sudo apt-get install unzip
```

## How to extract files to another directory:
You can use standart tool **tar** like this:
```
$ tar -xf yourfile.tar -C /target/directory
```