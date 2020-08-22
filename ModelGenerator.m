classdef ModelGenerator
    %MODELGENERATOR Class to generate Simulink models
    %   Value class
    %   Generates Simulink models depends on configuration of the
    %   model, choosed by user, ex. from GUI
    
    properties
        TFPlant
        TFController
        Path        
    end
    
    methods
        function obj = ModelGenerator(Path, InputData)
            %MODELGENERATOR Construct an instance of this class
            %   Path - path folder to save the generated Simulink model
            %   TFPlant - plant transfer function
            %   TFController - controller transfer function
            obj.Path = Path;
            obj.TFPlant = InputData.TFPlant;
            obj.TFController = InputData.Res;
        end
        
        function generate(obj,ModelName,ConfigName,OpenFlag)
            %GENERATE function to generate Simulink models
            %   Creates Simulink model ModelName, builds blocks in account 
            %   to the configuration ConfigName, which is choosed by user, 
            %   saves generated Simulink model, if OpenFlad is true, opens
            %   generated model in Simulink
            new_system(ModelName);            
            
            obj.buildModel(ModelName,ConfigName);
            set_param(ModelName,'StopTime','30');
            set_param(ModelName,'MaxStep','0.01');
            save_system([obj.Path '\' ModelName]);
            close_system(ModelName);
            
            if OpenFlag
                open_system(ModelName);
            end
        end
        
        function buildModel(obj,ModelName,ConfigName)
            %BUILDMODEL function to call configuration to build Simulink
            %model
            %   In account to configuration name ConfigName calls the
            %   generate function of configuration and send transfer
            %   functions of plant and controller
            eval([char(ConfigName),...
                '.generate(ModelName,obj.TFPlant,obj.TFController);']);
        end
    end
end

