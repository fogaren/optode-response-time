# optode-response-time

## Installation

This code can also be downloaded from the [MATLAB File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/).

## User Guide

### Structure

The main directory contains `calculate_tau.m`, the main function for the end
user. In the `test` directory there is some limited data and a script (`test.m`)
for the user to run to get a feel for how the package works and ensure that it
runs properly on their machine. In the `tools` directory there are functions
that the mean function employs.

### Parameters

### Input Data

Input data for `calculate_tau.m` should be in 2D matrix form, where each row is
an individual profile, and rows alternate direction of observation (for
example, all even rows could be upcasts and all odd rows downcasts or
vice-versa). Time should be in `MATLAB` datenum format. Profiles should be
organized such that time is monotonically increasing (i.e. pressure will be
monotonically decreasing for an upcast). Below is some made-up data to
demonstrate the proper data format:


```matlab
% depth matrix
P = [[200, 195, 190, ..., 10, 5]; % profile 1, upcast
     [5, 10, 15, ..., 195, 200 ]; % profile 2, downcast
     [200, 195, 190, ..., 10, 5]; % profile 3, upcast
     ...
     [200, 195, 190, ..., 10, 5];]; % profile N, upcast *or* downcast

% time matrix, matlab datenum, monotonically increasing row to row
T = [[7.36451000e+05, 7.36451005e+05, 7.36451010e+05, ..., 7.36451195e+05]
     [7.36451200e+05, 7.36451205e+05, 7.36451210e+05, ..., 7.36451395e+05]
     ...
     [7.36454804e+05, 7.36454809e+05, 7.36454814e+05, ..., 7.36455000e+05]];

% oxygen data
O = [
  % corresponding oxygen values for each time/depth
];
```

`tools`

`test`
