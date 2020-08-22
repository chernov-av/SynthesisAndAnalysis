classdef SynthesisTEST < IModules
    %SYNTHESIS2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        Name = ["sTEST" "SynthesisTEST"];
        Methods = ["sTestMethod1" "stestMethod1";...
            "sTestMethod2" "stestMethod2";];
        GUILayOut = true;
        InputArgs = ["test1" "Test1";...
                "test2" "Test2";...
                "test3" "Test3";...
                "test4" "Test4";...
                "test5" "Test5";...
                ];
    end
    
    methods
        function obj = SynthesisTEST(args)
            %SYNTHESIS2 Construct an instance of this class
            %   Detailed explanation goes here            
        end
        
        function outputArg = stestMethod1(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg.num = 'testMethod1.num';
            outputArg.den = 'testMethod1.den';
        end
        
        function outputArg = stestMethod2(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg.num = 'testMethod2.num';
            outputArg.den = 'testMethod2.den';
        end
    end
end

