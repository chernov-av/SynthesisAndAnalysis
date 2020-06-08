classdef AppConnector
    %APPCONNECTOR Summary of this class goes here
    %   Detect and connect methods
    
    properties
        
    end
    
    methods (Static)
        function obj = AppConnector()
            %APPCONNECTOR Construct an instance of this class
            %   Detailed explanation goes here
        end
        
        function detect(appObj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            classList = dir('Methods');
            for i = 1:length(classList)
                eval(['propList = properties(''',classList(i).name(1:end-2),''');'])
                if length(propList) == 2
                    eval(['item = ',classList(i).name(1:end-2),'.',propList{1},';'])
                    appObj.DropDown.Items = [appObj.DropDown.Items, item];
                end
            end
        end
    end
end

