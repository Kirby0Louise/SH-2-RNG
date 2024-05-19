# SH-2-RNG
A SH-2 (32X, Saturn) fork of NESHacker's RNG Library.

## Overview
SH-2-RNG is a library that implements higher order RNG methods for SEGA 3D console games in assembly.

This library is a fork of https://github.com/NesHacker/NES-RNG, which itself expands on [Brad Smith's general purpose PRNG library](https://github.com/bbbradsmith/prng_6502/tree/master)
by providing easy to use routines for generating random numbers over
various ranges.

It also provides quality of life macros for handling seeding and generating
many random numbers between render frames.

SH-2-RNG has been optimized to take advantage of the superior CPUs available on SEGA's 3D consoles and greatly speedup and simplify the LFSR process.

This library is small enough to run entirely from the slave SH-2's cache, allowing full parallelism with the master.
