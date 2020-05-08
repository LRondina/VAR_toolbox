% RemoveSubplotWhiteArea: 去除Plot画的图的空白部分
% RemovePlotWhiteArea(gca)
% 输入
% gca: axes句柄

% author : songxf
% time   : 2020-03-06
% email  : 

function [] = RemovePlotWhiteArea(gca)
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
