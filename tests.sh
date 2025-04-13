#!/bin/bash

TESTS=(
  "arith"
  "assignment"
  "bool_no_let"
  "bool_let"
  "let_no_init"
  "let_init"
  "unary"
  "scopes"
  "pa3"
  "while"
  "string"
  "string_out_of_range"
  "THE_ULTIMATE_TEST"
  "attributes"
  "methods"
  "method_other_class"
  "method_inheritance"
  "method_overriding"
  "dynamic_dispatch"
  "static_dispatch"
  "dispatch_void"
  "abort"
  "type_name"
)

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' 

for test in "${TESTS[@]}"; do
  echo "Running $test..."

  cool --type "./tests/$test.cl"
  python3 ./src/main.py "./tests/$test.cl-type"
  gcc -no-pie -static ./tests/$test.s -o my_out
  ./my_out > my_output.txt

  cool "./tests/$test.cl" > ref_output.txt

  if diff -q my_output.txt ref_output.txt > /dev/null; then
    echo -e "${GREEN}[PASS]${NC} $test"
  else
    echo -e "${RED}[FAIL]${NC} $test"
    echo "Diff:"
    diff my_output.txt ref_output.txt
  fi

  echo
done

rm my_out
rm my_output.txt
rm ref_output.txt
rm -rf ./src/__pycache__