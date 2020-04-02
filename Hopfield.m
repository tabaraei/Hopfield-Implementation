clc;
clear;
close all;

% define X/O/+ patterns
patternX = [
     1, -1, -1, -1,  1;
    -1,  1, -1,  1, -1;
    -1, -1,  1, -1, -1;
    -1,  1, -1,  1, -1;
     1, -1, -1, -1,  1;
    ];
patternO = [
    -1,  1,  1,  1, -1;
     1, -1, -1, -1,  1;
     1, -1, -1, -1,  1;
     1, -1, -1, -1,  1;
    -1 , 1,  1,  1, -1;
    ];
patternPlus = [
    -1, -1, 1, -1, -1;
    -1, -1, 1, -1, -1;
     1,  1, 1,  1,  1;
    -1, -1, 1, -1, -1;
    -1, -1, 1, -1, -1;
    ];

% convert patterns to a single row vector
patternX = reshape(patternX',1,[]);
patternO = reshape(patternO',1,[]);
patternPlus = reshape(patternPlus',1,[]);

% input pattern
x = [
    -1,  1,  1,  -1, -1;
     1, -1, -1, 1,  1;
     1, -1, -1, -1,  1;
     1, -1, -1, 1,  1;
    -1 , 1,  1,  -1, -1;
    ];
x = reshape(x',1,[]);

% initialize weights
w1 = (patternX')*(patternX); 
w2 = (patternO')*(patternO);
w3 = (patternPlus')*(patternPlus);
% set main diameter to zero
for i=1:25
    w1(i,i) = 0 ;
    w2(i,i) = 0 ;
    w3(i,i) = 0 ;
end
w = w1 + w2 + w3 ;

% random-ordered indexes
randomIndex = randperm(25);

% main algorithm
y = x;
y_temp = y;
epochs = 0;

while true
    for i=1:size(x,2)
        sum = 0;
        for j=1:size(x,2)
            sum = sum + (y(j)*w(j,i));
        end
        
        yin= x(randomIndex(i)) + sum ;
        if yin > 0
            y(i) = 1 ;
        elseif yin < 0
            y(i) = -1 ;
        end
    end
    
    for j=1:size(x,2)
        if y_temp(1,j) ~= y(1,j)
            run = true;
        end
        if y_temp(1,j) == y(1,j)
            run = false;
        end   
    end
    
    y_temp = y ; 
    epochs = epochs +1 ;

    % exit condition
    if run == false
        break;
    end
end

fprintf('number of epochs = %d\n', epochs);
disp(['input = ', mat2str(x)]);
disp(['output = ', mat2str(y)]);