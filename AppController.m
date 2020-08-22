classdef AppController
    %APPCONTROLLER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        appObj
        appConnector
        ModuleType
    end
    
    methods
        function obj = AppController(appObj,ModuleType)
            %APPCONTROLLER Construct an instance of this class
            %   appObj - application object
            obj.appObj = appObj;
            obj.initializePath();
            obj.appConnector = AppConnector([obj.appObj.Path...
                '/' ModuleType]);
            obj.ModuleType = ModuleType;
        end
        
        function initializePath(obj)
            obj.appObj.Path = pwd;
            addpath([obj.appObj.Path '/SynthesisModules']);
            addpath([obj.appObj.Path '/AnalysisModules']);
            addpath([obj.appObj.Path '/ModelConfigurations']);
        end
        
        function initialize(obj,DropDown)
            %initialize gets class (module) list and displays it on GUI in
            %app dropdown
            %   Creates appConnector instance and call function to scan
            %   @SearchFolder and create module list for connection, then
            %   read properties to get module name and configures
            %   the GUI module dropdown
            ClassesForConnection = obj.appConnector.detectConnectedClasses();
            ClassItems = obj.appConnector.getClassItemsForGUI(...
                ClassesForConnection);
            obj.setModuleDropDown(ClassItems,DropDown);
        end
        
        function setModuleDropDown(obj,ClassList,DropDown)
            %setModuleDropDown configures application module dropdown with
            %ClassList names
            %   ClassList - list of class (module) names to display on GUI;
            %   DropDown - synthesis/analysis dropdown
            obj.appObj.LoadedClasses = [obj.appObj.LoadedClasses; ClassList];
            for i = 1 : length(ClassList)
                DropDown.Items = ...
                    [DropDown.Items, ClassList(i)];
            end
        end
        
        function setFunctionDropDown(obj,ClassName,DropDown)
            %setModuleFunctionDropDown configures application function
            %dropdown with names of functions from ClassName
            %   ClassList - list of class (module) names to display on GUI;
            DropDown.Items = {};
            switch obj.ModuleType
                case 'SynthesisModules'
                    obj.appObj.LoadedSynthesisFunctions = [];
                    FuncList = obj.appConnector.getFunctionsToCall(ClassName);
                    obj.appObj.LoadedSynthesisFunctions = ...
                        [obj.appObj.LoadedSynthesisFunctions; FuncList];
                case 'AnalysisModules'
                    obj.appObj.LoadedAnalysisFunctions = [];
                    FuncList = obj.appConnector.getFunctionsToCall(ClassName);
                    obj.appObj.LoadedAnalysisFunctions = ...
                        [obj.appObj.LoadedAnalysisFunctions; FuncList];
            end
            
            for i = 1 : length(FuncList)
                DropDown.Items = ...
                    [DropDown.Items, FuncList(i)];
            end
        end
        
        function setGUILayOut(obj,ClassName)
            %setGUILayOut set GUILayOut property of application
            %   ClassName - name of class; class should contain GUILayOut
            %property;
            obj.appObj.GUILayOut = obj.appConnector.getGUILayOut(ClassName);
        end
        
        function appObj = get_appObj(obj)
            %get_appObj returns application object
            appObj = obj.appObj;
        end
        
        function classObj = createObject(obj,ClassName,InputArgs)
            %createObject creates an instance of input class
            %   ClassName - name of class, which instance needs to be created;
            %   InputArgs - input arguments of @ClassName constructor
            classObj = [];
            eval(['classObj = ',char(ClassName),'(InputArgs);'])
        end
        
        function result = callFunction(obj,ClassObj,ClassFunction)
            %callFunction calls function of specified class
            %   ClassObj - class instance;
            %   ClassFunction - function name
            result = [];
            eval(['result = ClassObj.',char(ClassFunction),'();']);
        end
        
        function hideLog(obj)
            animTimer = timer('ExecutionMode','fixedRate','Period',0.001,...
                'TimerFcn',@obj.animLogOff);
            start(animTimer);
        end
        
        function showLog(obj)
            obj.appObj.Menu_LogOn.Checked = 'on';
            obj.appObj.Panel_log.Visible = 'on';
            obj.appObj.Panel_log.Position = obj.appObj.LogPosition;
            drawnow;
            animTimer = timer('ExecutionMode','fixedRate','Period',0.001,...
                'TimerFcn',@obj.animLogOn);
            start(animTimer);
        end
        
        function animLogOn(obj,varargin)
            obj.appObj.SynthesisAndAnalysisUIFigure.Position(3) = ...
                obj.appObj.SynthesisAndAnalysisUIFigure.Position(3) + 15;
            drawnow;
            if (obj.appObj.SynthesisAndAnalysisUIFigure.Position(3) >= 764)
                stop(varargin{1});
            end
        end
        
        function animLogOff(obj,varargin)
            obj.appObj.SynthesisAndAnalysisUIFigure.Position(3) = ...
                obj.appObj.SynthesisAndAnalysisUIFigure.Position(3) - 15;
            drawnow;
            if (obj.appObj.SynthesisAndAnalysisUIFigure.Position(3) <= 561)
                stop(varargin{1});
                obj.appObj.LogPosition = obj.appObj.Panel_log.Position;
                obj.appObj.Menu_LogOn.Checked = 'off';
                obj.appObj.Panel_log.Visible = 'off';
                obj.appObj.Panel_log.Position(3) = 0;
            end
        end
        
        function inputList = getInputFields(obj,ClassName)
            inputList = obj.appConnector.get_inputList(ClassName);
            inputListSize = size(inputList);
            if inputListSize(1) > 1
                inputList = flip(inputList);
            end
        end
        
        function createInputFields(obj,ClassName)
            obj.clear_panelChildren(obj.appObj.Panel_inputFields);
            inputList = obj.getInputFields(ClassName);
            inputListSize = size(inputList);
            for i = 1 : inputListSize(1)
                label(i) = uilabel(obj.appObj.Panel_inputFields,...
                    'Position',[10 i*30 100 20],...
                    'Text',inputList(i,1));
                edit(i) = uieditfield(obj.appObj.Panel_inputFields,...
                    'Position',[110 i*30 100 20],'Value','0');
            end
        end
        
        function clear_panelChildren(obj, PanelName)
            if ~isempty(PanelName.Children)
                delete(PanelName.Children);
            end
        end
        
        function readInputDataFromGUI(obj,ClassName)
            inputList = obj.getInputFields(ClassName);
            inputListSize = size(inputList);
            for i = 1 : inputListSize(1)
                eval(['obj.appObj.InputData.',char(inputList(i,2)),...
                    '=',double(obj.appObj.Panel_inputFields.Children(2*i-1).Value),...
                    ';'])
            end
        end
        
        function generateModel(obj,InputData,ConfigName,isOpen)
            modelGenerator = ModelGenerator([obj.appObj.Path '/Models'],...
                InputData);
            obj.appObj.fname = ['TEST_' char(datetime('now'))];
            obj.appObj.fname = strrep(obj.appObj.fname,' ','_');
            obj.appObj.fname = strrep(obj.appObj.fname,':','_');
            obj.appObj.fname = strrep(obj.appObj.fname,'-','_');
            modelGenerator.generate(obj.appObj.fname,ConfigName,isOpen);
        end
        
        function clearDirectory(obj,folder)
            delete([folder '/Models/*.slx']);
            delete([folder '/Models/*.autosave']);
        end
        
        function clearLogs(obj)
           obj.clearFileLog();
           if length(findprop(obj.appObj,'GUILogger')) == 1 &&...
                   strcmp(class(obj.appObj.GUILogger),'GUILogger') &&...
                   ~isempty(obj.appObj.GUILogger)
               obj.clearGUILog();               
           end
        end
        
        function clearFileLog(obj)
            if ~isempty(dir('log.txt'))
                delete('log.txt');
            end
        end
        
        function clearGUILog(obj)
           obj.appObj.TextArea_Log.Value=''; 
        end
    end
end

