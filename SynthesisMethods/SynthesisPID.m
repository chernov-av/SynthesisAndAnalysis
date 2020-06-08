classdef SynthesisPID
    %METHODPID Summary of this class goes here
    %   class for pid tuning
    %   WARNING: properties are required to connect class
    %   NAME ["text name for dropdown" "class name"]
    %   Methods ["text name for dropdown" "names of methods need to call"]
    
    properties (Constant)
        Name = ["PID" "SynthesisPID"]
        Methods = ["PID" "SyntPID";...
            "PI" "SyntPI";...
            "P" "SyntP";...
            "I" "SyntI"]
    end
    
    properties
        Property1        
    end
    
    methods (Static)
        function obj = SynthesisPID(inputArg1,inputArg2)
            %METHODPID Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end
        
        function [Wsys,Wreg] = SyntPID(Wobj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            Wreg = pidtune(Wobj,'PID');
            Wsys = SynthesisPID.getSysTF(Wobj,Wreg);
        end
        
        function [Wsys,Wreg] = SyntPI(Wobj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            Wreg = pidtune(Wobj,'PI');
            Wsys = SynthesisPID.getSysTF(Wobj,Wreg);
        end
        
        function [Wsys,Wreg] = SyntP(Wobj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            Wreg = pidtune(Wobj,'P');
            Wsys = SynthesisPID.getSysTF(Wobj,Wreg);
        end
        
        function [Wsys,Wreg] = SyntI(Wobj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            Wreg = pidtune(Wobj,'I');
            Wsys = SynthesisPID.getSysTF(Wobj,Wreg);
        end
        
        function Wsys = getSysTF(Wobj,Wreg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            Wsys = feedback(Wreg*Wobj,1);
        end 
    end
    
    methods
       
    end
end

