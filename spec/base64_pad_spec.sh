#shellspec shell=sh

Describe 'base64_pad()'
	Include ./bin/jwk-to-pem

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
