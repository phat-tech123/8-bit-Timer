# 8-Bit Timers (TMR)

## Introduction

This LSI includes **two on-chip 8-bit timer units**: Unit 0 and Unit 1.  
Each unit consists of **two independent 8-bit counter channels**, giving a total of **four channels**.

The 8-bit timer module is highly flexible and can be used for a variety of applications, including:

- Counting external events
- Generating counter reset signals
- Generating interrupt requests
- Producing pulse outputs with a desired duty cycle using compare-match logic

Each channel uses **two compare-match registers**, allowing for accurate timing and control in embedded systems.

---

## Block Diagram

![8-Bit Timer Module](Picture/Screenshot%202025-06-14%20at%2010-30-28%208bit_Timer.png)
