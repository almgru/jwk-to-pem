#!/bin/sh

main() {
	JWK_FILE="$1"

	cat <<- EOF
		asn1 = SEQUENCE:private_key
		
		[private key]
		
		version = INTEGER:0
		
		n = 	INTEGER:$(json_to_hex 'n')
		e = 	INTEGER:$(json_to_hex 'e')
		d = 	INTEGER:$(json_to_hex 'd')
		p = 	INTEGER:$(json_to_hex 'p')
		q = 	INTEGER:$(json_to_hex 'q')
		exp1 = 	INTEGER:$(json_to_hex 'dp')
		exp2 = 	INTEGER:$(json_to_hex 'dq')
		coeff = INTEGER:$(json_to_hex 'qi')
	EOF
}

json_to_hex() {
	json="$(jq -Mqr '.$1' < "$JWK_FILE")"
	decoded="$(base64url_decode "$json")"
	to_hex "$decoded"
}

base64url_decode() {
	base64_pad "$1" | tr '\-_' '+/' | base64 -d
}

base64_pad() {
	padded="$1"
	until test "$(( ${#padded} % 3 ))" -eq 0; do
		padded="${padded}="
	done
	printf "%s" "$padded"
}

to_hex() {
	echo "0x$(print "%s" "$1" | xxd -ps -u)"
}

main "$@"
