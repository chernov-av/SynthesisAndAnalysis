classdef SynthesisPID < IModules
    %SYNTHESISPID Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        Name = ["PID" "SynthesisPID"];
        Methods = ["PID" "synthesisPID";...
                   "PI" "synthesisPI";...
                   "PD" "synthesisPD";...
                   "P" "synthesisP";...
                   "I" "synthesisI";];
        GUILayOut = false;
        InputArgs = ["CF" "CrossoverFreq";...
                ];
    end
    
    properties
        TFplant
        CrossoverFreq = 0        
    end
    
    methods
        function obj = SynthesisPID(InputArgs)
            %SYNTHESISPID Construct an instance of this class
            %   Detailed explanation goes here
            obj.TFplant = InputArgs.TFplant;
            obj.CrossoverFreq = InputArgs.CrossoverFreq;            
        end
    end
    
    methods (Static)
       function TFsystem = getSysTF(TFplant,TFcontroller)
            %getSysTF get closed looped system transfer function
            %   TFplant - transfer function of the plant
            %   TFreg - transfer function of the controller
            TFsystem = feedback(TFplant*TFcontroller,1);
        end 
    end
    
    methods 
        function [TFcontroller,TFsystem] = synthesisPID(obj)
            %synthesisPID synthesis of PID controller
            %   TFplant - transfer function of the plant
            if obj.CrossoverFreq > 0
            TFcontroller = tf(pidtune(obj.TFplant,'PID',...
                obj.CrossoverFreq));
            else
                TFcontroller = tf(pidtune(obj.TFplant,'PID'));
            end
            TFsystem = SynthesisPID.getSysTF(obj.TFplant,TFcontroller);
        end
        
        function [TFcontroller,TFsystem] = synthesisPI(obj)
            %synthesisPI synthesis of PI controller
            %   TFplant - transfer function of the plant
            if obj.CrossoverFreq > 0
                TFcontroller = tf(pidtune(obj.TFplant,'PI',...
                obj.CrossoverFreq));
            else
                TFcontroller = tf(pidtune(obj.TFplant,'PI'));
            end
            TFsystem = SynthesisPID.getSysTF(obj.TFplant,TFcontroller);
        end
        
        function [TFcontroller,TFsystem] = synthesisPD(obj)
            %synthesisPD synthesis of PD controller
            %   TFplant - transfer function of the plant
            if obj.CrossoverFreq > 0
                TFcontroller = tf(pidtune(obj.TFplant,'PD',...
                obj.CrossoverFreq));
            else
                TFcontroller = tf(pidtune(obj.TFplant,'PD'));
            end
            TFsystem = SynthesisPID.getSysTF(obj.TFplant,TFcontroller);
        end
        
        function [TFcontroller,TFsystem] = synthesisP(obj)
            %synthesisP synthesis of P controller
            %   TFplant - transfer function of the plant
            if obj.CrossoverFreq > 0
                TFcontroller = tf(pidtune(obj.TFplant,'P',...
                obj.CrossoverFreq));
            else
                TFcontroller = tf(pidtune(obj.TFplant,'P'));
            end
            TFsystem = SynthesisPID.getSysTF(obj.TFplant,TFcontroller);
        end
        
        function [TFcontroller,TFsystem] = synthesisI(obj)
            %synthesisI synthesis of I controller
            %   TFplant - transfer function of the plant
            if obj.CrossoverFreq > 0
                TFcontroller = tf(pidtune(obj.TFplant,'I',...
                obj.CrossoverFreq));
            else
                TFcontroller = tf(pidtune(obj.TFplant,'I'));
            end
            TFsystem = SynthesisPID.getSysTF(obj.TFplant,TFcontroller);
        end
    end
end

