# Infix -> (Perl)fix Converter

---

## Description
Converts infix expressions to prefix expressions. Supports an interactive CLI and a batch mode for quick access to the converted data.

---

## Requirements
- Perl 5 must be installed. (Keep in mind that default Perl coming with OS distributions may not include the needed libraries, make sure to have cpan installed as well, just the cpan installation itself imports all of the needed dependencies)
- Unix shell (For the test scenarios only)
---

## Usage

### Interactive mode:
```perl perlfix```
### For batch mode:

```perl perlfix '<expression>' -b```

or

```perl perlfix '<expression>' --batch```


### Test scenarios

Under the 'test' folder. The test shell script calls the app in batch mode with a set ot fixed test cases that can be freely extended.

```<shell> test.sh```


---

Made as an university assignment by Vesislav Dimitrov (2024)