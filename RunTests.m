clc
clear all

addpath('SynthesisModules')
addpath('AnalysisModules')
addpath('ModelConfigurations')
import matlab.unittest.TestSuite
suiteFolder = TestSuite.fromFolder(pwd);
res = run(suiteFolder)
delete('/Models/*.slx');
delete('/Models/*.autosave');