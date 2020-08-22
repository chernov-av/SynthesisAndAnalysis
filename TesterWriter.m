classdef TesterWriter < matlab.unittest.TestCase & matlab.uitest.TestCase
    %TESTERWRITER Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Static)
        function app = launchTestApp()
           f = uifigure;
           EditField_output_num = uieditfield(f);
           EditField_output_num.Position(1)=50;
           EditField_output_num.Position(2)=300;
           EditField_output_num.Position(3)=300;
           EditField_output_den = uieditfield(f);
           EditField_output_den.Position(1)=50;
           EditField_output_den.Position(2)=200;
           EditField_output_den.Position(3)=300;
           button = uibutton(f,'Text','test');
           app.UIFigure = f;
           app.Button = button;
           app.EditField_output_num = EditField_output_num;
           app.EditField_output_den = EditField_output_den;
           app.GUILayOut = false;
        end
    end
 
    methods (Test)
        function test_GUIWriter(testCase)
            app = TesterWriter.launchTestApp();
             testCase.addTeardown(@delete,app.UIFigure);
            WR.num = 'test for output num';
            WR.den = 'test for output den';
            app.GUILayOut = true;
            GUIWriter.write(app,WR);
            testCase.verifyEqual(app.EditField_output_num.Value,WR.num);
            testCase.verifyEqual(app.EditField_output_den.Value,WR.den);
        end
        
        function test_FileWriter(testCase)
            WR.num = 'test for output num';
            WR.den = 'test for output den';
            FileWriter.write('result.mat',WR);
            resTest = load('result.mat');
            testCase.verifyEqual(resTest.Res.num,WR.num);
            testCase.verifyEqual(resTest.Res.den,WR.den);
        end
    end
end

