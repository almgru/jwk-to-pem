#shellspec shell=sh

Describe 'json_to_hex()'
	Include ./bin/jwk-to-pem

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
