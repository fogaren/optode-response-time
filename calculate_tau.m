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
%
% OUTPUT
% -----------------------------------------------------------------------------
% tau: response time values for each pair of profiles dims(1, M-1)



end  % function
