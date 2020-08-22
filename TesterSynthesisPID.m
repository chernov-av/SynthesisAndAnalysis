classdef TesterSynthesisPID < matlab.unittest.TestCase
    %SYNTHESYSPIDTESTER Summary of this class goes here
    %   Detailed explanation goes here
    
     methods (Test)
         
        function test_SynthesisPIDConstructor(testCase)
            S.TFplant = tf(1,[1 0]);
            S.CrossoverFreq = 0;
            S.TS = 0;
            sPID = SynthesisPID(S);
            testCase.verifyEqual(sPID.TFplant,S.TFplant);
        end
        
        function test_getSysTF(testCase)  
            Wplant = tf(1,[1 0]);
            Wreg = tf(1,[1 0]);            
            testCase.verifyEqual(SynthesisPID.getSysTF(Wplant,Wreg),...
                feedback(Wplant*Wreg,1));
        end
        
        function test_synthesisPID(testCase)
            S.TFplant = tf(1,[1 0]);
            S.CrossoverFreq = 0;
            S.TS = 0;
            Wreg = tf(pidtune(S.TFplant,'PID'));
            sPID = SynthesisPID(S);
            [Wr,Ws] = sPID.synthesisPID();
            testCase.verifyEqual(Ws,feedback(S.TFplant*Wreg,1));
            testCase.verifyEqual(Wr,Wreg);
        end
        
        function test_synthesisPI(testCase)
            S.TFplant = tf(1,[1 0]);
            S.CrossoverFreq = 0;
            S.TS = 0;
            Wreg = tf(pidtune(S.TFplant,'PI'));
            sPID = SynthesisPID(S);
            [Wr,Ws] = sPID.synthesisPI();
            testCase.verifyEqual(Ws,feedback(S.TFplant*Wreg,1));
            testCase.verifyEqual(Wr,Wreg);
        end
        
        function test_synthesisPD(testCase)
            S.TFplant = tf(1,[1 0]);
            S.CrossoverFreq = 0;
            S.TS = 0;
            Wreg = tf(pidtune(S.TFplant,'PD'));
            sPID = SynthesisPID(S);
            [Wr,Ws] = sPID.synthesisPD();
            testCase.verifyEqual(Ws,feedback(S.TFplant*Wreg,1));
            testCase.verifyEqual(Wr,Wreg);
        end
        
        function test_synthesisP(testCase)
            S.TFplant = tf(1,[1 0]);
            S.CrossoverFreq = 0;
            S.TS = 0;
            Wreg = tf(pidtune(S.TFplant,'P'));
            sPID = SynthesisPID(S);
            [Wr,Ws] = sPID.synthesisP();
            testCase.verifyEqual(Ws,feedback(S.TFplant*Wreg,1));
            testCase.verifyEqual(Wr,Wreg);
        end
        
        function test_synthesisI(testCase)
            S.TFplant = tf(1,[1 0]);
            S.CrossoverFreq = 0;
            S.TS = 0;
            Wreg = tf(pidtune(S.TFplant,'I'));
            sPID = SynthesisPID(S);
            [Wr,Ws] = sPID.synthesisI();
            testCase.verifyEqual(Ws,feedback(S.TFplant*Wreg,1));
            testCase.verifyEqual(Wr,Wreg);
        end       
        
        function test_nameProperty(testCase)
            testCase.verifyEqual(SynthesisPID.Name,["PID" "SynthesisPID"]);
        end
        
        function test_methodsProperty(testCase)
            testCase.verifyEqual(SynthesisPID.Methods,["PID" "synthesisPID";...
            "PI" "synthesisPI";...
            "PD" "synthesisPD";...
            "P" "synthesisP";...
            "I" "synthesisI";]);
        end
    end
end

