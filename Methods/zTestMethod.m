classdef zTestMethod
    %FIRSTMETHOD Summary of this class goes here
    %   Detailed explanation goes here
    properties (Constant)
        Name = ["Test" "zTestMethod"]
        Methods = ["method 1" "method1";...
            "method 2" "method2"]
    end
    properties
        Property1
        
    end
    
    methods       
        function obj = zTestMethod(inputArg1,inputArg2)
            %FIRSTMETHOD Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
        
        function outputArg = method2(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

