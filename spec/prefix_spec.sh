#shellspec shell=sh

Describe 'prefix()'
    Include ./bin/jwk-to-pem

    It 'reads data from stdin'
	Data 'data'
	When call prefix
	The status should be success
	The output should match '*'
    End

    # shellcheck disable=SC2016
    It 'Adds $1 to the start of the data'
	Data 'data'
	When call prefix '^'
	The output should equal '^data'
    End
End
