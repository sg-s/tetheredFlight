
% closedLoop.m

% Constants
global ts;

center = 0;

% Format: {time, visStim}
%          [Mode, K0, K1, K2]
visStim0 = [1, 0, 0,  0];
visStimN = [1, -40, 0, 0];
visStimP = [1, 40, 0, 0];
LaserOn  = '0000';
LaserOff = '0000';
olf1 = '0000';
olf2 = '0000';

histogramBounds = [1,160];

trialStructureList = [...
        {0,    visStim0, LaserOff, '0000','0000','0000'};...     %nb. First line is initial settingss
        {1,    visStim0, LaserOn, '0000','0000','0000'};...
        {20,   visStimN, LaserOn, '0000','0000','0000'};...
        {40,   visStim0, LaserOn, '0000','0000','0000'};...
        {60,   visStimP, LaserOn, '0000','0000','0000'};...
        {80,   visStim0, LaserOn, '0000','0000','0000'};...
        {100,  visStimN, LaserOn, '0000','0000','0000'};...
        {120,  visStim0, LaserOn, '0000','0000','0000'};...
        {140,  visStimP, LaserOn, '0000','0000','0000'};...
        {160,  visStimN, LaserOff, '0000','0000','0000'};...
    ];

    