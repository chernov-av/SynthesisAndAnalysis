classdef TesterAppSA < matlab.uitest.TestCase & matlab.mock.TestCase
    %T Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Test)
        
        function test_inititalizationSynthesis(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            ModuleDropDownItems = app.DropDown_synthesis_module.Items;
            testCase.verifyEqual(ModuleDropDownItems,[{'PID'},{'sTEST'}]);
        end
        
        function test_inititalizationAnalysis(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            ModuleDropDownItems = app.DropDown_analysis_module.Items;
            testCase.verifyEqual(ModuleDropDownItems,[{'Plots'},{'aTEST'}]);
        end
        
        function test_dropDownFunctionsSynthesis(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.choose(app.DropDown_synthesis_module,'sTEST');
            testCase.verifyEqual(app.DropDown_synthesis_functions.Items,...
                [{'sTestMethod1'},{'sTestMethod2'}]);
        end
        
        function test_dropDownFunctionsAnalysis(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.choose(app.DropDown_analysis_module,'aTEST');
            testCase.verifyEqual(app.DropDown_analysis_functions.Items,...
                [{'aTestMethod1'},{'aTestMethod2'}]);
        end
        
        function test_buttonCount(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.press(app.Button_count);
            load('result.mat')
            testCase.verifyEqual(app.ResSynthesis,Res);
        end
        
        function test_loadInputData(testCase)
            import matlab.mock.actions.AssignOutputs
            fname = 'Input.mat';
            
            [mockChooser,behavior] = testCase.createMock(?IFileChooser);
            when(behavior.chooseFile('*.*'),AssignOutputs(fname,pwd,1));
            
            app = AppSA(mockChooser);
            load('Input.mat');
            testCase.addTeardown(@delete,app);
            testCase.press(app.Button_load_input);
            testCase.verifyEqual(app.InputData.TFplant,TFplant);
        end
        
        function test_displayInputData(testCase)
            import matlab.mock.actions.AssignOutputs
            fname = 'Input.mat';
            
            [mockChooser,behavior] = testCase.createMock(?IFileChooser);
            when(behavior.chooseFile('*.*'),AssignOutputs(fname,pwd,1));
            
            app = AppSA(mockChooser);
            load('Input.mat');
            testCase.addTeardown(@delete,app);
            testCase.press(app.Button_load_input);
            testCase.verifyEqual(tf(str2num(app.EditField_input_num.Value),...
                str2num(app.EditField_input_den.Value)),...
                TFplant);
        end
        
        function test_readInputData(testCase)
            app = AppSA;
            load('Input.mat');
            testCase.addTeardown(@delete,app);
            testCase.type(app.EditField_input_num,'1');
            testCase.type(app.EditField_input_den,'1 1');
            testCase.press(app.Button_count);
            testCase.verifyEqual(app.InputData.TFplant,TFplant);
        end
        
        function test_GUILayOutTEST(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.choose(app.DropDown_synthesis_module,'sTEST');
            testCase.verifyEqual(app.GUILayOut,true);
        end
        
        function test_GUILayOutPID(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.choose(app.DropDown_synthesis_module,'PID');
            testCase.verifyEqual(app.GUILayOut,false);
        end
        
        function test_outputToAPP(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.choose(app.DropDown_synthesis_module,'sTEST');
            testCase.press(app.Button_count);
            testCase.verifyEqual(app.EditField_output_num.Value,...
                'testMethod1.num')
            testCase.verifyEqual(app.EditField_output_den.Value,...
                'testMethod1.den')
        end
        
        function test_outputToFile(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.choose(app.DropDown_synthesis_module,'sTEST');
            testCase.press(app.Button_count);
            load('result.mat')
            testCase.verifyEqual(Res.num,app.EditField_output_num.Value);
            testCase.verifyEqual(Res.den,app.EditField_output_den.Value);
        end
        
        function test_buttonAnalyzeEmpty(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.press(app.Button_analyze);
            th = findall(app.MsBox,'Type','Text');
            testCase.verifyEqual(th(1).String{1},...
                'No results to analyze');
            close(app.MsBox)
        end
        
        function test_buttonAnalyze(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.press(app.Button_count);
            testCase.press(app.Button_analyze);
            close;
            testCase.verifyNotEmpty(app.ResAnalysis)
        end
        
        function test_logInitText(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.verifyEqual(app.TextArea_Log.Value(1:3:end),...
                [{'analysis modules connected' };...
                {'synthesis modules connected'};...
                {'connecting modules...'      };...
                {'file logger is initialized'  };...
                {'gui logger is initialized'  };...
                {''};
                ]);
        end
        
        function test_GUILayOutAnalysisTEST(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.choose(app.DropDown_analysis_module,'aTEST');
            testCase.verifyEqual(app.GUILayOut,true);
        end
        
        function test_GUILayOutPlot(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.choose(app.DropDown_synthesis_module,'PID');
            testCase.verifyEqual(app.GUILayOut,false);
        end
        
        function test_analysisTest1OutputToAPP(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.press(app.Button_count);
            testCase.choose(app.DropDown_analysis_module,'aTEST');
            testCase.choose(app.DropDown_analysis_functions,'aTestMethod1');
            testCase.press(app.Button_analyze);
            testCase.verifyEqual(app.EditField_output_num.Value,...
                'analysisTestMethod1Result')
            testCase.verifyEqual(app.EditField_output_den.Value,...
                'analysisTestMethod1Result')
        end
        
        function test_analysisTest2OutputToAPP(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.press(app.Button_count);
            testCase.choose(app.DropDown_analysis_module,'aTEST');
            testCase.choose(app.DropDown_analysis_functions,'aTestMethod2');
            testCase.press(app.Button_analyze);
            testCase.verifyEqual(app.EditField_output_num.Value,...
                'analysisTestMethod2Result')
            testCase.verifyEqual(app.EditField_output_den.Value,...
                'analysisTestMethod2Result')
        end
        
        function test_menuLogOnIsChecked(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.press(app.Menu_LogOn);
            testCase.verifyEqual(app.Menu_LogOn.Checked, ...
                matlab.lang.OnOffSwitchState.on);
            testCase.press(app.Menu_LogOn);
            testCase.verifyEqual(app.Menu_LogOn.Checked,...
                matlab.lang.OnOffSwitchState.off);
        end
        
        function test_menuLogOnSizes(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.press(app.Menu_LogOn);
            testCase.verifyEqual(app.SynthesisAndAnalysisUIFigure.Position,...
                [100,100,771,669]);
            testCase.press(app.Menu_LogOn);
            testCase.verifyEqual(app.SynthesisAndAnalysisUIFigure.Position,...
                [100,100,561,669]);
        end
        
        function test_menuLogOnIsVisible(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.press(app.Menu_LogOn);
            testCase.verifyEqual(app.Panel_log.Visible,...
                matlab.lang.OnOffSwitchState.on);
            testCase.press(app.Menu_LogOn);
            testCase.verifyEqual(app.Panel_log.Visible,...
                matlab.lang.OnOffSwitchState.off);
        end
        
        function test_logCountText(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.press(app.Button_count);
            testCase.verifyEqual(...
                app.TextArea_Log.Value(1:3:length(app.TextArea_Log.Value)),...
                [{'results are writed'         };...
                {'writing results...'         };...
                {'synthesing done'            };...
                {'function: PID'              };...
                {'module: PID'                };...
                {'synthesing...'              };...
                {'analysis modules connected' };...
                {'synthesis modules connected'};...
                {'connecting modules...'      };...
                {'file logger is initialized' };...
                {'gui logger is initialized'  };...
                {''};...
                ]);
        end
        
        function testcloseApp(testCase)
            app = AppSA;
            testCase.press(app.Menu_exit);
            testCase.verifyFalse(isvalid(app));
        end
        
        function test_inputEditFields(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            inputFieldList = app.Panel_inputFields.Children;
            nameList = ["CF","TS","test1","test2","test3","test4",...
                "test5"];
            for i = 2:2:length(inputFieldList)
                testCase.verifyEqual(inputFieldList(i).Text,char(nameList(i/2)))
            end
        end
        
        function test_inputEditFieldsWithSwitch(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.choose(app.DropDown_synthesis_module,'sTEST');
            inputFieldList = app.Panel_inputFields.Children;
            nameList = ["test1","test2","test3","test4",...
                "test5"];
            for i = 2:2:length(inputFieldList)
                testCase.verifyEqual(inputFieldList(i).Text,char(nameList(i/2)))
            end
            
            testCase.choose(app.DropDown_synthesis_module,'PID');
            nameList = ["CF","TS"];
            inputFieldList = app.Panel_inputFields.Children;
            for i = 2:2:length(inputFieldList)
                testCase.verifyEqual(inputFieldList(i).Text,char(nameList(i/2)))
            end
        end
        
        function test_buttonGenerate(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.press(app.Button_count);
            testCase.press(app.Button_generateModel);
            
            dirList = dir('Models');
            testCase.verifyEqual(dirList(end).name(1:end-4),app.fname);
        end
        
        function test_configurationLoading(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.verifyEqual(app.DropDown_genModelConfig.Items,...
                [{'Continuous closed-loop','System Function'}])
        end
        
        function test_removeFilesInModels(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.press(app.Menu_removeFiles);
            fileList = dir('Models');
            testCase.verifyEmpty(fileList(3:end));
        end
        
        function test_clearFileLog(testCase)
            app = AppSA;
            testCase.addTeardown(@delete,app);
            testCase.press(app.Menu_ClearLog);
            fileList = dir('log.txt');
            testCase.verifyEmpty(fileList(3:end));
        end
        
        function test_clearGUILog(testCase)
           app = AppSA;
           testCase.addTeardown(@delete,app);
           testCase.press(app.Menu_ClearLog);
           textLog = app.TextArea_Log.Value;
           testCase.verifyEqual(textLog,{''});
        end
        
    end
end

