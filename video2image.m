%% VIDEO CUTTER
% Description: This program allows cutting a video 'video_name'
% from the instant 'initial_time' to the instant 'final_time' (all inseconds)
% skipping 'frame_step' frames per each iteration.
%
% @Author: Santiago S. Silva R.
% © 2017


%% Clear and close all
clear, close all;
clc;

%% Load Video
video_name = 'test.mp4';    % Name of the video
folder_output = ['images_', video_name];   % Directory where the video is going to be saved

video = VideoReader(video_name);    % Load video into a variable "video"

%% Extract frames and convert them into images

% Set cutting parameters
initial_time    = 4.7;    % Start cutting (in seconds)
final_time      = 10;    % Final cutting (in seconds)
frame_step      = 10;   % How many frames you want to jump (skip)


% Video parameters (do not modify)
fr = video.FrameRate;
tt = video.Duration;

if final_time > tt
    error('The final time is larger than the video duration.')
elseif initial_time < 0
    error('Initial time cannot be negative.')
elseif isequal(folder_output,'')
    error('No folder has been set as a directory ouput.')
else
    % Clear previous files
    if exist([pwd, filesep, folder_output],'dir')
        rmdir(folder_output, 's');
        mkdir(folder_output);
    else
        mkdir(folder_output);
    end
    % Start Extracting frames
    disp('Converting video...');
    ii = 1;
    for t = initial_time:frame_step/fr:final_time
        video.CurrentTime = t;
        img = readFrame(video);
        filename = [sprintf('%03d',ii) '.jpg'];
        fullname = fullfile(folder_output,filename);
        imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
        ii = ii+1;
    end
    disp('Conversion finished SUCCESSFULLY');
end