# Bash helps
## How to get string length
You can do it like this:
```
searchstring="Sector size (logical/physical)00: "

echo ${#searchstring}
```

## How to find string index position of substring
You can do it like this:
```
t="MULTI: primary virtual IP for xyz/x.x.x.x:44595: 10.0.0.12"
searchstring="IP for"

rest=${t#*$searchstring}
echo $(( ${#t} - ${#rest} - ${#searchstring} ))
```

## How to process multiline string line by line
You can do it like this:
```
while read -r line; do
    echo "... $line ..."
done <<< "$list"
```

## How to get threads cpu load
You can do it like this(first column is thread id and second column is thread cpu load):
```
$ ps -Lo lwp,c <PID OF PROCESS>
```

## How to sort number data by n column
You can do it like this:
```
$ ps -Lo lwp,c <PID OF PROCESS>|sort -t <COLUMN SEPARATOR> -k <COLUMN NUMBER> -g
```

## How to sort *ls -l* output by date
You can do it like this:
```
$ ls -l|sort -k6M -k7 -k8
```

## How to substring
You can do it like this:
```
${var:<INDEX>:<LENGTH>}
```

## How to implement loop
You can do it like this:
```
COUNTER=0
 while [  $COUNTER -lt 10 ]; do
     let COUNTER=COUNTER+1 
done
```

## How to get pathname by PID
You can do it like this:
```
readlink -f /proc/<PID>/exe
```

## How to implement not condition:
```
if ! [ 0 == 2 ]; then
  echo Hello;
fi
```