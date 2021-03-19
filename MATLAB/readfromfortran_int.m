function A = readfromfortran_int(name,Ny,Nx)
    SavePath = evalin('base','SavePath'); % extract savepath from workspace
    fID = fopen(strcat(SavePath,name));
    A = fread(fID,[Ny Nx],'int');
end