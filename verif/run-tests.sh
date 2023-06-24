# !bin/bash

set -e
error=0

riscof -v debug run --config=config.ini \
           --suite=riscv-arch-test/riscv-test-suite/rv32i_m/I \
           --env=riscv-arch-test/riscv-test-suite/env \
           --no-browser

if grep -rniq riscof_work/report.html -e '>0failed<'
then
    echo "Test successful!"
    error=$((error+0))
else
    echo "Test FAILED!"
    error=$((error+1))
fi

riscof -v debug run --config=config.ini \
           --suite=riscv-arch-test/riscv-test-suite//rv32i_m/M \
           --env=riscv-arch-test/riscv-test-suite/env \
           --no-browser

if grep -rniq riscof_work/report.html -e '>0failed<'
then
    echo "Test successful!"
    error=$((error+0))
else
    echo "Test FAILED!"
    error=$((error+1))
fi
