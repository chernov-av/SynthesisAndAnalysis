classdef TesterAppConnector < matlab.unittest.TestCase
    %APPSATESTER Summary of this class goes here
    %   Detailed explanation goes here
       
    methods (Test)
        %AppConnector tests
        function test_AppConnectorConstructor(testCase)  
            folderName = 'SynthesisModules';
            appConnector = AppConnector(folderName);
            testCase.verifyEqual(appConnector.SearchFolder,folderName);
        end
        
        function test_detectConncectedClasses(testCase)
            folderName = 'SynthesisModules';
            appConnector = AppConnector(folderName);
            ClassList = appConnector.detectConnectedClasses();  
            testCase.verifyEqual(["SynthesisPID";"SynthesisTEST"],ClassList);
        end
        
        function test_scanFolder(testCase)
            folderName = 'SynthesisModules';
            appConnector = AppConnector(folderName);
            DirList = appConnector.scanFolder();  
            testCase.verifyEqual(dir(folderName),DirList);
        end
        
        function test_itemsForGUI(testCase)
            folderName = 'SynthesisModules';
            appConnector = AppConnector(folderName);
            ClassList = appConnector.detectConnectedClasses();  
            testCase.verifyLength(appConnector.getClassItemsForGUI(ClassList),2)
        end
        
        function test_getFunctionsToCall(testCase)
            folderName = 'SynthesisModules';
            appConnector = AppConnector(folderName);
            FunctionList = appConnector.getFunctionsToCall('SynthesisTEST');
            testCase.verifyEqual(FunctionList,["sTestMethod1" "stestMethod1";...
            "sTestMethod2" "stestMethod2";]);
        end
        
        function test_getGUILayOutTEST(testCase)
            folderName = 'SynthesisModules';
            appConnector = AppConnector(folderName);
            GUILayOut = appConnector.getGUILayOut('SynthesisTEST');
            testCase.verifyEqual(GUILayOut,true);
        end
        
        function test_getGUILayOutPID(testCase)
            folderName = 'SynthesisModules';
            appConnector = AppConnector(folderName);
            GUILayOut = appConnector.getGUILayOut('SynthesisPID');
            testCase.verifyEqual(GUILayOut,false);
        end
        %Analysis
        function test_AppConnectorConstructorAnalysis(testCase)  
            folderName = 'AnalysisModules';
            appConnector = AppConnector(folderName);
            testCase.verifyEqual(appConnector.SearchFolder,folderName);
        end
        
        function test_detectConncectedClassesAnalysis(testCase)
            folderName = 'AnalysisModules';
            appConnector = AppConnector(folderName);
            ClassList = appConnector.detectConnectedClasses();  
            testCase.verifyEqual(["AnalysisPlot";"AnalysisTEST"],ClassList);
        end
        
        function test_scanFolderAnalysis(testCase)
            folderName = 'AnalysisModules';
            appConnector = AppConnector(folderName);
            DirList = appConnector.scanFolder();  
            testCase.verifyEqual(dir(folderName),DirList);
        end
        
        function test_itemsForGUIAnalysis(testCase)
            folderName = 'AnalysisModules';
            appConnector = AppConnector(folderName);
            ClassList = appConnector.detectConnectedClasses();  
            testCase.verifyLength(appConnector.getClassItemsForGUI(ClassList),2)
        end
        
        function test_getFunctionsToCallAnalysis(testCase)
            folderName = 'AnalysisModules';
            appConnector = AppConnector(folderName);
            FunctionList = appConnector.getFunctionsToCall('AnalysisTEST');
            testCase.verifyEqual(FunctionList,["aTestMethod1" "atestMethod1";...
            "aTestMethod2" "atestMethod2";]);
        end
        
        function test_getGUILayOutTESTAnalysis(testCase)
            folderName = 'AnalysisModules';
            appConnector = AppConnector(folderName);
            GUILayOut = appConnector.getGUILayOut('AnalysisTEST');
            testCase.verifyEqual(GUILayOut,true);
        end
        
        function test_getGUILayOutPIDAnalysis(testCase)
            folderName = 'AnalysisModules';
            appConnector = AppConnector(folderName);
            GUILayOut = appConnector.getGUILayOut('AnalysisPlot');
            testCase.verifyEqual(GUILayOut,false);
        end
    end
end

