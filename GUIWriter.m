classdef GUIWriter < IWriter
    %GUIWRITER Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Static)
        function write(varargin)
            app = varargin{1};
            GUILayOut = varargin{1}.GUILayOut;
            Res = varargin{2};
            if GUILayOut
                app.EditField_output_num.Value = Res.num;
                app.EditField_output_den.Value = Res.den;
            else
                app.EditField_output_num.Value = [''];
                app.EditField_output_den.Value = [''];
            end
        end
    end
end

