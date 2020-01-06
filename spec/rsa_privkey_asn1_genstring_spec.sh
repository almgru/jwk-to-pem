#shellspec shell=sh

Describe 'rsa_privkey_asn1_genstring()'
	Include ./bin/jwk-to-pem

	# shellcheck disable=SC2034
	JWK_FILE=/dev/stdin

	It 'outputs openssl genstring for ASN1 RSAPrivateKey in correct format'
		json_to_hex() {
			case "$1" in
				n) 	echo "0xadd1114f63620d99";;
				e) 	echo "0x10001";;
				d) 	echo "0x20bbbc9c7d4feaf9";;
				p) 	echo "0xd56d9007";;
				q) 	echo "0xd07ccd5f";;
				dp) echo "0x999e0193";;
				dq) echo "0x14a3c651";;
				qi) echo "0x493c9f4f";;
			esac
		}

		When call rsa_privkey_asn1_genstring
		The line 1 of output should match "asn1*=*SEQUENCE:private_key"
		The output should match '*[private_key]*'
		The output should match '*version*=*INTEGER:0*'
		The output should match '*=*INTEGER:0xadd1114f63620d99*'
		The output should match '*=*INTEGER:0x10001*'
		The output should match '*=*INTEGER:0x20bbbc9c7d4feaf9*'
		The output should match '*=*INTEGER:0xd56d9007*'
		The output should match '*=*INTEGER:0xd07ccd5f*'
		The output should match '*=*INTEGER:0x999e0193*'
		The output should match '*=*INTEGER:0x14a3c651*'
		The output should match '*=*INTEGER:0x493c9f4f*'
	End
End
