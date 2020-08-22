classdef GUILogger < ILogger
    %LOGGER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        LogArea
        delimiter = '--------------------------';
    end
    
    methods
        function obj = GUILogger(TextArea)
            %LOGGER Construct an instance of this class
            %   Detailed explanation goes here
            obj.LogArea = TextArea;
        end
        
        function Log(obj,message)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            existedText = obj.LogArea.Value;
            existedText = [obj.delimiter; existedText];
            existedText = [string(datetime); existedText];
            existedText = [message; existedText];
            
            obj.LogArea.Value = existedText;
        end
    end
end

