function net = cnnff(net, x)
    n = numel(net.layers);
    %net.layers{1}.a{1} = x; %batch_x 
    inputmaps = net.layers{1}.inputmaps;
    for i=1:inputmaps  
    channel=reshape(x(:,:,i,:), net.layers{1}.sizey, net.layers{1}.sizex, size(x,4)); 
    net.layers{1}.a{i}=channel; % 网?的第一?就是?入，但?里的?入包含了多????像  
    end  
    
    for l = 2 : n   %  for each layer
        if strcmp(net.layers{l}.type, 'c')
            %  !!below can probably be handled by insane matrix operations
            for j = 1 : net.layers{l}.outputmaps   %  for each output map　
                z = zeros(size(net.layers{l - 1}.a{1}) - [net.layers{l}.kernelsize - 1 net.layers{l}.kernelsize - 1 0]);
                for i = 1 : inputmaps   %  for each input map
                    %  convolve with corresponding kernel and add to temp output map
                    % z為該層K核卷積所有前一層影像所得
                    z = z + convn(net.layers{l - 1}.a{i}, net.layers{l}.k{i}{j}, 'valid');
                end
                %  add bias, pass through nonlinearity
                net.layers{l}.a{j} = relu(z + net.layers{l}.b{j});
            end 
            %  set number of input maps to this layers number of outputmaps
            inputmaps = net.layers{l}.outputmaps;
        elseif strcmp(net.layers{l}.type, 's')
            %  downsample
            for j = 1 : inputmaps
                z = convn(net.layers{l - 1}.a{j}, ones(net.layers{l}.scale) / (net.layers{l}.scale ^ 2), 'valid');   %  !! replace with variable
                net.layers{l}.a{j} = z(1 : net.layers{l}.scale : end, 1 : net.layers{l}.scale : end, :);
            end
            
%             
%             
%         elseif strcmp(net.layers{l}.type, 'f1')  
%         net.layers{l-1}.fv = [];  
%         for j = 1 : numel(net.layers{l-1}.a) % 最后一?的特征map的??  
%             sa = size(net.layers{l-1}.a{j}); % 第j?特征map的大小  
%             % ?所有的特征map拉成一?列向量。?有一?就是??的?本索引。每??本一列，每列???的特征向量  
%             net.layers{l-1}.fv = [net.layers{l-1}.fv; reshape(net.layers{l-1}.a{j}, sa(1) * sa(2), sa(3))];  
%         end
%         net.layers{l}.a = relu(net.layers{l-1}.ffW * net.layers{l-1}.fv + repmat(net.layers{l-1}.ffb, 1, size(net.layers{l-1}.fv, 2)));
%         elseif strcmp(net.layers{l}.type, 'f')  
%             net.layers{l}.a = relu(net.layers{l-1}.ffW * net.layers{l-1}.a+repmat(net.layers{l-1}.ffb, 1, size(net.layers{l-1}.a, 2)));  
%             
%         elseif strcmp(net.layers{l}.type, 'o')  
%             net.layers{l}.a = relu(net.layers{l-1}.ffW * net.layers{l-1}.a+repmat(net.layers{l-1}.ffb, 1, size(net.layers{l-1}.a, 2)));  
            
            
    end  
    end

    %  concatenate all end layer feature maps into vector
    net.fv = [];
    for j = 1 : numel(net.layers{n}.a) %最後一層的輸出總數
        sa = size(net.layers{n}.a{j});%輸出的矩正大小 sa1*sa2
        net.fv = [net.fv; reshape(net.layers{n}.a{j}, sa(1) * sa(2), sa(3))];%拉直
    end
    %  feedforward into output perceptrons
    net.o = relu(net.ffW * net.fv + repmat(net.ffb, 1, size(net.fv, 2)));
    % 'ffW' is the weights between the last layer and the output neurons. Note that the last layer is fully connected to the output layer, that's why the size of the weights is (onum * fvnum)
    % 'fv'
    % 'ffb' is the biases of the output neurons.
    

end
