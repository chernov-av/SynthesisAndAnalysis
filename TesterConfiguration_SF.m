classdef TesterConfiguration_SF < matlab.unittest.TestCase
    %TESTERCONFIGURATION_SF Summary of this class goes here
    %   Detailed explanation goes here
   
    methods (Test)
        function test_blockExistanceConfSF(testCase)
            S.TFPlant = tf(1,[1 0]);
            S.Res = tf(1,[1 0]);
            
            ModelName = 'Test';
            new_system(ModelName);
            Configuration_SF.generate(ModelName,S.TFPlant,S.Res);
            
            if getSimulinkBlockHandle([ModelName '/Step'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([ModelName '/Ramp'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([ModelName '/RampIntegrator'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([ModelName '/SwitchKey'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([ModelName '/MPSwitch'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([ModelName '/Discriminator'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([ModelName '/TFOpenLoop'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([ModelName '/OutputScope'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            close_system(ModelName,0);
        end
    end
end

