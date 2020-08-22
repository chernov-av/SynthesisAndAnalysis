classdef IFileChooser
    %IFILECHOOSER Interface for file choosing
    
    methods (Abstract)
        [file,folder,status] = chooseFile(chooser,varargin);
    end
end

