classdef AppConnector
    %APPCONNECTOR Summary of this class goes here
    %   Detect and connect classes and methods
    
    properties
        
    end
    
    methods (Static)
        function obj = AppConnector()
            %APPCONNECTOR Construct an instance of this class
            %   Detailed explanation goes here
        end
        
        function DetectSynthesisClasses(appObj)
            %detectSynthesisClasses
            %   detects and connects synthesis classes
            
            %get classlist from folder
            classList = dir('SynthesisMethods');
            
            for i = 1:length(classList)
                %read name properties
                eval(['propList = properties(''',...
                    classList(i).name(1:end-2),''');'])
                
                %if class has name properties read properties
                if length(propList) > 1
                    eval(['item = ',classList(i).name(1:end-2),'.',...
                        propList{1},';'])
                    
                    %%
                    %TODO: in service app class
                    %set app data structure with names for dropdown and
                    %class names for callback
                    appObj.p_LoadedClasses = [appObj.p_LoadedClasses; item];
                    
                    %set dropdown
                    appObj.DropDown_SynthesisMethods.Items = ...
                        [appObj.DropDown_SynthesisMethods.Items, item(1)];
                end
            end
        end
        
        function DetectInternalMethods(appObj,classname)
            %detectSynthesisClasses
            %   detects and connects methods and functions in classes
            %   depends on class name
            
            %clear dropdown and data structure
            appObj.DropDown_SynthesisOption.Items = {};
            appObj.p_LoadedMethods = [];
            
            %get list of properties
            propList = properties(classname);
            
            %if class has name properties read properties
            if length(propList)>1
                eval(['item = ',convertStringsToChars(classname),'.',...
                    propList{2},';'])
                 %%
                    %TODO: in service app class
                    %set app data structure with names for dropdown and
                    %method names for callback
                appObj.p_LoadedMethods = [appObj.p_LoadedMethods; item];
                
                %set dropdown
                for i = 1:length(item)
                    appObj.DropDown_SynthesisOption.Items = ...
                        [appObj.DropDown_SynthesisOption.Items, item(i,1)];
                end
            end
        end
    end
end

