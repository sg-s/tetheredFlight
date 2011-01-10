% readme.m
%
% This package implements live-video tracking for a magneto-tether setup.
% For an example of how to use it to start tracking immediately, check out
% startTracking.m
%
% Operation:
%
% First, run setupTrackingCamera() to start the image acquisition and
% tracking.  Adjust the video exposure using cam().  Center the fly in the
% ROI either by adjusting the fly position or by clicking on the image to
% recenter the ROI. (Shift-Click to place the ROI in the center of the
% frame.)
%
% The program has 4 display modes that are switched between using the 
% show***View commands:
%
% 0 - RawView, just the raw video plus the graticule.  Pretty simple.
% 1 - FlyView, highlights regions that the tracker picks out in red.
% 2 - AvgView, shows the running avg. in cyan, live video in red.  Use this
% to assess the quality of your running average.  If a fly is stopped,
% you'll initially see it fade from red into white.  When it's totally grey
% that means the current image is equal to the running averge.
% 3 - DiffView, shows the difference from avg., hotter in red, colder in
% blue.  Only one of these colors will be tracked.  Use the invert
% parameter in magnetoTrack.m to choose which.
%
% Tracking parameters are in magnetoTrack.m and initTrackingParams.m, 
% and there are 4 different modes available for tracking. 
%
% By default, the program is always updating its running average.  You can
% freeze the running average by running setAvg(false), or restart it by
% running setAvg(true).
%
% For a quick view of the last few seconds of tracking, run
% plotRingBuffer().  You'll see a plot of recent tracks, and a histogram of
% the interval between frames.  The peak should be tightly centered on the
% video frame rate, although some jitter is normal.
%
% JSB 11/2010