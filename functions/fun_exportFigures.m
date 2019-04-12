function [] = fun_exportFigures(handles, figureName)
%FUN_EXPORTFIGURES Summary of this function goes here
%   Detailed explanation goes here
%
%   Author: Yide Zhang
%   Email: yzhang34@nd.edu
%   Date: April 12, 2019
%   Copyright: University of Notre Dame, 2019


switch figureName
    
    case 'G'
        if isfield(handles, 'imageG')
            image_stack = handles.imageG;
            [filename, filepath] = uiputfile({'*.tif'},'Export the image to 32-bit (single precision) tif files.','imageG');
            fullname = [filepath filename];
            if filename~=0
                fun_exportRealTIF(image_stack, fullname)
            end
        else
            msgbox('G image not exist.', 'Error','error');
        end
        
    case 'S'
        if isfield(handles, 'imageS')
            image_stack = handles.imageS;
            [filename, filepath] = uiputfile({'*.tif'},'Export the image to 32-bit (single precision) tif files.','imageS');
            fullname = [filepath filename];
            if filename~=0
                fun_exportRealTIF(image_stack, fullname)
            end
        else
            msgbox('S image not exist.', 'Error','error');
        end
        
    case 'I'
        if isfield(handles, 'imageI')
            image_stack = handles.imageI;
            [filename, filepath] = uiputfile({'*.tif'},'Export the image to 32-bit (single precision) tif files.','imageI');
            fullname = [filepath filename];
            if filename~=0
                fun_exportRealTIF(image_stack, fullname)
            end
        else
            msgbox('Intensity image not exist.', 'Error','error');
        end
        
    case 'L'
        if isfield(handles, 'imageL')
            L_stack = handles.imageL;
            if get(handles.Check_isLHSV, 'Value') && isfield(handles, 'RGB_Stack')
                RGB_Stack = handles.RGB_Stack;
                [filename, filepath] = uiputfile({'*.tif'},'Export the image to 32-bit (RGB) tif files.','imageLifetimeHSV');
                fullname = [filepath filename];
                if filename~=0
                    fun_exportColorTIF(RGB_Stack, fullname);
                end
            else
                [filename, filepath] = uiputfile({'*.tif'},'Export the image to 32-bit (single precision) tif files.','imageLifetime');
                fullname = [filepath filename];
                if filename~=0
                    fun_exportRealTIF(L_stack, fullname)
                end
            end
        else
            msgbox('Lifetime image not exist.', 'Error','error');
        end
        
    case 'PC'
        if isfield(handles, 'Clusteridx') && isfield(handles, 'ClusterC')
            fun_updateFigures(handles, -1, 'PC');
            PC_frame = getframe(handles.Axes_PC);
            [filename, filepath] = uiputfile({'*.tif'},'Export the image to 32-bit (RGB) tif files.','imagePhasorCluster');
            fullname = [filepath filename];
            if filename~=0
                fun_exportColorTIF(PC_frame.cdata, fullname);
            end
        else
            msgbox('Phasor Cluster image not exist.', 'Error','error');
        end
        
    case 'O'   
        if isfield(handles, 'imageI')
            if isfield(handles, 'imageO') && isfield(handles, 'imageOHSV')
                if get(handles.Check_isOHSV, 'Value')
                    OHSV_stack = handles.imageOHSV; 
                    [filename, filepath] = uiputfile({'*.tif'},'Export the image to 32-bit (RGB) tif files.','imageOverlapClusterHSV');
                    fullname = [filepath filename];
                    if filename~=0
                        fun_exportColorTIF(OHSV_stack, fullname);
                    end
                else
                    O_stack = handles.imageO;
                    [filename, filepath] = uiputfile({'*.tif'},'Export the image to 32-bit (RGB) tif files.','imageOverlapCluster');
                    fullname = [filepath filename];
                    if filename~=0
                        fun_exportColorTIF(O_stack, fullname)
                    end
                end
            end
        else
            msgbox('Overlap image not exist.', 'Error','error');
        end
        
        
    otherwise
        error('Unexpected figure name')

end

