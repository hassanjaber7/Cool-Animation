%Hassan Jaber 330214
% Create a figure with 3D axes
figure;
ax = axes('XLim', [-5 5], 'YLim', [-5 5], 'ZLim', [-5 5]);
view(3);
grid on;

% Parameters for the spring
numCoils = 8;
coilRadius = 50;

% Increase the number of spheres for a denser arrangement
numSpheres = 2000;
t = linspace(0, 2 * pi * numCoils, numSpheres);

% Create colors for the spheres
colors = jet(numSpheres);

% Create and display the spheres
z = linspace(0, 100, numSpheres); % Initial coil height
x = coilRadius * cos(t);
y = coilRadius * sin(t);
spheres = scatter3(x, y, z, 50, colors, 'filled');

% Set the properties for the axis 
axis(ax, 'equal'); % Maintain equal aspect ratio
xlabel('X');
ylabel('Y');
zlabel('Z');

% Define the number of animation frames
nFrames = 150;
frequency = 0.5; % Adjust the frequency of oscillation

% Infinite loop
while true
    for frame = 1:nFrames
        angle = (frame / nFrames) * 2 * pi * numCoils;
        
        % modulate coilHeight
        coilHeight = 50 + 100 * sin(2 * pi * frequency * frame / nFrames);
        
        % Update z values
        z = linspace(0, coilHeight, numSpheres);
        
        % Apply rotation effect
        tform = makehgtform('zrotate', angle);
        rotatedCoords = tform(1:3, 1:3) * [x; y; z];
        
        spheres.XData = rotatedCoords(1, :);
        spheres.YData = rotatedCoords(2, :);
        spheres.ZData = rotatedCoords(3, :);
        
        drawnow;
        pause(0.05);
    end
end
