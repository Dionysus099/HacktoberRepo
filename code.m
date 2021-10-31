%PART-1: Reading audio signal
[y,fs] = audioread('9.wav');        %%Signal-1
%[y,fs] = audioread('38.wav');      %%Signal-2
%Here,
%y  = sampled audio data
%fs = sampling rate for the above data
sound(y,fs);

%PART-2: Analyzing and plotting the audio signal
%audioread function produces a Nx2 matrix
%The matrix has two columns i.e. number of channels
%First channel is for the left ear
%Second channel is for the right ear
dt=1/fs;
t=0:dt:((length(y)*dt)-dt); %converting x-axis into time-frame
subplot(5,3,[1 2 3]);
plot(t,y);                  %plotting audio signal
xlabel('Time(s)');
ylabel('Amplitude');
title('Audio signal: 9.wav');
%title('Audio signal: 38.wav');
grid;

%PART-3: Perform N-point FFT of the first column of y

y_col1 = y(:,1);    %working with first column of y
n_fft_y_col1 = fftshift(fft(y_col1));   %N-point FFT
len=length(y_col1);

%PART-3A: angular frequency along the x-axis from [0, 2𝜋)
range2 = 0:((2*pi)/(len-1)):2*pi;
subplot(5,3,4);
plot(range2,abs(n_fft_y_col1)/len);
xticks([0 pi/2 pi 3*pi/2 2*pi]);
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
xlim([0 2*pi]);
xlabel('Angular frequency');
ylabel('Amplitude');
title('Plot - 3a');
grid;

%PART-3B: angular frequency along the x-axis from [−𝜋, 𝜋)
range3 = -pi:(2*pi/(len-1)):pi;
subplot(5,3,5);
plot(range3,abs(n_fft_y_col1)/len);
xticks([-pi -pi/2 0 pi/2 pi]);
xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'})
xlim([-pi pi]);
xlabel('Angular Frequency');
ylabel('Amplitude');
title('Plot - 3b');
grid;

%PART-3C: normalized frequency along the x-axis from [-0.5, 0.5)
range4 = -0.5:(1/(len-1)):0.5;
subplot(5,3,6);
plot(range4,abs(n_fft_y_col1)/len);
xlabel('Normalized Frequency');
ylabel('Amplitude');
title('Plot - 3c');
grid;

%PART-3D: Frequency in Hertz along the x-axis
range = -fs/2:(fs/(len-1)):fs/2;
subplot(5,3,7);
plot(range,abs(n_fft_y_col1)/len);
xlabel('Frequency(Hz)');
ylabel('Amplitude');
title('Plot - 3d');
grid;

%PART-4: 256-point FFT of the entire signal
%dividing the entire singal into 256-equally spaced samples
samples = y_col1(1:len/256:len); 
%Performing FFT on the sampled signal
fft_256_point = fftshift(fft(samples));
%Setting appropriate range
range5 = -fs/2:fs/255:fs/2;
subplot(5,3,8)
plot(range5,abs(fft_256_point)/256);
xlabel('Frequency(Hz)');
ylabel('Amplitude');
title('Plot-4: 256point FFT');
grid;

%PART-5: 256-point FFT of the first 256 samples of the signal.
%slicing the first 256 samples from the signal
samples_first256 = y_col1(1:256);
%performing FFT on this sampled signal
fft_first256_point = fftshift(fft(samples_first256));
subplot(5,3,9);
plot(range5,abs(fft_first256_point)/256);
xlabel('Frequency(Hz)');
ylabel('Amplitude');
title('Plot-5: First 256 samples FFT');
grid;


%PART-6: 1024-point FFT

%First 1024-samples
samples_first1024 = y_col1(1:1024);
subplot(5,3,10);
t=0:dt:((length(samples_first1024)*dt)-dt);
plot(t,samples_first1024);
xlabel('Time(s)');
ylabel('Amplitude');
title('Plot-6: First 1024 samples time-domain signal');
grid;
fft_first1024_point = fftshift(fft(samples_first1024));
N6=-fs/2:fs/1023:fs/2;
subplot(5,3,13);
plot(N6,abs(fft_first1024_point)/1024);
xlabel('Frequency(Hz)');
ylabel('Amplitude');
title('Plot-6: First 1024 samples FFT');
grid;

%Middle 1024 samples
samples_middle1024 = y_col1(len/2 - 1024/2 : len/2 + 1024/2 - 1);
subplot(5,3,11);
t=((5-((length(samples_middle1024)*dt)-dt))/2):dt:((5+((length(samples_middle1024)*dt)-dt))/2);
plot(t,samples_middle1024);
xlabel('Time(s)');
ylabel('Amplitude');
title('Plot-6: Middle 1024 samples time-domain signal');
grid;
fft_middle1024_point = fftshift(fft(samples_middle1024));
subplot(5,3,14);
plot(N6,abs(fft_middle1024_point)/1024);
xlabel('Frequency(Hz)');
ylabel('Amplitude');
title('Plot-6: Middle 1024 samples FFT');
grid;

%End 1024 samples
samples_end1024 = y_col1(len-1024:len-1);
subplot(5,3,12);
t=5-((length(samples_end1024)*dt)-dt):dt:5;
plot(t,samples_end1024);
xlabel('Time(s)');
ylabel('Amplitude');
title('Plot-6: End 1024 samples time-domain signal');
grid;
fft_end1024_point = fftshift(fft(samples_end1024));
subplot(5,3,15);
plot(N6,abs(fft_end1024_point)/1024);
xlabel('Frequency(Hz)');
ylabel('Amplitude');
title('Plot-6: End 1024 samples FFT');
grid;













