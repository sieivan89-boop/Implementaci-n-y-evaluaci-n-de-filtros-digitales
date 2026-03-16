% Analysis of Digital Filters using MATLAB

%% 1. Generating Sinusoidal Signals

fs = 1000;             % Sampling frequency (Hz)
t = 0:1/fs:1;         % Time vector (1 second duration)
f1 = 5;              % Frequency of first sinusoid (Hz)
f2 = 50;             % Frequency of second sinusoid (Hz)

signal1 = sin(2*pi*f1*t); % First sinusoidal signal
signal2 = sin(2*pi*f2*t); % Second sinusoidal signal

combined_signal = signal1 + 0.5*signal2; % Combined signal

%% 2. Designing Filters

% Lowpass filter
lpFilt = designfilt('lowpassfir','PassbandFrequency',10,...
    'StopbandFrequency',15,'PassbandRipple',1,'StopbandAttenuation',60,'SampleRate',fs);

% Highpass filter
hpFilt = designfilt('highpassfir','PassbandFrequency',20,...
    'StopbandFrequency',15,'PassbandRipple',1,'StopbandAttenuation',60,'SampleRate',fs);

% Bandpass filter
bpFilt = designfilt('bandpassfir','PassbandFrequency1',15,...
    'PassbandFrequency2',50,'StopbandFrequency1',10,'StopbandFrequency2',55,...
    'PassbandRipple',1,'StopbandAttenuation',60,'SampleRate',fs);

%% 3. Applying Filters

lowpass_signal = filter(lpFilt, combined_signal);
highpass_signal = filter(hpFilt, combined_signal);
bandpass_signal = filter(bpFilt, combined_signal);

%% 4. Visualizing Results

figure;
subplot(3,1,1);
plot(t, lowpass_signal);
title('Lowpass Filtered Signal');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t, highpass_signal);
title('Highpass Filtered Signal');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t, bandpass_signal);
title('Bandpass Filtered Signal');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% Frequency domain visualization

N = length(combined_signal);
frequencies = (0:N-1)*(fs/N);
signal_fft = abs(fft(combined_signal));

figure;
plot(frequencies, signal_fft);
title('Frequency Domain Representation');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
grid on;