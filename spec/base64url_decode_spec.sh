#shellspec shell=sh

Describe 'base64url_decode()'
	Include ./bin/jwk-to-pem

	# stub
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

