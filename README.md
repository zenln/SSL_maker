## x509 Self Signed cert maker
This is my attempt to make creating self signed certs for my internal projects easier.

Please edit and rename the openssl.cnf file so that it matches your need.

## Be aware of what you push to git.

Certs and keys may accidentally be pushed to public git repo.

Please configure .gitignore as needed if you intend on making change on this repo and publishing it on your public repo.

## How to use this make repo:
- Make a clone or download this repo
- Go to the directory
- If you do not have a ca-cert then
  ```BASH
  make ca-key
  make ca-cert
  ```

- If you already have a ca-cert for your self signed cert copy this to the directory and rename it as ca-cert.pem and ca-cert.key
- Edit the openssl conf as per your need
- To generate the key and the certificate signing request file use the following
  ```BASH
  make subdomain_websitename_com.key
  make subdomain_websitename_com.csr
  ```
- Finally to create the cert use the following command
```BASH
  openssl x509 -req -in *.csr -days 36500 -CA ca-cert.pem -CAkey ca-key.pem -set-serial 01 -out
```
- A deploy is also includedto copy the files to the server as needed.
  - To deploy set the SERVER, USER and PKIFOLDER appropriately
  - Deploy will use scp to cpoy it to the remote server

### Additional tools
- CA cert can be checked using the following command
```BASH
make check-ca
```
*This is an example of what you can add if you would like to check your certs*

### TO DO:
- Write a make directive for creating cert
