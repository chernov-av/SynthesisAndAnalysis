classdef TesterLogger < matlab.unittest.TestCase
    %TESTERLOGGER Summary of this class goes here
    %   Detailed explanation goes here
   methods (Static)
       function app = launchTestApp()
          f = uifigure;
          textArea = uitextarea(f);
          textArea.Position(1) = 50;
          textArea.Position(2) = 50;
          textArea.Position(3) = 450;
          textArea.Position(4) = 300;
          app.UIFigure = f;
          app.TextArea = textArea;
       end
   end
    
    methods (Test)
        function test_loggerConstructor(testCase)
            app = TesterLogger.launchTestApp();
            testCase.addTeardown(@delete,app.UIFigure);
            guiLogger = GUILogger(app.TextArea);
            testCase.verifyClass(guiLogger,...
                'GUILogger')
        end
        
        function testLog(testCase)
            app = TesterLogger.launchTestApp();
            testCase.addTeardown(@delete,app.UIFigure);
            guiLogger = GUILogger(app.TextArea);
            guiLogger.Log('TestMessage');
            testCase.verifyEqual(app.TextArea.Value,...
                [{'TestMessage'};...                
                {char(string(datetime))};...
                {'--------------------------'};...                
                {''}]);
        end
        
        function testLogMultipleMessages(testCase)
            app = TesterLogger.launchTestApp();
            testCase.addTeardown(@delete,app.UIFigure);
            guiLogger = GUILogger(app.TextArea);
            guiLogger.Log('FirstTestMessage');
            guiLogger.Log('SecondTestMessage');
            testCase.verifyEqual(app.TextArea.Value,...
                [{'SecondTestMessage'};...
                {char(string(datetime))};...
                {'--------------------------'};...
                {'FirstTestMessage'};...
                {char(string(datetime))};...
                {'--------------------------'};...
                {''}]);
        end
        
        function testFileLogger(testCase)
           fileName = 'log.txt';
           flogger = FileLogger(fileName);
           message = 'TEST MESSAGE';
           flogger.Log('TEST MESSAGE');
           fid = fopen(fileName);
           line = fgetl(fid);
           text(1) = string(line);
           i = 2;
           while ischar(line)
              line = fgetl(fid); 
              text(i) = string(line);
              i = i + 1;
           end           
           testCase.verifyEqual(char(text(end-1)),message)
        end
    end
end

