addpath(genpath('../'))

floats = {'f7939', 'f7940', 'f7941', 'f7942', 'f7943', 'f7944', 'f7945', 'f8081', 'f8082', 'f8083'};

fprintf('-------------------------- RESULTS ---------------------------\n\n')
% fprintf('------------------------- NO FILTER -------------------------\n\n')
% fprintf('flID\tN\tN_pt\tm_p\tsd_p\tN_rhot\tm_rho\tsd_rho\n')
% fprintf('--------------------------------------------------------------\n')
% 
% for ii=1:numel(floats)
% 
%     floatID = floats{ii};
%     [S, T, P, DOXY, t] = load_float_data(floatID);
%     DOXY = real(DOXY);
%     PDEN = real(sw_pden(S, T, P, 0) - 1000);
% 
%     pres_tau = calculate_tau(t, P, DOXY, 'tlim', [40,100], 'tres', 0.5);
% 
%     fprintf('%s\t', floatID)
%     fprintf('%d\t', size(T, 1))
%     fprintf('%d\t', numel(pres_tau))
%     fprintf('%3.1f\t%3.3f\t', median(pres_tau), std(pres_tau))
% 
%     pden_tau = calculate_tau(t, PDEN, DOXY, 'tlim', [40,100], 'tres', 0.5, 'zlim', [22,26.5], 'zres', 0.1);
% 
%     fprintf('%d\t', numel(pden_tau))
%     fprintf('%3.1f\t%3.3f\n', median(pden_tau), std(pden_tau))
% 
% end
% 
% fprintf('------------------------ RUNNING MEAN ------------------------\n\n')
% fprintf('flID\tN\tN_pt\tm_p\tsd_p\tN_rhot\tm_rho\tsd_rho\n')
% fprintf('--------------------------------------------------------------\n')
% 
% for ii=1:numel(floats)
% 
%     floatID = floats{ii};
%     [S, T, P, DOXY, t] = load_float_data(floatID);
%     DOXY = real(DOXY);
%     PDEN = real(sw_pden(S, T, P, 0) - 1000);
% 
%     f_DOXY = movmean(DOXY, 7, 2);
% 
%     pres_tau = calculate_tau(t, P, f_DOXY, 'tlim', [40,100], 'tres', 0.5);
% 
%     fprintf('%s\t', floatID)
%     fprintf('%d\t', size(T, 1))
%     fprintf('%d\t', numel(pres_tau))
%     fprintf('%3.1f\t%3.3f\t', median(pres_tau), std(pres_tau))
% 
%     pden_tau = calculate_tau(t, PDEN, f_DOXY, 'tlim', [40,100], 'tres', 0.5, 'zlim', [22,26.5], 'zres', 0.1);
% 
%     fprintf('%d\t', numel(pden_tau))
%     fprintf('%3.1f\t%3.3f\n', median(pden_tau), std(pden_tau))
% 
% end

% Wn = 0.9;
% for n=1:3
%     [b,a] = butter(n,Wn);

%     fprintf('------------------------- BUTTERWORTH %d -----------------------\n\n', n)
%     fprintf('flID\tN\tN_pt\tm_p\tsd_p\tN_rhot\tm_rho\tsd_rho\n')
%     fprintf('--------------------------------------------------------------\n')



%     for ii=1:numel(floats)

%         floatID = floats{ii};
%         [S, T, P, DOXY, t] = load_float_data(floatID);
%         DOXY = real(DOXY);
        

%         f_DOXY = filter(b,a,DOXY,[],2);

%         PDEN = real(sw_pden(S, T, P, 0) - 1000);

%         pres_tau = calculate_tau(t, P, f_DOXY, 'tlim', [40,100], 'tres', 0.5);

%         fprintf('%s\t', floatID)
%         fprintf('%d\t', size(T, 1))
%         fprintf('%d\t', numel(pres_tau))
%         fprintf('%3.1f\t%3.3f\t', median(pres_tau), std(pres_tau))

%         pden_tau = calculate_tau(t, PDEN, f_DOXY, 'tlim', [40,100], 'tres', 0.5, 'zlim', [22,26.5], 'zres', 0.1);

%         fprintf('%d\t', numel(pden_tau))
%         fprintf('%3.1f\t%3.3f\n', median(pden_tau), std(pden_tau))

%     end
% end

fprintf('----------- 1st Order Butterworth, T-dependent tau -----------\n\n')
% fprintf('flID\tN\tN_pt\tm_p\tsd_p\tN_rhot\tm_rho\tsd_rho\n')
fprintf('flID\tN\tN_rhot\tm_rho\tsd_rho\tlL_rho\tlL_sd\n')
fprintf('--------------------------------------------------------------\n')

n = 1; Wn = 0.7;
[b,a] = butter(n,Wn);

% in=dlmread('T_lL_tau_3830_4330.dat'); lL=in(1,2:end);T=in(2:end,1);tau100=in(2:end,2:end); clear in
% lL = 100:150;

% for ii=1:numel(floats)
%     floatID = floats{ii};
%     [S, T, P, DOXY, t] = load_float_data(floatID);
%     DOXY = real(DOXY);
    
%     FILT_DOXY = nan(size(DOXY));
%     for i=1:size(DOXY,1)
%         f_DOXY = filter(b,a,[DOXY(i,1)*ones(1,11), DOXY(i,:)],[],2); 
%         f_DOXY = f_DOXY(12:end);
%         FILT_DOXY(i,:) = f_DOXY;
%     end
    

%     PDEN = real(sw_pden(S, T, P, 0) - 1000);

% %     pres_tau = calculate_tau_wTemp(t, P, f_DOXY, T, 'tvec', lL);
% % 
%     fprintf('%s\t', floatID)
%     fprintf('%d\t', size(T, 1))
% %     fprintf('%d\t', numel(pres_tau))
% %     fprintf('%3.1f\t%3.3f\t', median(pres_tau), std(pres_tau))

%     [thickness, pden_tau] = calculate_tau_wTemp(t, PDEN, FILT_DOXY, T, 'tvec', lL, 'zlim', [22,26.5], 'zres', 0.1);

%     fprintf('%d\t', numel(pden_tau))
%     fprintf('%3.1f\t%3.3f\t', median(pden_tau), std(pden_tau))
%     fprintf('%3.1f\t%3.3f\n', median(thickness), std(thickness))
% end

floatID = 'f7939';
[S, T, P, DOXY, t] = load_float_data(floatID);
DOXY = real(DOXY);
PDEN = sw_pden(S,T,P,0) - 1000;

FILT_DOXY = nan(size(DOXY));
for i=1:size(DOXY,1)
    f_DOXY = filter(b,a,[DOXY(i,1)*ones(1,11), DOXY(i,:)],[],2); 
    f_DOXY = f_DOXY(12:end);
    FILT_DOXY(i,:) = f_DOXY;
end

FILT_DOXY = FILT_DOXY(9:10,:);
T = T(9:10,:); t = t(9:10,:); PDEN = PDEN(9:10,:);
lL_opt = 100:200;

[thickness, pden_tau, rmsd] = calculate_tau_wTemp(t, PDEN, FILT_DOXY, T, 'tvec', lL_opt, 'zlim', [22,26.5], 'zres', 0.1);

Tref=20; % 
in=dlmread('../T-dependent/T_lL_tau_3830_4330.dat'); lL=in(1,2:end);T=in(2:end,1);tau100=in(2:end,2:end); clear in
[lL,T]=meshgrid(lL,T);
tau_Tref=interp2(lL,T,tau100,lL_opt,Tref,'linear');

fid = fopen('rmsd_example.csv','w');
fprintf(fid,'thickness,tau_20deg,rmsd');
for ii=1:numel(rmsd)
    fprintf(fid,'\n');
    fprintf(fid,'%3.1f,%3.3f,%3.3f',lL_opt(ii),tau_Tref(ii),rmsd(ii));
end
fclose(fid);

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

function cont_files = get_continuous_float_files(floatID)
    floats = {'f7939', 'f7940', 'f7941', 'f7942', 'f7943', 'f7944', 'f7945', 'f8081', 'f8082', 'f8083'};
    indices = [20,70,70,66,64,60,58,36,36,32];
    files = get_float_files(floatID);
    index = indices(contains(floats,floatID));
    cont_files = files(1:index);
end

function files = get_float_files(floatID)
    local_path = ['/Users/ChrisGordon/Desktop/ocean.dal.ca/gomri_data/isotherm.rsmas.miami.edu/gomri/data/floatData/',floatID,'/oxy'];
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
