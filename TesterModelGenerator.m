classdef TesterModelGenerator < matlab.unittest.TestCase
    %TESTERMODELGENERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Test)
        function test_ModelGeneratorConstructor(testCase)
            S.TFPlant = tf(1,[1 0]);
            S.Res = tf(1,[1 0]);
            
            modelGenerator = ModelGenerator([pwd '/Models'],S);
            testCase.verifyEqual(modelGenerator.TFPlant,...
                S.TFPlant);
            testCase.verifyEqual(modelGenerator.TFController,...
                S.Res);
        end
        
        function test_modelFileCreation(testCase)
            S.TFPlant = tf(1,[1 0]);
            S.Res = tf(1,[1 0]);
            
            modelGenerator = ModelGenerator([pwd '/Models'],S);
            fname = ['TEST_' char(datetime('now'))];
            fname = strrep(fname,' ','_');
            fname = strrep(fname,':','_');
            fname = strrep(fname,'-','_');
            modelGenerator.generate(fname,'Configuration_CCL',false);
            dirList = dir('Models');
            testCase.verifyEqual(dirList(end).name(1:end-4),fname);            
        end
        
        function test_blockExistanceConfCCL(testCase)
            S.TFPlant = tf(1,[1 0]);
            S.Res = tf(1,[1 0]);
            
            modelGenerator = ModelGenerator([pwd '/Models'],S);
            fname = ['TEST_' char(datetime('now')) '_be'];
            fname = strrep(fname,' ','_');
            fname = strrep(fname,':','_');
            fname = strrep(fname,'-','_');
            modelGenerator.generate(fname,'Configuration_CCL',false);
            
            if getSimulinkBlockHandle([fname '/Step'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/Ramp'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/RampIntegrator'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/SwitchKey'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/MPSwitch'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/Discriminator'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/TFController'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/TFPlant'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/OutputScope'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            close_system(fname,0);
        end
        
        function test_blockExistanceConfSF(testCase)
            S.TFPlant = tf(1,[1 0]);
            S.Res = tf(1,[1 0]);
            
            modelGenerator = ModelGenerator([pwd '/Models'],S);
            fname = ['TEST_' char(datetime('now')) '_be'];
            fname = strrep(fname,' ','_');
            fname = strrep(fname,':','_');
            fname = strrep(fname,'-','_');
            modelGenerator.generate(fname,'Configuration_SF',false);
            
            if getSimulinkBlockHandle([fname '/Step'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/Ramp'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/RampIntegrator'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/SwitchKey'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/MPSwitch'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/Discriminator'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/TFOpenLoop'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            if getSimulinkBlockHandle([fname '/OutputScope'])~=1
                isExist = true;
            else
                isExist = false;
            end
            testCase.verifyEqual(isExist,true);
            
            close_system(fname,0);
        end
    end
end

