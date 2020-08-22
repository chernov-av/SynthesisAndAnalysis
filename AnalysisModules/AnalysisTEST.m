classdef AnalysisTEST < IAnalysis
    %ANALYSISTEST Test class
    %   Detailed explanation goes here
    
    properties (Constant)
        Name = ["aTEST" "AnalysisTEST"];
        Methods = ["aTestMethod1" "atestMethod1";...
            "aTestMethod2" "atestMethod2";];
        GUILayOut = true;
    end
    
    methods
         function obj = AnalysisTEST(args)
            %SYNTHESIS2 Construct an instance of this class
            %   Detailed explanation goes here            
        end
        
        function outputArg = atestMethod1(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg.num = 'analysisTestMethod1Result';
            outputArg.den = 'analysisTestMethod1Result';
        end
        
        function outputArg = atestMethod2(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg.num = 'analysisTestMethod2Result';
            outputArg.den = 'analysisTestMethod2Result';
        end
    end
end

