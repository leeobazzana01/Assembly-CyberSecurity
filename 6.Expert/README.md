# Expert
## MIPS no Hardware
(FPGA implementations, Verilog/VHDL)

## Compiladores para MIPS
(GCC cross-compilation, backends LLVM)

## Sistemas Operacionais
(Bootloaders MIPS, context switching)

## SIMD MIPS
(MMI, uso de registradores especiais)

markdown
# Integração MIPS-Alto Nível
## Chamadas entre C e MIPS
1. **From C to MIPS**:
   ```c
   extern void mips_func();
   int main() { mips_func(); }```
2. **From mips to C**:
	```.extern c_func
		jal c_func
	```