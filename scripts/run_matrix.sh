#!/usr/bin/env bash
# Full compile-time configuration sweep: DATA_BITS 5..9, parity 0..2, stop bits 1..2.
set -euo pipefail
mkdir -p build
for width in 5 6 7 8 9; do
  for parity in 0 1 2; do
    for stops in 1 2; do
      tag="w${width}_p${parity}_s${stops}"
      echo "=== UART config ${tag} ==="
      iverilog -g2012 -Wall -s uart_system_tb \
        -P uart_system_tb.DATA_BITS=${width} \
        -P uart_system_tb.PARITY_MODE=${parity} \
        -P uart_system_tb.STOP_BITS=${stops} \
        -o "build/${tag}.vvp" \
        rtl/uart_tx.v rtl/uart_rx.v rtl/uart_top.v tb/uart_system_tb.sv
      vvp "build/${tag}.vvp" | tee "build/${tag}.log"
      grep -q "OVERALL: PASS" "build/${tag}.log"
    done
  done
done
echo "All 30 UART parameter configurations passed."
