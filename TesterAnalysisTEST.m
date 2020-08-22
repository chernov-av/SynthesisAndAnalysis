classdef TesterAnalysisTEST < matlab.unittest.TestCase
    %TESTERANALYSISTEST Summary of this class goes here
    %   Detailed explanation goes here
        
    methods (Test)
        function test_nameProperty(testCase)
            testCase.verifyEqual(AnalysisTEST.Name,["aTEST" "AnalysisTEST"]);
        end
        
        function test_methodsProperty(testCase)
            testCase.verifyEqual(AnalysisTEST.Methods,...
                ["aTestMethod1" "atestMethod1";"aTestMethod2" "atestMethod2";]);
        end
        
        function test_method1(testCase) 
            sTEST = AnalysisTEST();
            Res = sTEST.atestMethod1;
            testCase.verifyEqual(sTEST.atestMethod1.num,...
                'analysisTestMethod1Result');
            testCase.verifyEqual(sTEST.atestMethod1.den,...
                'analysisTestMethod1Result');
        end
        
        function test_method2(testCase)            
            sTEST = AnalysisTEST();
            Res = sTEST.atestMethod2;
            testCase.verifyEqual(sTEST.atestMethod2.num,...
                'analysisTestMethod2Result');
            testCase.verifyEqual(sTEST.atestMethod2.den,...
                'analysisTestMethod2Result');
        end
    end
end

