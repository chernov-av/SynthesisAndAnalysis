classdef TesterSynthesisTEST < matlab.unittest.TestCase
    %TESTSYNTHESISTESTCLASS Summary of this class goes here
    %   Detailed explanation goes here
       
    methods (Test)
        function test_nameProperty(testCase)
            testCase.verifyEqual(SynthesisTEST.Name,...
                ["sTEST" "SynthesisTEST"]);
        end
        
        function test_methodsProperty(testCase)
            testCase.verifyEqual(SynthesisTEST.Methods,...
                ["sTestMethod1" "stestMethod1";...
                "sTestMethod2" "stestMethod2";]);
        end
        
        function test_method1(testCase) 
            sTEST = SynthesisTEST();
            Res = sTEST.stestMethod1;
            testCase.verifyEqual(sTEST.stestMethod1.num,...
                'testMethod1.num');
            testCase.verifyEqual(sTEST.stestMethod1.den,...
                'testMethod1.den');
        end
        
        function test_method2(testCase)            
            sTEST = SynthesisTEST();
            Res = sTEST.stestMethod2;
            testCase.verifyEqual(sTEST.stestMethod2.num,...
                'testMethod2.num');
            testCase.verifyEqual(sTEST.stestMethod2.den,...
                'testMethod2.den');
        end
    end
end

