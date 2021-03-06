function magnetoCalibrateXInput()

    stepLength = 1; % in seconds

    global analogIn;
    global analogOut;
    global daqParams;
    global trackingParams;
    
    [USB, ardVar] = initializeArduino();
    % Intitialize the DAQ
    daqSettings();
       
    sampleRate = get(analogIn, 'SampleRate');
    set(analogIn, 'SamplesPerTrigger',uint32(stepLength*sampleRate));
    analogOut = setupAnalogOutput;
    ardSetAutoCenter(6);  % Set to magno-mirror mode
    
    % Changes set angle of drum
    for i = 1:11;
        
        voltage(i) = (i-1)*4/12;
        disp(['Testing voltage = ',num2str(voltage(i))]);
        putsample(analogOut, voltage(i));
        ardDispOn(); 
        pause(.1);
        start(analogIn);
        
        wait(analogIn,stepLength+2);
        acquiredData = getdata(analogIn);
        clear X;
        X     = acquiredData(:,6);
        [smoothX, wrappedX] = smoothUnwrap(X, daqParams.xOutputCal, 0);   
        angle(i) = mean(wrappedX);
    end
    
    figure();
    plot(angle, voltage, 'bo');
    cfun = fit(angle', voltage', 'poly1');
    xInputCal.slope = cfun.p1;
    xInputCal.intercept = cfun.p2;
    hold on;
    plot(0:360,cfun.p1*(0:360) + cfun.p2, 'r-');
    xlabel('Arena angle (deg)');
    ylabel('Desired flight computer input (V)');
    title('Calibration Curve');
    
    trackingParams.xInputCal = xInputCal;
    save('./xInputCalibration.mat','xInputCal');
    disp(['Wrote calibration: slope = ',num2str(cfun.p1),' V/deg,  intercept = ',num2str(cfun.p2),' V']);
    
