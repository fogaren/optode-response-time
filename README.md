# optode-response-time

The `MATLAB` code included in this repository is designed to determine the
response time of oxygen optodes deployed on autonomous floats _in-situ_. The
process requires timestamps for each measurement and a sequence of both up- and
downcast profiles. For more information on the method see
_[Gordon et al. (2020)](https://doi.org/10.5194/bg-2020-119)_.

## Installation

This code is also available on [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/74579-optode-response-time)

## User Guide

### Parameters

The following parameters are optional arguments for `calculate_tau.m`:

- `zlim`: lower and upper depth bounds to perform optimization over,
default is [25,175], dimensions (1, 2)
- `zres`: resolution for profiles to be interpolated to, default is 1,
dimensions (scalar)
- `tlim`: lower and upper time constant bounds to perform optimization over,
default is [0,100], dimensions (1, 2)
- `tres`: resolution to linearly step through `tlim`, default is 1
dimensions (scalar)

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
P = [
  [200, 195, 190, .., 10, 5]; % profile 1, upcast
  [5, 10, 15, .., 195, 200 ]; % profile 2, downcast
  [200, 195, 190, .., 10, 5]; % profile 3, upcast
  ...
  [200, 195, 190, .., 10, 5]; % profile N, upcast *or* downcast
];

% time matrix, matlab datenum, monotonically increasing row to row
T = [
  [7.36451000e+05, 7.36451005e+05, 7.36451010e+05, .., 7.36451195e+05]
  [7.36451200e+05, 7.36451205e+05, 7.36451210e+05, .., 7.36451395e+05]
  ...
  [7.36454804e+05, 7.36454809e+05, 7.36454814e+05, .., 7.36455000e+05]
];

% oxygen data
DO = [
  % corresponding oxygen values for each time/depth
];
```

### Test

In the `test` directory, the script `test.m` and data `example_data.mat` should
run with no changes required. This gives a very base level example of how
the functions work and the output.

### Citing and Licensing

Cite as: Gordon, C., Fennel, K., Richards, C., Shay, L. K., and Brewster, J. K.: Can ocean community production and respiration be determined by measuring high-frequency oxygen profiles from autonomous floats?, Biogeosciences Discuss., https://doi.org/10.5194/bg-2020-119, in review, 2020.

Please note that this code is provided as-is under the MIT license and is
subject to periodic updates and improvements. If you are interested in
contributing to this repository, please contact Christopher Gordon at
[Chris.Gordon@dfo-mpo.gc.ca](mailto:Chris.Gordon@dfo-mpo.gc.ca).
