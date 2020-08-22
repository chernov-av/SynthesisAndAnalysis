classdef IWriter
    %IWRITER interface for application writers
    %   write - static function to write data
    
    methods (Abstract,Static)
        write(varargin);
    end
end

