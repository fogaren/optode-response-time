
floatID = 'f7940';
[S, T, P, DOXY, t] = load_float_data(floatID);
PDEN = sw_pden(S, T, P) - 1000;

pres_tau = calculate_tau(t, P, DOXY, 'tres', 0.5);

fprintf('floatID: %s\n', floatID)
fprintf('Number of profiles analyzed: %d\n', size(T, 1))

fprintf('-------------------- PRESSURE RESULTS --------------------\n')
fprintf('Number of time constants found: %d\n', numel(pres_tau))
fprintf('Median response time: %3.1f, standard deviation %3.3f\n', median(pres_tau), std(pres_tau))

pden_tau = calculate_tau(t, PDEN, DOXY, 'tres', 0.5, 'zlim', [22,26], 'zres', 0.1);

fprintf('-------------------- DENSITY RESULTS --------------------\n')
fprintf('Number of time constants found: %d\n', numel(pden_tau))
fprintf('Median response time: %3.1f, standard deviation %3.3f\n', median(pden_tau), std(pden_tau))

function [Smat, Tmat, Pmat, DOXYmat, tmat] = load_float_data(floatID)

    files = get_continuous_float_files(floatID);
    [M, N] = get_doxy_dims(files);
    Smat = nan(M,N); Tmat = nan(M,N); Pmat = nan(M,N);
    DOXYmat = nan(M,N); tmat = nan(M,N);

    for ii=1:M
        fn = files{ii};
        [S, T, P, DOXY, t, ~] = load_file_data(fn);
        n = numel(DOXY);
        Smat(ii,1:n) = S; Tmat(ii,1:n) = T; Pmat(ii,1:n) = P;
        DOXYmat(ii,1:n) = DOXY; tmat(ii,1:n) = t;
    end
end

function cont_files = get_continous_float_files(floatID)
    floats = {'f7939', 'f7940', 'f7941', 'f7942', 'f7943', 'f7944', 'f7945', 'f8081', 'f8082', 'f8083'};
    indices = [20,70,70,66,64,60,58,36,36,32];
    files = get_float_files(floatID);
    index = indices(find(floats == floatID,1,'first'));
    cont_files = files{1:index};
end

function files = get_float_files(floatID)
    local_path = ['/Users/ChrisGordon/Desktop/ocean.dal.ca/gomri_data/isotherm.rsmas.miami.edu/data/floatData/',floatID,'/oxy'];
    files = glob([local_path,'/*.mat']);
end

function [M, N] = get_doxy_dims(files)
    M = numel(files);
    N = -1;
    for ii=1:M
        fn = files{ii};
        load(fn,'DOXY')
        n = numel(DOXY);

        if n > N
            N = n;
        end
end

function [S, T, P, DOXY, t, vert] = load_file_data(fn)
    load(fn,'DOXY','CtdObsIndex','UXT')

    t = UXT/60/60/24 + datenum('1970-01-01');

    fn_ctd = strrep(fn,'oxy','ctd');
    load(fn_ctd,'S','T','P')

    S = S(CtdObsIndex);
    T = T(CtdObsIndex);
    P = P(CtdObsIndex);

    strparts = split(fn,'-');
    hpid = strparts{3};

    if mod(str2double(hpid),2) == 0
        vert = 'upcast';
    else
        vert = 'downcast';
    end
end