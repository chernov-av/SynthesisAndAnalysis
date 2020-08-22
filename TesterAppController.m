classdef TesterAppController  < matlab.unittest.TestCase
    %TESTERAPPCONTROLLER Summary of this class goes here
    %   Detailed explanation goes here    
    
    properties
       Path = pwd
    end
    
    methods (Test)
       function test_AppControllerConstructorForSynthesis(testCase)            
            appController = AppController(TesterAppController,'SynthesisModules');
            testCase.verifyInstanceOf(appController.get_appObj,...
                'TesterAppController');
       end
        
       function test_AppControllerConstructorForAnalysis(testCase)            
            appController = AppController(TesterAppController,'AnalysisModules');
            testCase.verifyInstanceOf(appController.get_appObj,...
                'TesterAppController');
       end
        
       function test_clearFileLog(testCase)
            controller = AppController(TesterAppController,'');
            controller.clearFileLog();
            fileList = dir('log.txt');
            testCase.verifyEmpty(fileList);
       end
       
       function test_clearLogs(testCase)
            controller = AppController(TesterAppController,'');
            controller.clearLogs();
            fileList = dir('log.txt');
            testCase.verifyEmpty(fileList);
       end
    end
end

