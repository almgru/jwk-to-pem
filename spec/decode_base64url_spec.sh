#shellspec shell=sh

Describe 'decode_base64url()'
	Include ./bin/jwk-to-pem

	It 'decodes base64url encoded data'
		Data "aGVsbG8="
		When call decode_base64url
		The output should equal 'hello'
	End

	It 'correctly decodes data with underscores'
		Data "b2s_"
		When call decode_base64url
		The output should equal 'ok?'
	End

	It 'correctly decodes data with dashes'
		Data "aGl-"
		When call decode_base64url
		The output should equal 'hi~'
	End
End

