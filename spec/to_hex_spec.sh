#shellspec shell=sh

Describe 'to_hex()'
	Include ./bin/jwk-to-pem

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
