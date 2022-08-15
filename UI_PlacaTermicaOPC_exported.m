classdef UI_PlacaTermicaOPC_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        GridLayout              matlab.ui.container.GridLayout
        LeftPanel               matlab.ui.container.Panel
        MALHA1Label             matlab.ui.control.Label
        ControladorLabel        matlab.ui.control.Label
        ControladorFFLabel      matlab.ui.control.Label
        MODODropDownLabel       matlab.ui.control.Label
        MODODropDown            matlab.ui.control.DropDown
        MVEditFieldLabel        matlab.ui.control.Label
        MVEditField             matlab.ui.control.NumericEditField
        SPEditFieldLabel        matlab.ui.control.Label
        SPEditField             matlab.ui.control.NumericEditField
        PVEditFieldLabel        matlab.ui.control.Label
        PVEditField             matlab.ui.control.NumericEditField
        KpEditFieldLabel        matlab.ui.control.Label
        KpEditField             matlab.ui.control.NumericEditField
        TiEditFieldLabel        matlab.ui.control.Label
        TiEditField             matlab.ui.control.NumericEditField
        TdEditFieldLabel        matlab.ui.control.Label
        TdEditField             matlab.ui.control.NumericEditField
        KffEditFieldLabel       matlab.ui.control.Label
        KffEditField            matlab.ui.control.NumericEditField
        TnumffEditFieldLabel    matlab.ui.control.Label
        TnumffEditField         matlab.ui.control.NumericEditField
        TdenffEditFieldLabel    matlab.ui.control.Label
        TdenffEditField         matlab.ui.control.NumericEditField
        LffEditFieldLabel       matlab.ui.control.Label
        LffEditField            matlab.ui.control.NumericEditField
        AplicarButton           matlab.ui.control.Button
        SalvardadosButton       matlab.ui.control.Button
        CenterPanel             matlab.ui.container.Panel
        UIAxes                  matlab.ui.control.UIAxes
        UIAxes2                 matlab.ui.control.UIAxes
        RightPanel              matlab.ui.container.Panel
        MALHA2Label             matlab.ui.control.Label
        ControladorLabel_2      matlab.ui.control.Label
        ControladorFFLabel_2    matlab.ui.control.Label
        MODODropDown_2Label     matlab.ui.control.Label
        MODODropDown_2          matlab.ui.control.DropDown
        MVEditField_2Label      matlab.ui.control.Label
        MVEditField_2           matlab.ui.control.NumericEditField
        SPEditField_2Label      matlab.ui.control.Label
        SPEditField_2           matlab.ui.control.NumericEditField
        PVEditField_2Label      matlab.ui.control.Label
        PVEditField_2           matlab.ui.control.NumericEditField
        KpEditField_2Label      matlab.ui.control.Label
        KpEditField_2           matlab.ui.control.NumericEditField
        TiEditField_2Label      matlab.ui.control.Label
        TiEditField_2           matlab.ui.control.NumericEditField
        TdEditField_2Label      matlab.ui.control.Label
        TdEditField_2           matlab.ui.control.NumericEditField
        KffEditField_2Label     matlab.ui.control.Label
        KffEditField_2          matlab.ui.control.NumericEditField
        TnumffEditField_2Label  matlab.ui.control.Label
        TnumffEditField_2       matlab.ui.control.NumericEditField
        TdenffEditField_2Label  matlab.ui.control.Label
        TdenffEditField_2       matlab.ui.control.NumericEditField
        LffEditField_2Label     matlab.ui.control.Label
        LffEditField_2          matlab.ui.control.NumericEditField
        AplicarButton_2         matlab.ui.control.Button
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
        twoPanelWidth = 768;
    end

    
    properties (Access = private)
        
        
        %variaveis gerais 
        
        N = 100; % numero de pontos a serem mostrados no grafico 
        n = 1; %indicador do número de ciclos 
        
        Mytimer %variavel do timer 
        
        % Variaveis das placas
        % placa 1
        SP1 = 0 ;
        MV1;
        PV1;
        
        % placa 2
        SP2 = 0;
        MV2;
        PV2;
        
        % variaveis do controlador PID 
        % placa 1
        Kp1 = 0;
        Ti1 = 0.0001;
        Td1 = 0;
        
        % placa 2
        Kp2 = 0;
        Ti2 = 0.0001;
        Td2 = 0;
        
        % variaveis controlador FF
        % placa 1
        Kff1 = 0;
        Tnumff1 = 0;
        Tdemff1 = 0;
        Lff1 = 0;
        
        % placa 2
        Kff2 = 0;
        Tnumff2 = 0;
        Tdemff2 = 0;
        Lff2 = 0;
        
        % placa 
        
        PlacaTermica
        
        %Controladores das placas        
        
        ContPID_p1
        ContPID_p2
        

                               
    end
    
    methods (Access = private)
     
        
         
        function modoMANUAL(app)
            
            try 
                aux1 = app.PlacaTermica.readOutput();
            
            catch 
                aux1 = [0 0];
            end
            
        
            
          
            % Para a placa 1
            if(app.MODODropDown.Value == "MANUAL")  
                
                % Dados coletados da placa sendo colocado em suas variaveis
                % correspondentes
                app.PV1(app.n) = aux1(1); 
                
                app.PVEditField.Value = app.PV1(app.n);
                app.SP1 = app.PV1(app.n);
                app.SPEditField.Value = app.SP1;
                
                % Layout
                app.SPEditField.Editable = 'off';
                app.MVEditField.Editable = 'on';
                
                app.LffEditField.Visible = 'off';
                app.TdenffEditField.Visible = 'off';
                app.TnumffEditField.Visible = 'off';
                app.TdEditField.Visible = 'off';
                app.TiEditField.Visible = 'off';
                app.KpEditField.Visible = 'off';
                app.KffEditField.Visible = 'off';
                app.LffEditFieldLabel.Text = '';
                app.TdenffEditFieldLabel.Text = '';
                app.TnumffEditFieldLabel.Text = '';
                app.TdEditFieldLabel.Text = '';
                app.TiEditFieldLabel.Text = '';
                app.KpEditFieldLabel.Text = '';
                app.KffEditFieldLabel.Text = '';
                app.ControladorLabel.Text = '';
                app.ControladorFFLabel.Text = '';
                
                
            end
            %placa 2
            if(app.MODODropDown_2.Value == "MANUAL")
                
                % Dados coletados da placa sendo colocado em suas variaveis
                % correspondentes
                app.PV2(app.n) = aux1(2); 
                app.PVEditField_2.Value = app.PV2(app.n);
                app.SP2 = app.PV2(app.n);
                app.SPEditField_2.Value = app.SP2;
                
                
                
                app.SPEditField_2.Editable = 'off';
                app.MVEditField_2.Editable = 'on';
               
                
                app.LffEditField_2.Visible = 'off';
                app.KffEditField_2.Visible = 'off';
                app.TdenffEditField_2.Visible = 'off';
                app.TnumffEditField_2.Visible = 'off';
                app.KpEditField_2.Visible = 'off';
                app.TiEditField_2.Visible = 'off';
                app.TdEditField_2.Visible = 'off';
                app.LffEditField_2Label.Text = '';
                app.TdenffEditField_2Label.Text = '';
                app.TnumffEditField_2Label.Text = '';
                app.TdEditField_2Label.Text = '';
                app.TiEditField_2Label.Text = '';
                app.KpEditField_2Label.Text = '';
                app.KffEditField_2Label.Text = '';
                app.ControladorLabel_2.Text = '';
                app.ControladorFFLabel_2.Text = '';
                
                
                
            end
            
            
        end
        
        function modoAUTO(app)
            try 
                aux1 = app.PlacaTermica.readOutput();
            
            catch 
                aux1 = [0 0];
            end
            
       
            
            if(app.MODODropDown.Value == "AUTO")
                
                app.PV1(app.n) = aux1(1);
                app.PVEditField.Value = app.PV1(app.n);
              
                app.ContPID_p1.PV = app.PV1(app.n);
                
                app.ContPID_p1.calculateOutput();
                
                app.MV1(app.n) = app.ContPID_p1.MV;
                
              
                
                if(app.MV1(app.n)<0)
                    app.MV1(app.n) = 0;
                elseif(app.MV1(app.n)>100)
                    app.MV1(app.n) = 100;
                end
                
                try
                    app.PlacaTermica.writeInput(app.MV1(app.n), app.MV2(app.n));
                catch
                    disp("Placa não conectada");
                end
                
                app.MVEditField.Value = app.MV1(app.n);

                app.SPEditField.Editable = 'on';
                app.MVEditField.Editable = 'off';
                app.TdEditField.Editable = 'on';
                app.TiEditField.Editable = 'on';
                app.KpEditField.Editable = 'on';
                app.TdEditField.Visible = 'on';
                app.TiEditField.Visible = 'on';
                app.KpEditField.Visible = 'on';
                app.LffEditField.Visible = 'off';
                app.TdenffEditField.Visible = 'off';
                app.TnumffEditField.Visible = 'off';
                app.KffEditField.Visible = 'off';
                app.LffEditFieldLabel.Text = '';
                app.TdenffEditFieldLabel.Text = '';
                app.TnumffEditFieldLabel.Text = '';
                app.TdEditFieldLabel.Text = 'Td';
                app.TiEditFieldLabel.Text = 'Ti';
                app.KpEditFieldLabel.Text = 'Kp';
                app.KffEditFieldLabel.Text = '';
                app.ControladorLabel.Text = 'Controlador';
                app.ControladorFFLabel.Text = '';
              
                
            end
            
            if(app.MODODropDown_2.Value == "AUTO") 
                
                
                app.PV2(app.n) = aux1(2);
                app.PVEditField_2.Value = app.PV2(app.n);
              
                app.ContPID_p2.PV = app.PV2(app.n);
                
                app.ContPID_p2.calculateOutput();
                
                app.MV2(app.n) = app.ContPID_p2.MV;
                
                if(app.MV2(app.n)<0)
                    app.MV2(app.n) = 0;
                elseif(app.MV2(app.n)>100)
                    app.MV2(app.n) = 100;
                end
                
                try
                    app.PlacaTermica.writeInput(app.MV1(app.n), app.MV2(app.n));
                catch
                    disp("Placa não conectada");
                end
                
                app.MVEditField_2.Value = app.MV2(app.n);
                
                
                app.SPEditField_2.Editable = 'on';
                app.MVEditField_2.Editable = 'off';
                app.TdEditField_2.Editable = 'on';
                app.TiEditField_2.Editable = 'on';
                app.KpEditField_2.Editable = 'on';
                app.TdEditField_2.Visible = 'on';
                app.TiEditField_2.Visible = 'on';
                app.KpEditField_2.Visible = 'on';
                app.LffEditField_2.Visible = 'off';
                app.KffEditField_2.Visible = 'off';
                app.TdenffEditField_2.Visible = 'off';
                app.TnumffEditField_2.Visible = 'off';
                app.LffEditField_2Label.Text = '';
                app.TdenffEditField_2Label.Text = '';
                app.TnumffEditField_2Label.Text = '';
                app.TdEditField_2Label.Text = 'Td';
                app.TiEditField_2Label.Text = 'Ti';
                app.KpEditField_2Label.Text = 'Kp';
                app.KffEditField_2Label.Text = '';
                app.ControladorLabel_2.Text = 'Controlador';
                app.ControladorFFLabel_2.Text = '';
                
            end
            
        end
  
        
        function modoFF(app)
            try 
                aux1 = app.PlacaTermica.readOutput();
            
            catch 
                aux1 = [0 0];
            end
            
           app.PV1(app.n) = aux1(1);
           app.PV2(app.n) = aux1(2);
            
             if(app.MODODropDown.Value == "FF")
                 
                 
                 
                 app.PVEditField.Value = app.PV1(app.n);
                 app.SP1 = app.PV1(app.n);
                 app.SPEditField.Value = app.SP1;
                 
                 
                 
                 
                 app.LffEditField.Visible = 'on';
                 app.TdenffEditField.Visible = 'on';
                 app.TnumffEditField.Visible = 'on';
                 app.TdEditField.Visible = 'on';
                 app.TiEditField.Visible = 'on';
                 app.KpEditField.Visible = 'on';
                 app.KffEditField.Visible = 'on';
                 app.LffEditFieldLabel.Text = 'Lff';
                 app.TdenffEditFieldLabel.Text = 'Tdenff';
                 app.TnumffEditFieldLabel.Text = 'Tnumff';
                 app.TdEditFieldLabel.Text = 'Td';
                 app.TiEditFieldLabel.Text = 'Ti';
                 app.KpEditFieldLabel.Text = 'Kp';
                 app.KffEditFieldLabel.Text = 'Kff';
                 app.ControladorLabel.Text = 'Controlador';
                 app.ControladorFFLabel.Text = 'Controlador FF';
              
                
            end
            
            if(app.MODODropDown_2.Value == "FF")     
                
                
                
                app.PVEditField_2.Value = app.PV2(app.n);
                app.SP2 = app.PV2(app.n);
                app.SPEditField_2.Value = app.SP2;
                
                app.LffEditField_2.Visible = 'on';
                app.KffEditField_2.Visible = 'on';
                app.TdenffEditField_2.Visible = 'on';
                app.TnumffEditField_2.Visible = 'on';
                app.KpEditField_2.Visible = 'on';
                app.TiEditField_2.Visible = 'on';
                app.TdEditField_2.Visible = 'on';
                app.LffEditField_2Label.Text = 'Lff';
                app.TdenffEditField_2Label.Text = 'Tdenff';
                app.TnumffEditField_2Label.Text = 'Tnumff';
                app.TdEditField_2Label.Text = 'Td';
                app.TiEditField_2Label.Text = 'Ti';
                app.KpEditField_2Label.Text = 'Kp';
                app.KffEditField_2Label.Text = 'Kff';
                app.ControladorLabel_2.Text = 'Controlador';
                app.ControladorFFLabel_2.Text = 'Controlador FF';
                
            end
        end
        
        
        function att_plot(app)
           
            %Plot 1 - Valores de PV
            cla(app.UIAxes);
            plot(app.UIAxes,app.PV1);
            hold(app.UIAxes,'on'); 
            plot(app.UIAxes,app.PV2);
            
            legend(app.UIAxes,["Malha 1","Malha 2"]);
            ylim(app.UIAxes,[20 60]);
           
            axis(app.UIAxes,"tight");

            
            %Plot 2 - Valores de MV

            cla(app.UIAxes2);
            plot(app.UIAxes2,app.MV1);
            hold(app.UIAxes2,"on");
            plot(app.UIAxes2,app.MV2);
            
            legend(app.UIAxes2,["Malha 1","Malha 2"]);
 
            axis(app.UIAxes2,"tight");
            
  
            app.n = app.n + 1;
            
            app.MV1(app.n) = app.MV1(app.n-1);
            app.MV2(app.n) = app.MV2(app.n-1);
            app.SP1(app.n) = app.SP1(app.n-1);
            
        end
        

    end
    
    methods (Access = public)
        
        % Função Callback do timer que é chamado a cada tempo
        % especificado
        function Timercallback(app,obj,event)
            MODODropDownValueChanged(app, event);
            MODODropDown_2ValueChanged(app, event)
            app.att_plot();         
            
            
        end
        
        
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            
            
            
            app.MODODropDown.Value = 'MANUAL';
            app.MODODropDown_2.Value = 'MANUAL';
            
            app.PV1 = [0];
            app.MV1 = [0];
            app.PV2 = [0];
            app.MV2 = [0];
            app.SP1 = [0];
            
            app.PVEditField.Value = 0;
            app.SPEditField.Value = 0;
            app.MVEditField.Value = 0;
            app.PVEditField_2.Value = 0;
            app.SPEditField_2.Value = 0;
            app.MVEditField_2.Value = 0;
            
            app.PVEditField_2.Editable = 'off';
            app.PVEditField.Editable = 'off';
           
            modoMANUAL(app);
                      
            app.Mytimer = timer('StartDelay',2,'Period',2,'ExecutionMode','fixedSpacing',...
                           'TasksToExecute', Inf);
            app.Mytimer.TimerFcn = @app.Timercallback;
            
            
                        
            start(app.Mytimer); 

            app.PlacaTermica = PlacaTermicaMatlab();       
            
            app.ContPID_p1 = ControladorPID([app.Kp1 app.Ti1 app.Td1],1);
            
            app.ContPID_p2 = ControladorPID([app.Kp2 app.Ti2 app.Td2],1);
            
            app.ContPID_p1.modo = "auto";
            app.ContPID_p2.modo = "auto";
            
        end

        % Value changed function: MODODropDown
        function MODODropDownValueChanged(app, event)
            modo = app.MODODropDown.Value;
            
            if (modo == "MANUAL")
                modoMANUAL(app);
            end
            if (modo == "AUTO")
                modoAUTO(app);
            end
            if (modo == "FF")
                modoFF(app);
            end
            
            
            
        end

        % Value changed function: MODODropDown_2
        function MODODropDown_2ValueChanged(app, event)
            modo = app.MODODropDown_2.Value;
            
            if (modo == "MANUAL")
                modoMANUAL(app);
            end
            if (modo == "AUTO")
                modoAUTO(app);
            end
            if (modo == "FF")
                modoFF(app);
            end
            
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            try 
                app.PlacaTermica.writeInput(0,0);
            catch 
                disp("Placa não conectada");
            end
            
            stop(app.Mytimer);                       
            delete(app);
            disp("fechado");
            
        end

        % Value changed function: MVEditField
        function MVEditFieldValueChanged(app, event)

            
            
        end

        % Value changed function: MVEditField_2
        function MVEditField_2ValueChanged(app, event)
            
            
        end

        % Button pushed function: AplicarButton
        function AplicarButtonPushed(app, event)
            if (app.MODODropDown.Value == "MANUAL")
                value = app.MVEditField.Value;
                app.MV1(app.n) = value;
                try
                    app.PlacaTermica.writeInput(app.MV1(app.n), app.MV2(app.n));
                catch
                    disp("Placa não conectada");
                end
            elseif(app.MODODropDown.Value == "AUTO")
                app.Kp1 = app.KpEditField.Value;
                app.Ti1 = app.TiEditField.Value;
                app.Td1 = app.TdEditField.Value;
                app.SP1(app.n) = app.SPEditField.Value;
                app.ContPID_p1.Kp = app.Kp1;
                app.ContPID_p1.Ti = app.Ti1;
                app.ContPID_p1.Td = app.Td1;
                app.ContPID_p1.SP = app.SP1(app.n);
               
                
            end
            
        end

        % Button pushed function: AplicarButton_2
        function AplicarButton_2Pushed(app, event)
            if (app.MODODropDown_2.Value == "MANUAL")
            value = app.MVEditField_2.Value;
            app.MV2(app.n) = value;
            try 
                app.PlacaTermica.writeInput(app.MV1(app.n), app.MV2(app.n));
            catch 
                disp("Placa não conectada");
            end
            elseif(app.MODODropDown_2.Value == "AUTO")
                app.Kp2 = app.KpEditField_2.Value;
                app.Ti2 = app.TiEditField_2.Value;
                app.Td2 = app.TdEditField_2.Value;
                app.SP2 = app.SPEditField_2.Value; 
                app.ContPID_p2.Kp = app.Kp2;
                app.ContPID_p2.Ti = app.Ti2;
                app.ContPID_p2.Td = app.Td2;
                app.ContPID_p2.SP = app.SP2;
               
                
            end
        end

        % Button pushed function: SalvardadosButton
        function SalvardadosButtonPushed(app, event)
            horario = datestr(now,'mm_dd_yyyy HH_MM');
            filename = sprintf('dados_%s.mat', horario);
            mv1 = app.MV1;
            mv2 = app.MV2;
            pv1 = app.PV1;
            pv2 = app.PV2;
            sp1 = app.SP1;
            sp2 = app.SP2;
            save(filename,'mv1','mv2','pv1','pv2','sp1','sp2');
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 3x1 grid
                app.GridLayout.RowHeight = {585, 585, 585};
                app.GridLayout.ColumnWidth = {'1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 1;
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 3;
                app.RightPanel.Layout.Column = 1;
            elseif (currentFigureWidth > app.onePanelWidth && currentFigureWidth <= app.twoPanelWidth)
                % Change to a 2x2 grid
                app.GridLayout.RowHeight = {585, 585};
                app.GridLayout.ColumnWidth = {'1x', '1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = [1,2];
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 2;
            else
                % Change to a 1x3 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {233, '1x', 245};
                app.LeftPanel.Layout.Row = 1;
                app.LeftPanel.Layout.Column = 1;
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 2;
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 3;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 820 585];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);
            app.UIFigure.WindowStyle = 'modal';

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {233, '1x', 245};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create MALHA1Label
            app.MALHA1Label = uilabel(app.LeftPanel);
            app.MALHA1Label.Position = [89 556 57 22];
            app.MALHA1Label.Text = 'MALHA 1';

            % Create ControladorLabel
            app.ControladorLabel = uilabel(app.LeftPanel);
            app.ControladorLabel.Position = [24 305 68 22];
            app.ControladorLabel.Text = 'Controlador';

            % Create ControladorFFLabel
            app.ControladorFFLabel = uilabel(app.LeftPanel);
            app.ControladorFFLabel.Position = [134 305 86 22];
            app.ControladorFFLabel.Text = 'Controlador FF';

            % Create MODODropDownLabel
            app.MODODropDownLabel = uilabel(app.LeftPanel);
            app.MODODropDownLabel.HorizontalAlignment = 'right';
            app.MODODropDownLabel.Position = [38 494 43 22];
            app.MODODropDownLabel.Text = 'MODO';

            % Create MODODropDown
            app.MODODropDown = uidropdown(app.LeftPanel);
            app.MODODropDown.Items = {'AUTO', 'MANUAL', 'FF'};
            app.MODODropDown.ValueChangedFcn = createCallbackFcn(app, @MODODropDownValueChanged, true);
            app.MODODropDown.Position = [96 494 100 22];
            app.MODODropDown.Value = 'MANUAL';

            % Create MVEditFieldLabel
            app.MVEditFieldLabel = uilabel(app.LeftPanel);
            app.MVEditFieldLabel.HorizontalAlignment = 'center';
            app.MVEditFieldLabel.Position = [64 394 61 22];
            app.MVEditFieldLabel.Text = 'MV';

            % Create MVEditField
            app.MVEditField = uieditfield(app.LeftPanel, 'numeric');
            app.MVEditField.ValueChangedFcn = createCallbackFcn(app, @MVEditFieldValueChanged, true);
            app.MVEditField.HorizontalAlignment = 'center';
            app.MVEditField.Position = [135 394 39 22];

            % Create SPEditFieldLabel
            app.SPEditFieldLabel = uilabel(app.LeftPanel);
            app.SPEditFieldLabel.HorizontalAlignment = 'center';
            app.SPEditFieldLabel.Position = [63 352 61 22];
            app.SPEditFieldLabel.Text = 'SP';

            % Create SPEditField
            app.SPEditField = uieditfield(app.LeftPanel, 'numeric');
            app.SPEditField.HorizontalAlignment = 'center';
            app.SPEditField.Position = [135 352 39 22];

            % Create PVEditFieldLabel
            app.PVEditFieldLabel = uilabel(app.LeftPanel);
            app.PVEditFieldLabel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.PVEditFieldLabel.HorizontalAlignment = 'center';
            app.PVEditFieldLabel.Position = [64 436 61 22];
            app.PVEditFieldLabel.Text = 'PV';

            % Create PVEditField
            app.PVEditField = uieditfield(app.LeftPanel, 'numeric');
            app.PVEditField.Editable = 'off';
            app.PVEditField.HorizontalAlignment = 'center';
            app.PVEditField.Position = [135 436 39 22];
            app.PVEditField.Value = 91;

            % Create KpEditFieldLabel
            app.KpEditFieldLabel = uilabel(app.LeftPanel);
            app.KpEditFieldLabel.Position = [8 271 41 22];
            app.KpEditFieldLabel.Text = 'Kp';

            % Create KpEditField
            app.KpEditField = uieditfield(app.LeftPanel, 'numeric');
            app.KpEditField.HorizontalAlignment = 'center';
            app.KpEditField.Position = [79 271 30 22];

            % Create TiEditFieldLabel
            app.TiEditFieldLabel = uilabel(app.LeftPanel);
            app.TiEditFieldLabel.Position = [8 232 41 22];
            app.TiEditFieldLabel.Text = 'Ti';

            % Create TiEditField
            app.TiEditField = uieditfield(app.LeftPanel, 'numeric');
            app.TiEditField.HorizontalAlignment = 'center';
            app.TiEditField.Position = [79 232 30 22];

            % Create TdEditFieldLabel
            app.TdEditFieldLabel = uilabel(app.LeftPanel);
            app.TdEditFieldLabel.Position = [7 193 41 22];
            app.TdEditFieldLabel.Text = 'Td';

            % Create TdEditField
            app.TdEditField = uieditfield(app.LeftPanel, 'numeric');
            app.TdEditField.HorizontalAlignment = 'center';
            app.TdEditField.Position = [79 193 30 22];

            % Create KffEditFieldLabel
            app.KffEditFieldLabel = uilabel(app.LeftPanel);
            app.KffEditFieldLabel.Position = [126 271 41 22];
            app.KffEditFieldLabel.Text = 'Kff';

            % Create KffEditField
            app.KffEditField = uieditfield(app.LeftPanel, 'numeric');
            app.KffEditField.HorizontalAlignment = 'center';
            app.KffEditField.Position = [197 271 30 22];

            % Create TnumffEditFieldLabel
            app.TnumffEditFieldLabel = uilabel(app.LeftPanel);
            app.TnumffEditFieldLabel.Position = [125 232 43 22];
            app.TnumffEditFieldLabel.Text = 'Tnumff';

            % Create TnumffEditField
            app.TnumffEditField = uieditfield(app.LeftPanel, 'numeric');
            app.TnumffEditField.HorizontalAlignment = 'center';
            app.TnumffEditField.Position = [198 232 30 22];

            % Create TdenffEditFieldLabel
            app.TdenffEditFieldLabel = uilabel(app.LeftPanel);
            app.TdenffEditFieldLabel.Position = [126 194 41 22];
            app.TdenffEditFieldLabel.Text = 'Tdenff';

            % Create TdenffEditField
            app.TdenffEditField = uieditfield(app.LeftPanel, 'numeric');
            app.TdenffEditField.HorizontalAlignment = 'center';
            app.TdenffEditField.Position = [197 194 30 22];

            % Create LffEditFieldLabel
            app.LffEditFieldLabel = uilabel(app.LeftPanel);
            app.LffEditFieldLabel.Position = [127 156 41 22];
            app.LffEditFieldLabel.Text = 'Lff';

            % Create LffEditField
            app.LffEditField = uieditfield(app.LeftPanel, 'numeric');
            app.LffEditField.HorizontalAlignment = 'center';
            app.LffEditField.Position = [198 156 30 22];

            % Create AplicarButton
            app.AplicarButton = uibutton(app.LeftPanel, 'push');
            app.AplicarButton.ButtonPushedFcn = createCallbackFcn(app, @AplicarButtonPushed, true);
            app.AplicarButton.Position = [96 118 100 22];
            app.AplicarButton.Text = 'Aplicar';

            % Create SalvardadosButton
            app.SalvardadosButton = uibutton(app.LeftPanel, 'push');
            app.SalvardadosButton.ButtonPushedFcn = createCallbackFcn(app, @SalvardadosButtonPushed, true);
            app.SalvardadosButton.Position = [96 79 100 22];
            app.SalvardadosButton.Text = 'Salvar dados';

            % Create CenterPanel
            app.CenterPanel = uipanel(app.GridLayout);
            app.CenterPanel.Layout.Row = 1;
            app.CenterPanel.Layout.Column = 2;

            % Create UIAxes
            app.UIAxes = uiaxes(app.CenterPanel);
            title(app.UIAxes, 'Temperatura (ºC)')
            xlabel(app.UIAxes, 'Tempo (s)')
            ylabel(app.UIAxes, 'PV (ºC)')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [7 356 321 188];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.CenterPanel);
            title(app.UIAxes2, 'Duty Cicle')
            xlabel(app.UIAxes2, 'Tempo (s)')
            ylabel(app.UIAxes2, 'MV (%)')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [7 84 321 188];

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 3;

            % Create MALHA2Label
            app.MALHA2Label = uilabel(app.RightPanel);
            app.MALHA2Label.Position = [100 522 57 22];
            app.MALHA2Label.Text = 'MALHA 2';

            % Create ControladorLabel_2
            app.ControladorLabel_2 = uilabel(app.RightPanel);
            app.ControladorLabel_2.Position = [36 271 68 22];
            app.ControladorLabel_2.Text = 'Controlador';

            % Create ControladorFFLabel_2
            app.ControladorFFLabel_2 = uilabel(app.RightPanel);
            app.ControladorFFLabel_2.Position = [146 271 86 22];
            app.ControladorFFLabel_2.Text = 'Controlador FF';

            % Create MODODropDown_2Label
            app.MODODropDown_2Label = uilabel(app.RightPanel);
            app.MODODropDown_2Label.HorizontalAlignment = 'right';
            app.MODODropDown_2Label.Position = [49 460 43 22];
            app.MODODropDown_2Label.Text = 'MODO';

            % Create MODODropDown_2
            app.MODODropDown_2 = uidropdown(app.RightPanel);
            app.MODODropDown_2.Items = {'AUTO', 'MANUAL', 'FF'};
            app.MODODropDown_2.ValueChangedFcn = createCallbackFcn(app, @MODODropDown_2ValueChanged, true);
            app.MODODropDown_2.Position = [107 460 100 22];
            app.MODODropDown_2.Value = 'MANUAL';

            % Create MVEditField_2Label
            app.MVEditField_2Label = uilabel(app.RightPanel);
            app.MVEditField_2Label.HorizontalAlignment = 'center';
            app.MVEditField_2Label.Position = [72 360 61 22];
            app.MVEditField_2Label.Text = 'MV';

            % Create MVEditField_2
            app.MVEditField_2 = uieditfield(app.RightPanel, 'numeric');
            app.MVEditField_2.ValueChangedFcn = createCallbackFcn(app, @MVEditField_2ValueChanged, true);
            app.MVEditField_2.HorizontalAlignment = 'center';
            app.MVEditField_2.Position = [143 360 39 22];

            % Create SPEditField_2Label
            app.SPEditField_2Label = uilabel(app.RightPanel);
            app.SPEditField_2Label.HorizontalAlignment = 'center';
            app.SPEditField_2Label.Position = [71 318 61 22];
            app.SPEditField_2Label.Text = 'SP';

            % Create SPEditField_2
            app.SPEditField_2 = uieditfield(app.RightPanel, 'numeric');
            app.SPEditField_2.HorizontalAlignment = 'center';
            app.SPEditField_2.Position = [143 318 39 22];

            % Create PVEditField_2Label
            app.PVEditField_2Label = uilabel(app.RightPanel);
            app.PVEditField_2Label.BackgroundColor = [0.9412 0.9412 0.9412];
            app.PVEditField_2Label.HorizontalAlignment = 'center';
            app.PVEditField_2Label.Position = [72 402 61 22];
            app.PVEditField_2Label.Text = 'PV';

            % Create PVEditField_2
            app.PVEditField_2 = uieditfield(app.RightPanel, 'numeric');
            app.PVEditField_2.Editable = 'off';
            app.PVEditField_2.HorizontalAlignment = 'center';
            app.PVEditField_2.Position = [143 402 39 22];
            app.PVEditField_2.Value = 9;

            % Create KpEditField_2Label
            app.KpEditField_2Label = uilabel(app.RightPanel);
            app.KpEditField_2Label.Position = [19 237 41 22];
            app.KpEditField_2Label.Text = 'Kp';

            % Create KpEditField_2
            app.KpEditField_2 = uieditfield(app.RightPanel, 'numeric');
            app.KpEditField_2.HorizontalAlignment = 'center';
            app.KpEditField_2.Position = [90 237 30 22];

            % Create TiEditField_2Label
            app.TiEditField_2Label = uilabel(app.RightPanel);
            app.TiEditField_2Label.Position = [19 198 41 22];
            app.TiEditField_2Label.Text = 'Ti';

            % Create TiEditField_2
            app.TiEditField_2 = uieditfield(app.RightPanel, 'numeric');
            app.TiEditField_2.HorizontalAlignment = 'center';
            app.TiEditField_2.Position = [90 198 30 22];

            % Create TdEditField_2Label
            app.TdEditField_2Label = uilabel(app.RightPanel);
            app.TdEditField_2Label.Position = [18 159 41 22];
            app.TdEditField_2Label.Text = 'Td';

            % Create TdEditField_2
            app.TdEditField_2 = uieditfield(app.RightPanel, 'numeric');
            app.TdEditField_2.HorizontalAlignment = 'center';
            app.TdEditField_2.Position = [90 159 30 22];

            % Create KffEditField_2Label
            app.KffEditField_2Label = uilabel(app.RightPanel);
            app.KffEditField_2Label.Position = [138 237 41 22];
            app.KffEditField_2Label.Text = 'Kff';

            % Create KffEditField_2
            app.KffEditField_2 = uieditfield(app.RightPanel, 'numeric');
            app.KffEditField_2.HorizontalAlignment = 'center';
            app.KffEditField_2.Position = [209 237 30 22];

            % Create TnumffEditField_2Label
            app.TnumffEditField_2Label = uilabel(app.RightPanel);
            app.TnumffEditField_2Label.Position = [137 198 43 22];
            app.TnumffEditField_2Label.Text = 'Tnumff';

            % Create TnumffEditField_2
            app.TnumffEditField_2 = uieditfield(app.RightPanel, 'numeric');
            app.TnumffEditField_2.HorizontalAlignment = 'center';
            app.TnumffEditField_2.Position = [210 198 30 22];

            % Create TdenffEditField_2Label
            app.TdenffEditField_2Label = uilabel(app.RightPanel);
            app.TdenffEditField_2Label.Position = [138 160 41 22];
            app.TdenffEditField_2Label.Text = 'Tdenff';

            % Create TdenffEditField_2
            app.TdenffEditField_2 = uieditfield(app.RightPanel, 'numeric');
            app.TdenffEditField_2.HorizontalAlignment = 'center';
            app.TdenffEditField_2.Position = [209 160 30 22];

            % Create LffEditField_2Label
            app.LffEditField_2Label = uilabel(app.RightPanel);
            app.LffEditField_2Label.Position = [139 122 41 22];
            app.LffEditField_2Label.Text = 'Lff';

            % Create LffEditField_2
            app.LffEditField_2 = uieditfield(app.RightPanel, 'numeric');
            app.LffEditField_2.HorizontalAlignment = 'center';
            app.LffEditField_2.Position = [210 122 30 22];

            % Create AplicarButton_2
            app.AplicarButton_2 = uibutton(app.RightPanel, 'push');
            app.AplicarButton_2.ButtonPushedFcn = createCallbackFcn(app, @AplicarButton_2Pushed, true);
            app.AplicarButton_2.Position = [103 84 100 22];
            app.AplicarButton_2.Text = 'Aplicar';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = UI_PlacaTermicaOPC_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end