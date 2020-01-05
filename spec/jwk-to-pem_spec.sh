#shellspec shell=sh

Describe 'jwk-to-pem'
	Include ./bin/jwk-to-pem

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
