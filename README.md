
![CRAN_Version](http://www.r-pkg.org/badges/version/BTL.CJ)  
##### development version (in dev branch)
[![Dev Build](https://travis-ci.org/SanVerhavert/BTL.CJ.png?branch=dev)](https://travis-ci.org/SanVerhavert/BTL.CJ) [![Dev codecov](https://codecov.io/gh/SanVerhavert/BTL.CJ/branch/dev/graph/badge.svg)](https://codecov.io/gh/SanVerhavert/BTL.CJ)
##### Release version (in master branch)
[![Build](https://travis-ci.org/SanVerhavert/BTL.CJ.png?branch=master)](https://travis-ci.org/SanVerhavert/BTL.CJ) [![codecov](https://codecov.io/gh/SanVerhavert/BTL.CJ/branch/master/graph/badge.svg)](https://codecov.io/gh/SanVerhavert/BTL.CJ)

# Fixation duration
`fixationDuration` is an R package that identifies first pass and second pass fixations and
 their respective total durations. If so specified it identifies third pass fixations and further and
 their respecitve total durations.  

This package is not yet on CRAN.  

## Install

The development version of the package can be downloaded after installing
`devtools` and by running  
```
devtools::install_github( "SanVerhavert/fixatioDuration", ref = "dev" )
```   
It cannot be guaranteed this is a stable version. Check the dev build badge to see
if the development version is stable (passing).  


## Contribute

You can contribute to this package in two ways:  
1/ by submitting issues or requests  
2/ by suggesting changes through pull requests  

### Issues or requests
You can submit issues or feature requests through the issues tab on GitHub.  
Please provide a clear description of the issue: e.g. code that causes the issue,
possible error message, the data that causes the error (as .txt file [preferred]
or R code[also preferred] or described )

### Pull requests
If you directly want to contribute code or changes, please fork this repository.
You can then add your changes and create a pull request. Please document your
pull request, otherwise it will be rejected.  
This repository follows the [gitflow logic](https://nvie.com/posts/a-successful-git-branching-model/).
Please respect this logic and the branch structure in the following section.

## Branch structure
This repository follows the [gitflow logic](https://nvie.com/posts/a-successful-git-branching-model/).  

### Branch logic
These are the main banches:
- master &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Branch containing stable versions; do not commit to this branch;
Only merge from release branch.
- release &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Branch for preparing releases; commits to this branch only contain
version bumps and generated documentation; only merge from dev branch; merge to
master and dev branches
- dev &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Branch for main development; all commits allowed; merge from master
and release branches  

Supporting branches [optional]:
- feature_*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Branches for developing new features; can be used to keep dev
branch clean and the development build working; only branches from and merges to
the dev branch
- issue_*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Branches for solving issues; name mostly referring to issue numbers;
can branch from every other branch except (!) from master; merges only with the
branch from witch it was branched

### Overview of this repository

.  
|_ master  
|\\_ release  
|\\_ dev  
