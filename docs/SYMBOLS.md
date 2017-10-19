# Executable and libraries helps
## How to list the symbols in a .so file
You can use standart tool **nm** like this:
```
$ nm -gC yourLib.so
```
If your .so library is in elf format then you can use **objdump**:
```
$ objdump -TC yourLib.so
```
Or you can use **readelf**:
```
$ readelf -Ws yourLib.so
```

## How to get executable or library RPATH
You can use **objdump** for this:
```
$ objdump -x binary_or_library|grep RPATH
```
Or another option is **readelf**:
```
$ readelf -d binary_or_library|head 20
```

## How to get build-id unique identification of executable or library
It can be done with **readelf**:
```
$ readelf -n binary_or_library
```

