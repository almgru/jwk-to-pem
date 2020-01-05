#shellcheck shell=sh

Describe 'jwk-to-pem'
	Include ./bin/jwk-to-pem

	Describe 'base64url_decode()'
		# base64_pad stub that just echoes its arg
		base64_pad() {
			printf "%s" "$1"
		}

		It 'decodes hello'
			When call base64url_decode 'aGVsbG8='
			The output should equal 'hello'
		End

		It 'handles decodes underscores'
			When call base64url_decode 'Pz8_'
			The output should equal 'ok?'
		End

		It 'handles decodes dashes'
			When call base64url_decode 'aGI-'
			The output should equal 'hi~'
		End
	End

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

		It 'does not pad 0-length string'
			When call base64_pad
			The output should equal ''
		End
	End
End
