
# 💡 Lab02 - Unidad Aritmético-Lógica (ALU)

## 👥 Integrantes
* [Brandon Alexis Galeano Martínez](https://github.com/BAgaleanoM)
* [Juan David Torres Román](https://github.com/JuandavidT02)

---

## 📘 Índice
1. [Descripción General](#descripción-general)
2. [Operaciones de la ALU](#operaciones-de-la-alu)
3. [Estructura del Proyecto](#estructura-del-proyecto)
4. [Simulaciones](#simulaciones)
5. [Implementación en FPGA](#implementación-en-fpga)
6. [Conclusiones](#conclusiones)
7. [Referencias](#referencias)

---

## 🧾 Descripción General

En este laboratorio se diseñó una **Unidad Aritmético-Lógica (ALU)** de 4 bits utilizando el lenguaje **Verilog**.  
El objetivo fue implementar un módulo capaz de realizar operaciones aritméticas y lógicas básicas, controladas mediante una señal de selección (`sel`).  

El proyecto incluyó:
- Implementación modular de cada operación.
- Creación de un multiplexor para seleccionar la salida correspondiente.
- Testbench con **GTKWave**.
- Pruebas físicas en una **FPGA Zybo Z7**.

---

## ⚙️ Operaciones de la ALU

La ALU ejecuta **cinco operaciones** sobre dos operandos de 4 bits (`A` y `B`).  
Cada operación está implementada como un bloque independiente y controlada por la señal `sel`.

| Código `sel` | Operación | Descripción |
|---------------|------------|--------------|
| `000` | Suma | `Y = A + B` |
| `001` | Resta | `Y = A - B`  |
| `010` | Multiplicación | `Y = A * B` |
| `011` | OR Lógica | `Y = A | B` |
| `100` | Corrimiento Izquierda | `Y = A << 1` |

### ➕ Suma
Realizada con un sumador completo de 4 bits.  
Se verifica el acarreo (`carry`) y el posible **overflow** cuando el resultado excede los 4 bits.

### ➖ Resta
Implementada mediante el **complemento a dos** del operando `B`, reutilizando el mismo bloque del sumador.

### ✖️ Multiplicación
Multiplica los operandos `A` y `B`, generando una salida de **8 bits**, lo cual permite comprobar ampliaciones de tamaño y saturación.

### 🧠 OR Lógica
Opera bit a bit entre `A` y `B`.  
Permite verificar el comportamiento combinacional puro de la ALU.

### ⬅️ Corrimiento Izquierda
Desplaza todos los bits de `A` una posición a la izquierda, equivalente a una multiplicación por 2.  
Permite observar el efecto sobre los bits más significativos.

---

## 🗂️ Estructura del Proyecto

El repositorio contiene los siguientes archivos:

| Archivo | Descripción |
|----------|-------------|
| **`alu4b.v`** | Módulo principal que integra todas las operaciones y el multiplexor de selección. |
| **`sumador4b.v`** | Implementación del sumador completo de 4 bits. |
| **`resta4b.v`** | Módulo de resta usando complemento a dos. |
| **`mult4b.v`** | Módulo de multiplicación de 4 bits con salida de 8 bits. |
| **`or4b.v`** | Implementación de la compuerta OR bit a bit. |
| **`shift_left.v`** | Corrimiento lógico a la izquierda. |
| **`mux.v`** | Multiplexor de 5 entradas que selecciona la operación según `sel`. |
| **`alu4b_tb.v`** | Archivo de testbench donde se prueban todas las operaciones. |
| **`constraints.xdc`** | Asignación de pines para la FPGA (entradas, salidas y selectores). |

Cada módulo fue diseñado de forma **modular y jerárquica**, facilitando su integración, simulación y depuración.

---

## 🧩 Simulaciones

Se elaboró un **testbench (`alu4b_tb.v`)** que prueba todas las operaciones de la ALU secuencialmente.  
Durante la simulación se variaron `A`, `B` y `sel`, observando la salida `Y` y las señales de control.

**Herramientas utilizadas:**
- **Vivado** → Síntesis y simulación.
- **GTKWave** → Visualización de formas de onda.

### 🔍 Resultados de simulación
- Los resultados de cada operación coincidieron con los valores teóricos esperados.
- El **multiplexor** cambió correctamente la salida en función de `sel`.
- No se observaron retardos significativos ni errores de propagación.
- En las operaciones aritméticas, se comprobó el manejo adecuado del overflow.

**Ejemplo de prueba:**
| A | B | sel | Operación | Resultado esperado |
|---|---|-----|------------|--------------------|
| 3 | 5 | 000 | Suma | 8 (1000) |
| 9 | 2 | 001 | Resta | 7 (0111) |
| 4 | 3 | 010 | Multiplicación | 12 (00001100) |
| 6 | 3 | 011 | OR | 7 (0111) |
| 5 | X | 100 | Corrimiento izquierda | 10 (1010) |

Las formas de onda en **GTKWave** muestran claramente los cambios de salida y el efecto del selector `sel` en tiempo real.

---

## 🔌 Implementación en FPGA

En la implementación práctica, se usaron **DIP Switches** y **LEDs** de la placa FPGA para representar las entradas y salidas.

| Señal | Descripción | Elemento físico |
|-------|--------------|----------------|
| `A[3:0]` | Entradas del operando A | DIP Switch (SW0–SW3) |
| `B[3:0]` | Entradas del operando B | DIP Switch (SW4–SW7) |
| `sel[2:0]` | Selector de operación | DIP Switch (SW8–SW10) |
| `Y[7:0]` | Salida de la ALU | LEDs (LD0–LD7) |

**Configuración:**
- Se utilizó **Vivado Design Suite** para síntesis, implementación y generación del bitstream.  
- Se asignaron los pines mediante el archivo `.xdc` de la FPGA Zybo Z7.  
- El sistema se probó con valores representativos para validar todas las operaciones.

**Observaciones:**
- Las salidas respondieron de forma inmediata a los cambios en los switches.  
- No se presentaron errores de conexión ni conflictos de pines.  
- La multiplicación mostró correctamente los 8 bits de salida en los LEDs.

---

## 🧠 Conclusiones

- Se implementó correctamente una **ALU modular de 4 bits**, capaz de realizar cinco operaciones aritmético-lógicas básicas.  
- El uso de **módulos jerárquicos** facilitó el diseño, depuración y simulación del sistema.  
- Las **simulaciones** en Vivado y GTKWave confirmaron la correcta selección de operaciones y el buen funcionamiento del multiplexor.  
- La **implementación en FPGA** permitió validar el diseño en hardware, comprobando la relación entre el modelo digital y el comportamiento físico.  
- Este laboratorio permitió afianzar conceptos de **arquitectura digital, diseño combinacional, reutilización de módulos y verificación por simulación**.

---

## 📚 Referencias

- M. Morris Mano, *Diseño Digital: Principios y Prácticas*, 4ta edición, Pearson, 2011.  
- Xilinx Inc., *Vivado Design Suite User Guide*, UG973, 2022.  
- HDLBits, *Arithmetic Logic Unit Exercises*, [https://hdlbits.01xz.net](https://hdlbits.01xz.net)  
- Pineda Vargas, E. F., *Material de clase: Electrónica Digital II – Universidad Nacional de Colombia*, 2025.  
- Patterson, D. & Hennessy, J., *Computer Organization and Design: The Hardware/Software Interface*, Morgan Kaufmann, 2017.
