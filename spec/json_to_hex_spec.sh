#shellspec shell=sh

Describe 'json_to_hex()'
	Include ./bin/jwk-to-pem

	# shellcheck disable=SC2034
	JWK_FILE=/dev/stdin

	It 'takes a json key with a base64url value and converts the value to hex'
		pad_with() { printf 'c2hvdWxkIGJlIGhleA=='; }
		decode_base64url() { printf 'should be hex'; }
		to_hex() { printf '73686f756c6420626520686578'; }
		prefix() { printf '0x73686f756c6420626520686578'; }

		Data '{"a":"c2hvdWxkIGJlIGhleA","b":"YQ"}'
		When call json_to_hex "a"
		The output should equal '0x73686f756c6420626520686578'
	End
End
