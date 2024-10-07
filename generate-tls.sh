#!/bin/bash

# Define the directory to store certificates
CERTS_DIR="/root/cert"

# Create the certs directory if it doesn't exist
mkdir -p $CERTS_DIR

# Set the certificate details
DAYS_VALID=365
COUNTRY="XX"
STATE="Default State"
CITY="Default City"
ORG="Default Company Ltd"
ORG_UNIT="IT Department"
SERVER_CN="server.local"
CLIENT_CN="client.local"

# Generate the CA private key and self-signed certificate
echo "Generating CA private key and certificate..."
openssl genpkey -algorithm RSA -out $CERTS_DIR/ca.key
openssl req -x509 -new -nodes -key $CERTS_DIR/ca.key -sha256 -days $DAYS_VALID -out $CERTS_DIR/ca.crt -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORG/OU=$ORG_UNIT/CN=CA"

# Generate the server private key and CSR
echo "Generating Server private key and CSR..."
openssl genpkey -algorithm RSA -out $CERTS_DIR/server.key
openssl req -new -key $CERTS_DIR/server.key -out $CERTS_DIR/server.csr -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORG/OU=$ORG_UNIT/CN=$SERVER_CN"

# Sign the server CSR with the CA key to create the server certificate
echo "Signing Server certificate..."
openssl x509 -req -in $CERTS_DIR/server.csr -CA $CERTS_DIR/ca.crt -CAkey $CERTS_DIR/ca.key -CAcreateserial -out $CERTS_DIR/server.crt -days $DAYS_VALID -sha256

# Generate the client private key and CSR
echo "Generating Client private key and CSR..."
openssl genpkey -algorithm RSA -out $CERTS_DIR/client.key
openssl req -new -key $CERTS_DIR/client.key -out $CERTS_DIR/client.csr -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORG/OU=$ORG_UNIT/CN=$CLIENT_CN"

# Sign the client CSR with the CA key to create the client certificate
echo "Signing Client certificate..."
openssl x509 -req -in $CERTS_DIR/client.csr -CA $CERTS_DIR/ca.crt -CAkey $CERTS_DIR/ca.key -CAcreateserial -out $CERTS_DIR/client.crt -days $DAYS_VALID -sha256

# Clean up unnecessary files
rm $CERTS_DIR/server.csr
rm $CERTS_DIR/client.csr

echo "All TLS-related files have been generated in $CERTS_DIR:"
echo " - CA Certificate: $CERTS_DIR/ca.crt"
echo " - CA Private Key: $CERTS_DIR/ca.key"
echo " - Server Certificate: $CERTS_DIR/server.crt"
echo " - Server Private Key: $CERTS_DIR/server.key"
echo " - Client Certificate: $CERTS_DIR/client.crt"
echo " - Client Private Key: $CERTS_DIR/client.key"

