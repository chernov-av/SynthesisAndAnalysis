classdef FileLogger < ILogger
    %FILELOGGER Class for system app log to file
    %   Realization of ILogger for logging in file
    
    properties
        FileName
        delimiter = '--------------------------';
    end
    
    methods
        function obj = FileLogger(FileName)
            %FILELOGGER Construct an instance of FileLogger
            %   FileName = name of file to write app log
            obj.FileName = FileName;
        end
        
        function Log(obj,message)
            %Log function to log
            %   Detailed explanation goes here
            try
                fid = fopen(obj.FileName,'a');
                if fid == -1
                    ME = MException('Unable to load file')
                    throw(ME);
                end
                fprintf(fid,[obj.delimiter '\n']);
                fprintf(fid,[string(datetime)+'\n']);
                fprintf(fid,[message '\n']);
                
                fclose('all');
            catch ME
                msgbox(ME.message);
            end
        end
    end
end

