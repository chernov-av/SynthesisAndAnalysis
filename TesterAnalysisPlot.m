classdef TesterAnalysisPlot < matlab.unittest.TestCase
    %TESTERANALYSISPLOT Summary of this class goes here
    %   Detailed explanation goes here
   
    methods (Test)
        function test_stepPlot(testCase)
            TF = tf(1,[1 0]);
            ap = AnalysisPlot(TF);
            sAP = ap.StepPlot();
            testCase.verifyEqual(class(sAP),'matlab.ui.Figure');
            close(sAP);
        end
        
        function test_bodePlot(testCase)
            TF = tf(1,[1 0]);
            ap = AnalysisPlot(TF);
            bAP = ap.BodePlot();
            testCase.verifyEqual(class(bAP),'matlab.ui.Figure');
            close(bAP);
        end
    end
end

