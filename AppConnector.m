classdef AppConnector
    %APPCONNECTOR Folder scanner and module connector
    %   Contains functions to:
    %   - scan folders;
    %   - find module classes for connection to app
    %   - read module class properties
    %   - create list of function to call from app
    %   - determine possibility for GUI layout
    
    properties (Access = public)
        SearchFolder
    end
    
    methods
        function obj = AppConnector(searchFolder)
            %APPCONNECTOR Construct an instance of this class
            %   SearchFolder - folder with classes to connect
            obj.SearchFolder = searchFolder;
        end
    end
    
    methods
        
        function fileList = scanFolder(obj)
            %scanFolder returns list of files in the @SearchFolder
            %
            fileList = dir(obj.SearchFolder);
        end
        
        function ClassesForConnection = detectConnectedClasses(obj)
            %detectConnectedClasses search classes in @SearchFolder
            %   get list of classes in @SearchFolder for connection to main
            %   application
            fileList = obj.scanFolder();
            fileList = fileList(3:end);
            LengthFileList = length(fileList);
            ClassesForConnection = strings(LengthFileList,1);
            for i = 1:LengthFileList
                ClassesForConnection(i) = fileList(i).name(1:end-2);
            end
        end
        
        function ItemsForGUI = getClassItemsForGUI(obj,List)
            %getClassItemsForGUI get names of classes to visualize on GUI
            %   List - list of classes, which contain functions need to be
            %   called
            ItemsForGUI = [];
            for i = 1 : length(List)
                %read name property of the class
                PropertyList = properties(List(i));
                if length(PropertyList) > 1
                    item = [];
                    eval(['item = ',char(List(i)),'.',...
                        PropertyList{1},';']);
                    ItemsForGUI = [ItemsForGUI;item];
                end
            end
        end
        
        function FuncList = getFunctionsToCall(obj,ClassName)
            %getFunctionsToCalletermines list of functions which will be
            %called from app
            %   ClassName - list of classes, which contain functions need 
            %   to be called
            FuncList = [];
            PropertyList = properties(ClassName);
            if length(PropertyList) > 1
                eval(['FuncList = ',convertStringsToChars(ClassName),'.',...
                    PropertyList{2},';']);
            end            
        end
        
        function GUILayOut = getGUILayOut(obj,ClassName)
            %getGUILayOut read the GUILayOut property in connected modules
            %to determine the possibility of GUILayOut
            %   ClassName - list of classes, 
           PropertyList = properties(ClassName);
           if length(PropertyList) > 1
                eval(['GUILayOut = ',convertStringsToChars(ClassName),'.',...
                    PropertyList{3},';']);
            end
        end
        
        function inputList = get_inputList(obj,ClassName)
           PropertyList = properties(ClassName);
           if length(PropertyList) > 1
                eval(['inputList = ',convertStringsToChars(ClassName),'.',...
                    PropertyList{4},';']);
            end
        end
    end
end

