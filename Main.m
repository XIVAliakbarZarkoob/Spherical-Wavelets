%% Aliakbar Zarkoob, AKA "XIV"
%  Gmail: XIV.Aliakbar.Zarkoob@gmail.com
%  Telegram: @XIVAliakbar

clc, clear, close all, beep off, format long g
set(0,'defaultTextInterpreter','latex')

%% Load Data

% data_tab = readtable('Global_XGM2019_Potential_2-0Deg.dat', 'NumHeaderLines', 32, 'ReadVariableNames', false, 'FileType', 'text');
% data_tab.Properties.VariableNames = {'idx', 'lon', 'lat', 'h', 'U'};

data_tab = readtable('Global_GOCO2025s_Potential_1-0Deg.dat', 'NumHeaderLines', 32, 'ReadVariableNames', false, 'FileType', 'text');
data_tab.Properties.VariableNames = {'idx', 'lon', 'lat', 'h', 'U'};

data_main = [data_tab.lon, data_tab.lat, data_tab.U];

%% Implementation

data = data_tab.U;
data = reshape(data, length(unique(data_tab.lat)), length(unique(data_tab.lon)));

% Parameters
scales = 1:8; % Scales from 1 to 8
N = size(data, 1); % Number of latitude points
M = size(data, 2); % Number of longitude points

% Preallocate cell arrays for scaling and wavelet functions
scaling_functions = cell(length(scales), 1);
wavelet_functions = cell(length(scales), 1);

% Loop through scales and compute scaling and wavelet functions
for scale = scales
    % Compute scaling function (low-pass filter)
    scaling_function = lowpass_filter_sphere(data, scale);
    scaling_functions{scale} = scaling_function;

    % Compute wavelet function (band-pass filter)
    wavelet_function = bandpass_filter_sphere(data, scale);
    wavelet_functions{scale} = wavelet_function;
end

% Visualization of scaling and wavelet functions
for scale = scales
    figure;
    % Scaling Function
    subplot(1, 2, 1);
    imagesc(scaling_functions{scale});
    title(['Scaling Function at Scale ', num2str(scale)]);
    xlabel('Longitude');
    ylabel('Latitude');
    axis equal tight
    colorbar;

    % Wavelet Function
    subplot(1, 2, 2);
    imagesc(wavelet_functions{scale});
    title(['Wavelet Function at Scale ', num2str(scale)]);
    xlabel('Longitude');
    ylabel('Latitude');
    axis equal tight
    colorbar;
end

% Low-pass filter for scaling function
function output = lowpass_filter_sphere(data, scale)
    % Simulate a low-pass filter by smoothing the data
    filter_size = scale * 2; % Increase filter size with scale
    kernel = fspecial('gaussian', [filter_size filter_size], scale); % Gaussian kernel
    output = imfilter(data, kernel, 'symmetric');
end

% Band-pass filter for wavelet function
function output = bandpass_filter_sphere(data, scale)
    % Simulate a band-pass filter by subtracting successive low-pass filters
    lowpass1 = lowpass_filter_sphere(data, scale);
    lowpass2 = lowpass_filter_sphere(data, scale + 1);
    output = lowpass1 - lowpass2;
end

%% Export Results

scale = zeros(length(data_main), length(scales));
wavelet = zeros(length(data_main), length(scales));
for i = scales

    scale(:, i) = scaling_functions{i}(:);
    wavelet(:, i) = wavelet_functions{i}(:);

end

save('Results.mat', 'data_main', 'scale', 'wavelet')