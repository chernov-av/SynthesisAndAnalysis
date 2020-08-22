classdef FileWriter < IWriter
    %FILEWRITER Summary of this class goes here
    %   Detailed explanation goes here
methods (Static)
    function write(varargin)
       FileName = varargin{1};
       Res = varargin{2};
       save(FileName,'Res');
    end
end
end

