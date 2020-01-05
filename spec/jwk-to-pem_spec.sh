#shellcheck shell=sh

Describe 'jwk-to-pem'
	Include ./bin/jwk-to-pem

	Describe 'base64_pad()'
		It 'pads 2-char strings with 2 ='
			When call base64_pad 'YQ'
			The output should equal 'YQ=='
		End

		It 'pads 7-char strings with 1 ='
			When call base64_pad 'aGVsbG8'
			The output should equal 'aGVsbG8='
		End

		It 'pads 4-char strings with no ='
			When call base64_pad 'Y2F0'
			The output should equal 'Y2F0'
		End
	End
End
