classdef AppController
    %APPCONTROLLER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = AppController()
            %APPCONTROLLER Construct an instance of this class
            %   Detailed explanation goes here
        end
        
        function ConnectClasses(obj,appObj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            AppConnector.DetectSynthesisClasses(appObj);
        end
        
        function ConnectMethods(obj,appObj,classname)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            [r,k] = find(appObj.p_LoadedClasses == ...
                classname);
            AppConnector.DetectInternalMethods(appObj,appObj.p_LoadedClasses(r,2));
        end
        
        function CallMethod(obj,className,methodName,appObj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            [r_c,k_c] = find(appObj.p_LoadedClasses == ...
                className);
            [r_m,k_m] = find(appObj.p_LoadedMethods == ...
                methodName);
            eval(['[Wsys,Wreg] = ',...
                convertStringsToChars(appObj.p_LoadedClasses(r_c,2)),'.'...
                ,convertStringsToChars(appObj.p_LoadedMethods(r_m,2)),...
                '(appObj.p_LoadedData.Wobj);']);
            %TODO: in service app class
            figure
            step(Wsys)
        end
        
        function LoadFromFile(obj,appObj)
            AppGUIController.LoadInputFromFile(appObj);
        end
    end
end

