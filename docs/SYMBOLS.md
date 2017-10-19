# Executable and libraries helps
## How to list the symbols in a .so file
You use standart tool **nm** like this:
```
$ nm -gC yourLib.so
```
If your .so library is in elf format then you use **objdump**:
```
$ objdump -TC yourLib.so
```
Or you can use **readelf**:
```
$ readelf -Ws yourLib.so
```
