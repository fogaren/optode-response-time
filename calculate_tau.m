[ tau ] = calculate_tau( T, P, DO, varargin )
% calculate_tau: calculate the response time for each pair of profiles
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
% zlim: lower and upper bounds to perform optimization over, default is (25,175)
% dims(1, 2)
%
% zres: resolution for profiles to be interpolated to, default is 1
% scalar
%
% OUTPUT
% -----------------------------------------------------------------------------
% tau: response time values for each pair of profiles dims(1, M-1)

% ------------------------- PARSE OPTIONAL PARAMETERS -------------------------
% zlim
index = find(strcmpi(varargin,'zlim'));
if isempty(index)
    zlim = [25,175];
elseif length(varargin >= index+1 && isvector(varargin{index+1}))
    zlim = varargin{index+1};
end

% zres
index = find(strcmpi(varargin,'zres'));
if isempty(index)
    zres = 1;
elseif length(varargin >= index+1 && isscalar(varargin{index+1}))
    zres = varargin{index+1};
end



end  % function
