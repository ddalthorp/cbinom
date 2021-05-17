Code release for the "cbinom" R package: "Continuous Analog of a Binomial Distribution: d/p/q/r Family of Functions"

Dan Dalthorp, Statistician, U.S. Geological Survey
28 August 2018

---------------------
CONTENTS OF THIS FILE
---------------------
   
 * Disclaimer
 * Introduction
 * Requirements
 * Contents
 * Maintainers

----------
DISCLAIMER
----------
This software has been approved for release by the U.S. Geological Survey (USGS). Although the software has been subjected to rigorous review, the USGS reserves the right to update the software as needed pursuant to further analysis and review. No warranty, expressed or implied, is made by the USGS or the U.S. Government as to the functionality of the software and related material nor shall the fact of release constitute any such warranty. Furthermore, the software is released on condition that neither the USGS nor the U.S. Government shall be held liable for any damages resulting from its authorized or unauthorized use.

------------
INTRODUCTION
------------
This R package provides a standard d/p/q/r suite of functions for a continuous binomial distribution as presented by:

Ilienko, Andreii. 2013. Continuous counterparts of Poisson and binomial distributions and their properties. Annales Univ. Sci. Budapest, Sect. Comp. 39: 137-147.


------------
REQUIREMENTS
------------
Several files are built into an R package and stored in two different formats: (1) .zip, which contains compiled binaries for installing on computers that use the Microsoft Windows operating system, and (2) .tar.gz, which includes source code for installing the package for other operating systems (or for Windows with a functioning Rtools tool chain). The package must be installed for and by the R statistical package (https://www.r-project.org/). 

Running the programs requires knowledge of R statistical computing software. Usage closely parallels that of the standard R functions dbinom, pbinom, qbinom, and rbinom but allows for non-integer values of 'x' and/or 'size'.

--------
CONTENTS
--------
Other than this README, the contents of this data release include:
cbinom_1.3.zip     (binary files for installation on Windows)
cbinom_1.3.tar.gz  (source files for installation on other operating systems [or Windows with Rtools]


-----------
Maintainers
-----------
There may be occasional updates or maintenance of this software release as incremental improvements are made. This software release is also available on CRAN ( https://CRAN.R-project.org/package=cbinom/)

