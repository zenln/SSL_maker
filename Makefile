SERVER=sth.server.com
USER=root
PKIFOLDER="/etc/pki/tls"

.PHONY: test
.PRECIOUS: %.key %.csr %.cer ca-key.pem ca-cert.pem

ca-key:
	if [ ! -e ca-key.pem ]; then openssl genrsa 2048 > ca-key.pem;else echo "CA-key Exists"; fi

ca-cert: ca-key
	if [ ! -e ca-cert.pem ]; then openssl req -new -x509 -nodes -days 36500 -key ca-key.pem -out ca-cert.pem; else echo "CA-cert Exists"; fi

%.key:
	if [ ! -e $$%.key ]; then openssl genrsa 4096 > $@; fi

%.csr: %.key
	if [ ! -e $$%.csr ]; then openssl req -new -key $< -config openssl.cnf -out $@;fi 

#%.cer: %.csr
# make csr
#openssl x509 -req -in *.csr -days 36500 -CA ca-cert.pem -CAkey ca-key.pem -set-serial 01 -out $@

check-ca:
	openssl x509 -in ca-cert.pem -noout -text

%.deploy: %.csr
	@echo Deploying to $(SERVER)
	@echo ====================
	scp $%*.cer $(USER)@$(SERVER):$(PKIFOLDER)/certs/
	scp $%*.key $(USER)@$(SERVER):$(PKIFOLDER)/private/
	
