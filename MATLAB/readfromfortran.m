function A = readfromfortran(name,Ny,Nx)
    InPath = evalin('base','InPath'); % extract InPath from workspace
    fID = fopen(strcat(InPath,name));
    A = fread(fID,[Ny Nx],'double');
end