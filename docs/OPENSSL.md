# OpenSSL helps
## How to generate https certificate
You can use tool **openssl** like this:
```
$ openssl rsa -in PRIVATE_KEY_FILENAME -out OUTPUT_KEY_FILENAME
$ openssl x509 -in SIGNING_CERTIFICATE_FILENAME -out OUTPUT_CERTIFICATE_FILENAME -req -signkey OUTPUT_KEY_FILENAME -days 1001
$ cat OUTPUT_KEY_FILENAME>>cert.pem
```
## How to generate signing certificate
You can use tool **openssl** like this:
```
$ openssl req -new > SIGNING_CERTIFICATE_FILENAME
```