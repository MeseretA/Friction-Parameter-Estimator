function WithFric = ReadRDforPerformance(filename, startRow, endRow)
%IMPORTFILE �ؽ�Ʈ ������ ������ �����͸� ��ķ� �����ɴϴ�.
%   WITHFRIC = IMPORTFILE(FILENAME) ����Ʈ ���� �׸��� �ؽ�Ʈ ���� FILENAME���� �����͸� �н��ϴ�.
%
%   WITHFRIC = IMPORTFILE(FILENAME, STARTROW, ENDROW) �ؽ�Ʈ ���� FILENAME��
%   STARTROW �࿡�� ENDROW ����� �����͸� �н��ϴ�.
%
% Example:
%   WithFric = importfile('WithFric.csv', 1, 49999);
%
%    TEXTSCAN�� �����Ͻʽÿ�.

% MATLAB���� ���� ��¥�� �ڵ� ������: 2019/05/10 05:59:22

%% ������ �ʱ�ȭ�մϴ�.
delimiter = ',';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% �� �ؽ�Ʈ ������ ����:
%   ��1: double (%f)
%	��2: double (%f)
%   ��3: double (%f)
%	��4: double (%f)
%   ��5: double (%f)
%	��6: double (%f)
%   ��7: double (%f)
%	��8: double (%f)
%   ��9: double (%f)
%	��10: double (%f)
%   ��11: double (%f)
%	��12: double (%f)
%   ��13: double (%f)
%	��14: double (%f)
%   ��15: double (%f)
%	��16: double (%f)
%   ��17: double (%f)
%	��18: double (%f)
%   ��19: double (%f)
%	��20: double (%f)
%   ��21: double (%f)
%	��22: double (%f)
%   ��23: double (%f)
%	��24: double (%f)
%   ��25: double (%f)
%	��26: double (%f)
%   ��27: double (%f)
%	��28: double (%f)
%   ��29: double (%f)
%	��30: double (%f)
%   ��31: double (%f)
%	��32: double (%f)
%   ��33: double (%f)
%	��34: double (%f)
%   ��35: double (%f)
%	��36: double (%f)
%   ��37: double (%f)
%	��38: double (%f)
%   ��39: double (%f)
%	��40: double (%f)
%   ��41: double (%f)
%	��42: double (%f)
%   ��43: double (%f)
%	��44: double (%f)
%   ��45: double (%f)
%	��46: double (%f)
%   ��47: double (%f)
%	��48: double (%f)
%   ��49: double (%f)
%	��50: double (%f)
%   ��51: double (%f)
%	��52: double (%f)
%   ��53: double (%f)
%	��54: double (%f)
%   ��55: double (%f)
%	��56: double (%f)
%   ��57: double (%f)
%	��58: double (%f)
%   ��59: double (%f)
%	��60: double (%f)
%   ��61: double (%f)
%	��62: double (%f)
%   ��63: double (%f)
%	��64: double (%f)
%   ��65: double (%f)
%	��66: double (%f)
%   ��67: double (%f)
%	��68: double (%f)
%   ��69: double (%f)
%	��70: double (%f)
%   ��71: double (%f)
%	��72: double (%f)
%   ��73: double (%f)
%	��74: double (%f)
%   ��75: double (%f)
%	��76: double (%f)
%   ��77: double (%f)
%	��78: double (%f)
%   ��79: double (%f)
%	��80: double (%f)
%   ��81: double (%f)
%	��82: double (%f)
%   ��83: double (%f)
%	��84: double (%f)
%   ��85: double (%f)
%	��86: double (%f)
%   ��87: double (%f)
%	��88: double (%f)
%   ��89: double (%f)
%	��90: double (%f)
%   ��91: double (%f)
%	��92: double (%f)
%   ��93: double (%f)
%	��94: double (%f)
%   ��95: double (%f)
%	��96: double (%f)
%   ��97: double (%f)
% �ڼ��� ������ ���� �������� TEXTSCAN�� �����Ͻʽÿ�.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% �ؽ�Ʈ ������ ���ϴ�.
fileID = fopen(filename,'r');

%% ���Ŀ� ���� ������ ���� �н��ϴ�.
% �� ȣ���� �� �ڵ带 �����ϴ� �� ���Ǵ� ������ ����ü�� ������� �մϴ�. �ٸ� ���Ͽ� ���� ������ �߻��ϴ� ��� �������� ������
% �ڵ带 �ٽ� �����Ͻʽÿ�.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% �ؽ�Ʈ ������ �ݽ��ϴ�.
fclose(fileID);

%% ������ �� ���� �����Ϳ� ���� ���� ó�� ���Դϴ�.
% �������� �������� ������ �� ���� �����Ϳ� ��Ģ�� ������� �ʾ����Ƿ� ���� ó�� �ڵ尡 ���Ե��� �ʾҽ��ϴ�. ������ �� ����
% �����Ϳ� ����� �ڵ带 �����Ϸ��� ���Ͽ��� ������ �� ���� ���� �����ϰ� ��ũ��Ʈ�� �ٽ� �����Ͻʽÿ�.

%% ��� ���� �����
WithFric = [dataArray{1:end-1}];
