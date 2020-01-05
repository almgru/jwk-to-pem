# jwk-to-pem
Simple script to convert RSA private keys from JWK to PEM.

## Usage
```bash
# ./jwk-to-pem my-key.json > my-key.pem
```

## Required packages
- OpenSSL/LibreSSL
- jq
- xxd

## Run tests
Install [shellspec](https://shellspec.info) and run `shellspec`.
