# 8-Bit Timers (TMR)

## Introduction

This LSI includes **two on-chip 8-bit timer units**: Unit 0 and Unit 1. Each unit consists of **two independent 8-bit counter channels**, giving a total of **four channels**.

The 8-bit timer module is highly flexible and can be used for a variety of applications, including:
- Counting external events
- Generating counter reset signals
- Generating interrupt requests
- Producing pulse outputs with a desired duty cycle using compare-match logic

Each channel uses **two compare-match registers**, allowing for accurate timing and control in embedded systems.


## Block Diagram

![8-Bit Timer Module](Picture/Screenshot%202025-06-14%20at%2010-30-28%208bit_Timer.png)


## Operation
### Pulse Output:
//UNIT 0
0000_0000_0000_0000 	//TCNT
0000_1110_1111_1111 	//TCORA
0000_0111_1111_1111 	//TCORB
0000_1001_0000_0000 	//TCR 	
0000_0001_0000_0000 	//TCCR
0000_0110_0001_0000 	//TCSR

//UNIT 1
0000_0000_0000_0000 	//TCNT
1111_1111_1111_1111 	//TCORA
1111_1111_1111_1111 	//TCORB
0000_0000_0000_0000 	//TCR
0000_0000_0000_0000 	//TCCR
0000_0000_0001_0000 	//TCSR
![Example of Pulse Output](Picture/ExampleOfPulseOutput.png)
![Simulation of Pulse Output](Picture/PulseOutput.png)
