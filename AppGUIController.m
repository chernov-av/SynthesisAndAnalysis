classdef AppGUIController
    %APPGUICONTROLLER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods (Static)
        function obj = AppGUIController()
            %APPGUICONTROLLER Construct an instance of this class
            %   Detailed explanation goes here            
        end
        
        function LoadInputFromFile(appObj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            appObj.p_LoadedData = load('InputData\ObjectData.mat');
        end
    end
end

