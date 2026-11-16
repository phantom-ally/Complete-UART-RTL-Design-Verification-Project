#!/usr/bin/env bash
set -euo pipefail
mkdir -p build
iverilog -g2012 -Wall -s uart_system_tb -o build/uart_sim \
  rtl/uart_tx.v rtl/uart_rx.v rtl/uart_top.v tb/uart_system_tb.sv
vvp build/uart_sim
