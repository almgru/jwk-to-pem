#shellspec shell=sh

Describe 'jwk-to-pem'
	Include ./bin/jwk-to-pem

	Describe 'rsa_privkey_asn1_genstring()'
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
			The output should match '*[private\ key]*'
			The output should match '*version*=*INTEGER:0*'
			The output should match '*n*=*INTEGER:0xadd1114f63620d99*'
			The output should match '*e*=*INTEGER:0x10001*'
			The output should match '*d*=*INTEGER:0x20bbbc9c7d4feaf9*'
			The output should match '*p*=*INTEGER:0xd56d9007*'
			The output should match '*q*=*INTEGER:0xd07ccd5f*'
			The output should match '*exp1*=*INTEGER:0x999e0193*'
			The output should match '*exp2*=*INTEGER:0x14a3c651*'
			The output should match '*coeff*=*INTEGER:0x493c9f4f*'
		End
	End

	Describe 'json_to_hex()'
		# shellcheck disable=SC2034
		JWK_FILE=/dev/stdin

		It 'takes a json key and converts its value to hex'
			base64url_decode() { printf 10; }
			to_hex() { printf '0x0A'; }

			Data '{"a":10,"b":20}'

			When call json_to_hex "a"
			The output should equal '0x0A'
		End
	End

	Describe 'to_hex()'
		It 'converts raw data to hexadecimal'
			When call to_hex "Oc9j"
			The output should equal '0x4F63396A'
		End

		It 'uses 0x as a prefix'
			When call to_hex 'F&'
			The output should start with '0x'
		End

		It 'produces uppercase letters'
			When call to_hex 'ͺ' 
			The output should equal '0xCDBA'
		End

		It 'produces no output when called with no argument'
			When call to_hex
			The output should equal ''
		End
	End

	Describe 'base64url_decode()'
		# base64_pad stub that just echoes its arg
		base64_pad() {
			printf "%s" "$1"
		}

		It 'decodes base64url encoded data'
			When call base64url_decode 'aGVsbG8='
			The output should equal 'hello'
		End

		It 'correctly decodes data with underscores'
			When call base64url_decode 'b2s_'
			The output should equal 'ok?'
		End

		It 'correctly decodes data with dashes'
			When call base64url_decode 'aGl-'
			The output should equal 'hi~'
		End
	End

	Describe 'base64_pad()'
		It 'pads data to multiples of 4'
			When call base64_pad "123456789"
			The length of the output should equal 12
		End

		It 'pads data with ='
			When call base64_pad "123"
			The output should equal '123='
		End

		It 'pads strings of length 2 with =='
			When call base64_pad 'YQ'
			The output should equal 'YQ=='
		End

		It 'pads strings of length 7 with ='
			When call base64_pad 'aGVsbG8'
			The output should equal 'aGVsbG8='
		End

		It 'does not pad strings of length 4'
			When call base64_pad 'Y2F0'
			The output should equal 'Y2F0'
		End

		It 'does not pad strings of length 0'
			When call base64_pad
			The output should equal ''
		End
	End
End
