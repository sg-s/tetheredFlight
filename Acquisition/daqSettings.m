function daqSettings(trialStructureName)

        global analogIn;
        global digitalIO;
        global daqParams;
        
        daqParams.offsetTime = .110 - .25;  % Offset from serial commands in sec. (adjust for serial latency)      
        daqParams.SampleRate = 1000.40;

        analogIn = analoginput('mcc','0');  
%        set(analogIn, 'InputType','SingleEnded');  % Unused on mcc boards
        warning('off', 'daq:daqmex:propertyConfigurationError');
        set(analogIn, 'SampleRate',daqParams.SampleRate);
        daqParams.SampleRate = get(analogIn, 'SampleRate');
        addchannel(analogIn, 0:6, {'LAmp','RAmp','Freq','Laser','Receive','X','Odor'});
        
        digitalIO = digitalio('mcc','0');
        addline(digitalIO,0:1,'out');   % Odor1 and Odor2
        
        % Store the most recent xOutputCalibration
        load('./xOutputCalibration.mat');
        daqParams.xOutputCal = xOutputCal;
 
        

        
        