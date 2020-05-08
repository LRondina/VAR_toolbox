% RemoveSubplotWhiteArea: ȥ��subplot��Χ�Ŀհײ���
% RemoveSubplotWhiteArea(gca, sub_row, sub_col, current_row, current_col)
% ����
% gca		  :axes���
% sub_row     :subplot������
% sub_col     :subplot������
% current_row :��ǰ����
% current_col :��ǰ����
%
% ע��:ʹ���������,print����ͼƬ��ʱ��ʹ�䰴������������,�����޸���Ч
% set(gcf, 'PaperPositionMode', 'auto');

% author : songxf
% time   : 2020-03-06
% email  : 

function [] = RemoveSubplotWhiteArea(gca, sub_row, sub_col, current_row, current_col)
% ����OuterPosition
sub_axes_x = current_col*1/sub_col - 1/sub_col;
sub_axes_y = 1-current_row*1/sub_row; % y�Ǵ�������
sub_axes_w = 1/sub_col;
sub_axes_h = 1/sub_row;
set(gca, 'OuterPosition', [sub_axes_x, sub_axes_y, sub_axes_w, sub_axes_h]); % ����OuterPosition

% TightInset��λ��
inset_vectior = get(gca, 'TightInset');
inset_x = inset_vectior(1);
inset_y = inset_vectior(2);
inset_w = inset_vectior(3);
inset_h = inset_vectior(4);

% OuterPosition��λ��
outer_vector = get(gca, 'OuterPosition');
pos_new_x = outer_vector(1) + inset_x+0.01; % ��Position��ԭ���Ƶ���TightInset��ԭ��
pos_new_y = outer_vector(2) + inset_y+0.01;
pos_new_w = outer_vector(3) - inset_w - inset_x-0.02; % ����Position�Ŀ�
pos_new_h = outer_vector(4) - inset_h - inset_y-0.02; % ����Position�ĸ�

% ����Position
set(gca, 'Position', [pos_new_x, pos_new_y, pos_new_w, pos_new_h]);
