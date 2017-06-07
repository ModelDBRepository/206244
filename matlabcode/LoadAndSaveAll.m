% cd to directiory containing the data
listall=dir('simulationData_*');
for ci=1:size(listall,1)
    if isempty(strfind(listall(ci,1).name,'param'))
        clearvars -except listall ci
        filen=listall(ci,1).name;
        pathn=cd;
        LoadAndSave
        clearvars A B;
        save(regexprep(regexprep(filen,'Data','Res'),'.dat','.mat'))
    end
end
