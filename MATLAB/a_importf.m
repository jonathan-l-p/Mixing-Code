clear;clc;
close all;

InPath = '/Users/jonathan/Documents/DataDump/out_Fortran/';

% import number of samples in x and y
Nx = readfromfortran_int('out_Nx.bin',1,1);
Ny = readfromfortran_int('out_Ny.bin',1,1);
 
% read .bin files
fStar = readfromfortran('out_fStar.bin',1,Nx);
hStar = readfromfortran('out_hStar.bin',Ny,Nx);
kappaStar = readfromfortran('out_kappaStar.bin',Ny,Nx);
mu = readfromfortran('out_mu.bin',Ny,Nx);
muStar = readfromfortran('out_muStar.bin',Ny,Nx);
rhoStar = readfromfortran('out_rhoStar.bin',Ny,Nx);
T = readfromfortran('out_T.bin',Ny,Nx);
uStar = readfromfortran('out_uStar.bin',Ny,Nx);
vStar = readfromfortran('out_vStar.bin',Ny,Nx);
XStar = readfromfortran('out_XStar.bin',Ny,Nx);
YStar = readfromfortran('out_YStar.bin',Ny,Nx);
Y1 = readfromfortran('out_Y1.bin',Ny,Nx);
Y2 = readfromfortran('out_Y2.bin',Ny,Nx);

AnkKappa = readfromfortran('out_Ank_kappa.bin',Ny,Nx);

ybar = readfromfortran('out_ybar.bin',Ny,Nx);
g_of_x = readfromfortran('out_g_of_x.bin',Ny,Nx);
eta = readfromfortran('out_eta.bin',Ny,Nx);
G_of_eta = readfromfortran('out_G_of_eta.bin',Ny,Nx);
E = readfromfortran('out_E.bin',Ny,Nx);
% Alpha = readfromfortran('out_Alpha.bin',Ny,Nx);
strain_ratio = readfromfortran('out_SR.bin',1,Nx);

VarSave = readfromfortran('out_VarSave.bin',25,1);
delta_x_star = VarSave(2);
delta_y_star = VarSave(3);
FSR_kappa = VarSave(4);
c = VarSave(5);
x0ind = VarSave(6);
FSR_U = VarSave(7);
FSR_h = VarSave(8);
Pr = VarSave(9);

% determine if f(x) is constant at infinity
ConstantKappaAtInf = all(fStar == fStar(1));

% determine if the results contain NaN of negative values
BADIMPORT = false;

if (sum(sum(isnan(Y1))) ~= 0)
    fprintf('Warning: Y1 contains NaN values.\n')
    BADIMPORT = true;
end
if (sum(sum(Y1<0)) ~= 0)
    fprintf('Warning: Y1 contains negative values.\n')
    BADIMPORT = true;
end

if (sum(sum(isnan(Y2))) ~= 0)
    fprintf('Warning: Y2 contains NaN values.\n')
    BADIMPORT = true;
end
if (sum(sum(Y2<0)) ~= 0)
    fprintf('Warning: Y2 contains negative values.\n')
    BADIMPORT = true;
end

% if (Rei < 1)||(Rei > 10)
%     fprintf(['Warning: The initial mixing layer thickness is too',...
%         ' large or too small.\n'])
%     BADIMPORT = true;
% end

% print results if not bad
if BADIMPORT == false
    fprintf('Successfully imported fluid data!\n')
    fprintf('\n')
    fprintf('Pr = %.1f\n', Pr)
    fprintf('SR = %.1f\n', strain_ratio(x0ind))
    fprintf('UR = %.1f\n', FSR_U)
    fprintf('f(x) constant = %i\n', ConstantKappaAtInf)
    fprintf('\n')
end
