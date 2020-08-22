classdef AnalysisPlot < IAnalysis
    %ANALYSISPLOT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        Name = ["Plots" "AnalysisPlot"];
        Methods = ["Step" "StepPlot";...
                   "Bode" "BodePlot";];
        GUILayOut = false;        
    end
    
    properties
       TF 
    end
    
    methods 
        function obj = AnalysisPlot(args)
            obj.TF = args;
        end        
    end
    
    methods
        function obj = StepPlot(obj)
            %ANALYSISPLOT Construct an instance of this class
            %   Detailed explanation goes here
            f = figure;
            step(obj.TF);
            grid on;
            obj = f;
        end 
        
        function obj = BodePlot(obj)
            %ANALYSISPLOT Construct an instance of this class
            %   Detailed explanation goes here
            f = figure;
            bode(obj.TF);
            grid on;
            obj = f;
        end 
    end
end

