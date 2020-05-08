% RemoveSubplotWhiteArea: 去除subplot周围的空白部分
% RemoveSubplotWhiteArea(gca, sub_row, sub_col, current_row, current_col)
% 输入
% gca		  :axes句柄
% sub_row     :subplot的行数
% sub_col     :subplot的列数
% current_row :当前列数
% current_col :当前行数
%
% 注意:使用如下语句,print保存图片的时候使其按照设置来保存,否则修改无效
% set(gcf, 'PaperPositionMode', 'auto');

% author : songxf
% time   : 2020-03-06
% email  : 

function [] = RemoveSubplotWhiteArea(gca, sub_row, sub_col, current_row, current_col)
% 设置OuterPosition
sub_axes_x = current_col*1/sub_col - 1/sub_col;
sub_axes_y = 1-current_row*1/sub_row; % y是从上往下
sub_axes_w = 1/sub_col;
sub_axes_h = 1/sub_row;
set(gca, 'OuterPosition', [sub_axes_x, sub_axes_y, sub_axes_w, sub_axes_h]); % 重设OuterPosition

% TightInset的位置
inset_vectior = get(gca, 'TightInset');
inset_x = inset_vectior(1);
inset_y = inset_vectior(2);
inset_w = inset_vectior(3);
inset_h = inset_vectior(4);

% OuterPosition的位置
outer_vector = get(gca, 'OuterPosition');
pos_new_x = outer_vector(1) + inset_x+0.01; % 将Position的原点移到到TightInset的原点
pos_new_y = outer_vector(2) + inset_y+0.01;
pos_new_w = outer_vector(3) - inset_w - inset_x-0.02; % 重设Position的宽
pos_new_h = outer_vector(4) - inset_h - inset_y-0.02; % 重设Position的高

% 重设Position
set(gca, 'Position', [pos_new_x, pos_new_y, pos_new_w, pos_new_h]);
