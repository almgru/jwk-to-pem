#shellspec shell=sh

Describe 'to_hex()'
	Include ./bin/jwk-to-pem

	It 'converts data to hexadecimal'
		Data "Oc9j"
		When call to_hex
		The output should start with '4F63396A'
	End

	It 'produces uppercase letters'
		Data "ͺ"
		When call to_hex
		The output should start with 'CDBA'
	End
End
