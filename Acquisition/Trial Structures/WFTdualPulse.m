%% WFTdualPulse.m
%

% Constants
global ts;

center = 0;

% Format: {time, visStim}
%          [Mode, K0, K1, K2]
visStim0 = [1, 0, 0,  center];
visStimN = [1, 0, -1, 0];
LaserOff = '0000';

histogramBounds = [1,8*60];

trialStructureList = [...
        {0,    visStimN, LaserOff, '0000','0000','0000'};...     %nb. First line is initial settingss
        {1,    visStimN, LaserOff, '0000','0000','0000'};...
        
        {0*60+20,   visStimN, LaserOff, 'ffff','0000','0000'};...  % First control
        {0*60+30,   visStimN, LaserOff, '0000','0000','ffff'};...
        {0*60+32,   visStimN, LaserOff, '0000','0000','0000'};...
        {0*60+60,   visStimN, LaserOff, '0000','0000','0000'};...
        
        {1*60+20,   visStimN, LaserOff, 'ffff','0000','0000'};...  % First odor
        {1*60+30,   visStimN, LaserOff, '0000','ffff','0000'};...
        {1*60+32,   visStimN, LaserOff, '0000','0000','0000'};...
        {1*60+60,   visStimN, LaserOff, '0000','0000','0000'};...
        
        {2*60+20,   visStimN, LaserOff, 'ffff','0000','0000'};...  % Second odor
        {2*60+30,   visStimN, LaserOff, '0000','ffff','0000'};...
        {2*60+32,   visStimN, LaserOff, '0000','0000','0000'};...
        {2*60+60,   visStimN, LaserOff, '0000','0000','0000'};...
        
        {3*60+20,   visStimN, LaserOff, 'ffff','0000','0000'};...  % Third odor
        {3*60+30,   visStimN, LaserOff, '0000','ffff','0000'};...
        {3*60+32,   visStimN, LaserOff, '0000','0000','0000'};...
        {3*60+60,   visStimN, LaserOff, '0000','0000','0000'};...
        
        {4*60+20,   visStimN, LaserOff, 'ffff','0000','0000'};...  % Second control
        {4*60+30,   visStimN, LaserOff, '0000','0000','ffff'};...
        {4*60+32,   visStimN, LaserOff, '0000','0000','0000'};...
        {4*60+60,   visStimN, LaserOff, '0000','0000','0000'};...
        
        {5*60+20,   visStimN, LaserOff, 'ffff','0000','0000'};...  % Fourth odor
        {5*60+30,   visStimN, LaserOff, '0000','ffff','0000'};...
        {5*60+32,   visStimN, LaserOff, '0000','0000','0000'};...
        {5*60+60,   visStimN, LaserOff, '0000','0000','0000'};...
        
        {6*60+20,   visStimN, LaserOff, 'ffff','0000','0000'};...  % Fourth odor
        {6*60+30,   visStimN, LaserOff, '0000','ffff','0000'};...
        {6*60+32,   visStimN, LaserOff, '0000','0000','0000'};...
        {6*60+60,   visStimN, LaserOff, '0000','0000','0000'};...
                      
        {7*60+20,   visStimN, LaserOff, 'ffff','0000','0000'};...  % Third  control
        {7*60+30,   visStimN, LaserOff, '0000','0000','ffff'};...
        {7*60+32,   visStimN, LaserOff, '0000','0000','0000'};...
        {7*60+60,   visStimN, LaserOff, '0000','0000','0000'};...

    ];

    