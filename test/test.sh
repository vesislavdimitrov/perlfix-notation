#!/bin/bash

# Color codes
declare GREEN='\033[0;32m'
declare RED='\033[0;31m'
declare NC='\033[0m'

#---------------------------------------------
# TEST CASES
#---------------------------------------------
function test_case_1() {
    local expression="a*b-(c+d)"
    local expected="-*ab+cd"
    local converted_expression=$(convert_expression "${expression}")
    echo "${expression}"
    [[ "${converted_expression}" == "${expected}" ]]
}

function test_case_2() {
    local expression="a-d*c*(h^d)"
    local expected="-a**dc^hd"
    local converted_expression=$(convert_expression "${expression}")
    echo "${expression}"
    [[ "${converted_expression}" == "${expected}" ]]
}

function test_case_3() {
    local expression="a+(a^b^c)-(h+z)"
    local expected="-+a^^abc+hz"
    local converted_expression=$(convert_expression "${expression}")
    echo "${expression}"
    [[ "${converted_expression}" == "${expected}" ]]
}

function test_case_4() {
    local expression="(a+(a^b^c)-(h+z))^k"
    local expected="^-+a^^abc+hzk"
    local converted_expression=$(convert_expression "${expression}")
    echo "${expression}"
    [[ "${converted_expression}" == "${expected}" ]]
}

function test_case_5() {
    local expression="(a+b/c)*f^(h/i)"
    local expected="*+a/bc^f/hi"
    local converted_expression=$(convert_expression "${expression}")
    echo "${expression}"
    [[ "${converted_expression}" == "${expected}" ]]
}

function test_case_6() {
    local expression="((((a-d)/b)^f)-x)"
    local expected="-^/-adbfx"
    local converted_expression=$(convert_expression "${expression}")
    echo "${expression}"
    [[ "${converted_expression}" == "${expected}" ]]
}

function test_case_7() {
    local expression="(a%d)%g+a^d"
    local expected="+%%adg^ad"
    local converted_expression=$(convert_expression "${expression}")
    echo "${expression}"
    [[ "${converted_expression}" == "${expected}" ]]
}

#---------------------------------------------
# UTILS
#---------------------------------------------
function run_tests() {
    local test_name="$1"
    local test_function="$2"

    if "${test_function}"; then
        echo -e "${GREEN}Success............${test_name}${NC}"
        return 1
    fi

    echo -e "${RED}Fail...............${test_name}${NC}"
    return 0
}

function convert_expression() {
    local expression="$1"
    local output=$(perl perlfix "${expression}" -b)
    echo "${output}" | grep -o 'Converted expression: .*' | cut -d' ' -f3
}

#---------------------------------------------
# EXECUTION
#---------------------------------------------
declare -a testCases=(
    "test_case_1"
    "test_case_2"
    "test_case_3"
    "test_case_4"
    "test_case_5"
    "test_case_6"
    "test_case_7"
)
for test_case in "${testCases[@]}"; do
    run_tests "${test_case}" "${test_case}"
done
