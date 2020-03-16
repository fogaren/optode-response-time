[ tau ] = calculate_tau( T, P, DO, varargin )
% calculate_tau: calculate the response time for each pair of profiles
%
% Author: Christopher Gordon, chris.gordon@dal.ca
% Last update: Christopher Gordon, January 29, 2020
%
% INPUT
% -----------------------------------------------------------------------------
% REQUIRED ARGUMENTS
%
% T: time matrix where each row is a profile, monotonically increasing
% dims(M, N)
%
% P: pressure matrix, should alternate between upcasts and downcasts
% dims(M, N)
%
% DO: dissolved oxygen matrix with valuues corresponding to each time/pressure
% dims(M, N)
%
% OPTIONAL PARAMETERS
%
% zrange: limits of depth to optimize over, default is (25,150)
% dims(1,2)
%
% zres: resolution of depth to be interpolated to to perform comparison,
% defalult is 1
% scalar
%
% OUTPUT
% -----------------------------------------------------------------------------
% tau: response time values for each pair of profiles dims(1, M-1)

[M, N] = size(T)



end  % function
