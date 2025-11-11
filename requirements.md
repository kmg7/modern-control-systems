# System Requirements for Installing `slycot` on Ubuntu

## Overview
The `slycot` package depends on several system-level libraries and compilers to build successfully.  
This document lists the required dependencies and their purposes.

---

## 1. Core Build Tools
### Package: `build-essential`
- **Purpose:** Provides core compilation tools such as `gcc`, `g++`, and `make`.  
- **Reason:** Required for compiling native C/C++ extensions used by many Python scientific packages.

---

## 2. Fortran Compiler
### Package: `gfortran`
- **Purpose:** GNU Fortran compiler used to compile Fortran source files.  
- **Reason:** `slycot` includes Fortran-based routines for numerical computations in control systems.

---

## 3. Python Development Headers
### Package: `python3-dev`
- **Purpose:** Supplies Python C API headers and static libraries.  
- **Reason:** Needed for building Python modules with C/Fortran extensions against the installed Python version.

---

## 4. Linear Algebra Libraries
### Package: `libblas-dev`
- **Purpose:** Provides the Basic Linear Algebra Subprograms (BLAS) library.  
- **Reason:** Offers optimized vector and matrix operations required by `slycot` and `scipy`.

### Package: `liblapack-dev`
- **Purpose:** Provides the Linear Algebra PACKage (LAPACK) library built on top of BLAS.  
- **Reason:** Implements advanced matrix factorization and equation-solving routines used by `slycot`.

---

## 5. Installation Command Summary
```bash
sudo apt update
sudo apt install build-essential gfortran python3-dev libblas-dev liblapack-dev
