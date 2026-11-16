#!/usr/bin/env bash
set -e

echo "=== 1. Generating UART Architecture (Yosys) ==="
mkdir -p build
yosys -q -p "read_verilog rtl/uart_tx.v rtl/uart_rx.v rtl/uart_top.v; hierarchy -check -top uart_top; proc; opt; show -format svg -prefix build/uart_arch uart_top"

echo "=== 2. Running Simulation (Icarus Verilog) ==="
make sim

echo "=== 3. Opening Architecture Diagram & Waveforms ==="
xdg-open build/uart_arch.svg >/dev/null 2>&1 &
gtkwave build/uart_system.vcd >/dev/null 2>&1 &

echo "Demo ready: architecture saved to build/uart_arch.svg, waveform at build/uart_system.vcd"
