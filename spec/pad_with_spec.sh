#shellspec shell=sh

Describe 'pad_with()'
	Include ./bin/jwk-to-pem

	It 'pads data from stdin'
	    Data 'to pad'
	    When call pad_with
	    The status should be success
	    The output should match '*to\ pad*'
	End

	It 'does not pad data from argument'
	    When call pad_with '%' 2 'data'
	    The status should be failure
	End

	# shellcheck disable=SC2016
	It 'pads data with character $1'
	    Data '123'
	    When call pad_with '#'
	    The output should equal '123#'
	End

	# shellcheck disable=SC2016
	It 'pads data to length that is multiple of $2'
	    Data 'a'
	    When call pad_with '=' 10
	    The length of the output should equal 10
	End

	It 'pads with = to length that is multiple of 4 by default'
	    Data '12345'
	    When call pad_with
	    The output should equal '12345==='
	End

	It 'adds padding to the end of the data'
	    Data '123'
	    When call pad_with
	    The output should end with '='
	End

	It 'does not add padding to the start of the data'
	    Data '123'
	    When call pad_with
	    The output should start with '123'
	End

	# shellcheck disable=SC2016
	It 'does not pad data of length $2'
	    Data '123'
	    When call pad_with '_' '3'
	    The output should equal '123'
	End
End
