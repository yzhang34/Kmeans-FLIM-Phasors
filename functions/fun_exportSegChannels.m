function [] = fun_exportSegChannels(handles)
%FUN_EXPORTSEGCHANNELS Summary of this function goes here
%   This function is used to display segmented channels
%
%   Author: Yide Zhang
%   Email: yzhang34@nd.edu
%   Date: May 22, 2019
%   Copyright: University of Notre Dame, 2019

if isfield(handles, 'Clusteridx') && isfield(handles, 'xyzgood')
    
    
 
    [filename, filepath] = uiputfile({'*.tif'},'Export the image to 32-bit (RGB) tif files.','clustered_segment');

    if filename~=0
        
        I_stack = handles.imageI;
        xyz_good = handles.xyzgood; 
        Cluster_idx = handles.Clusteridx; 
        [~, ~, n_z] = size(I_stack);
        K = str2double(get(handles.Edit_K, 'String'));
        cc = fun_HSVcolors(K, 1);

        if get(handles.Check_AutoI, 'Value')
            Imin = min(I_stack(:));
            Imax = max(I_stack(:));
        else
            Imin = str2double(get(handles.Edit_Imin, 'String'));
            Imax = str2double(get(handles.Edit_Imax, 'String'));
        end

        % convert to gray scale
        I_stack = mat2gray(I_stack,[Imin Imax]);
        disp_stack = zeros(size(I_stack,1), size(I_stack,2), 3, n_z);    
        for i_z = 1:n_z  
            % empty pixels being intensity pixels
    %         disp_stack(:,:,:,i_z) = repmat(I_stack(:,:,i_z),[1 1 3]);
            % empty pixels being white pixels
            disp_stack(:,:,:,i_z) = ones(size(I_stack,1), size(I_stack,2), 3);
        end
        temp_stack = disp_stack;

        hue_max = 0.7;
        hue_min = 0;
        K_hue = linspace(hue_max, hue_min, K)'; % scale of hue


        for iK = 1:K
            if size(xyz_good, 1) >= K
                x_iK = xyz_good(Cluster_idx==iK,1);
                y_iK = xyz_good(Cluster_idx==iK,2);
                z_iK = xyz_good(Cluster_idx==iK,3);
            else
                x_iK = 1;
                y_iK = 1;
                z_iK = 1;
            end
            n_good = numel(x_iK);
            I_good = zeros(n_good, 1);
            for i_good = 1:n_good
                I_good(i_good) = I_stack(x_iK(i_good), y_iK(i_good), z_iK(i_good));
            end
            map_hue = K_hue(iK) * ones(n_good,1);
            map_saturation = ones(n_good,1);
            map_value = I_good;
            cc_I = hsv2rgb([map_hue map_saturation map_value]);
            for i_good = 1:n_good
                % pixel with HSV
                disp_stack(x_iK(i_good), y_iK(i_good), :, z_iK(i_good)) = cc_I(i_good, :);
                % pixel with pure color
%                 disp_stack(x_iK(i_good), y_iK(i_good), :, z_iK(i_good)) = cc(iK, :);
                % pixel with raw intensity gray-scale
%                 disp_stack(x_iK(i_good), y_iK(i_good), :, z_iK(i_good)) = I_stack(x_iK(i_good), y_iK(i_good), :, z_iK(i_good));
            end
            
            cluster_filename = [filename(1:end-4), num2str(iK), '.tif'];
            fun_exportColorTIF(disp_stack, [filepath cluster_filename]);
            disp_stack = temp_stack;

        end
    end
   
  
else
    msgbox('Please calculate clusters first.', 'Error','error');
end


end