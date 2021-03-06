unit USort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, TeEngine, Series, TeeProcs, Chart,
  ComCtrls;

const
  N = 13;   //���������� ��������� � ���������������� ������� ��� ����������
  ssleep = 800;   //�������� � ��
  tab = '       '; //������

type
  TIndex = 1..N;    //���-������� �������
  TElem = Integer;  //���-������� �������
  TMas = array[TIndex] of TElem;   //���-������

  procedure RandomFill(var mas: TMas);  //���������� ������� ���������� �������
  function ToString(mas: TMas): string;    //��������� ������ � ���� ������
  procedure ShakerSort(var mas: TMas; var lb: TListBox); //���������� ����� � ������� �������� �� listbox

implementation

//���������� ������� ���������� ������� (� ��������� 1-99)
procedure RandomFill(var mas: TMas);
var
  i: Integer;
begin
  Randomize;
  for i:= 1 to N do
    mas[i]:= 1 + Random(99);
end;

//��������� ������ � ���� ������
function ToString(mas: TMas): string;
var
  i: Integer;
begin
  Result:= '';
  for i:= 1 to N do
    Result:= Result + IntToStr(mas[i]) + ' ';
end;

//�������� i-� ������ �� lb �� ������ tab
procedure Move(var lb: TListBox; i: Integer);
var
  s: string;
begin
  s:= tab + Trim(lb.Items[i-1]);
  lb.Items[i-1]:= s;
end;

//������� ������ i-� ������ �� lb
procedure MoveBack(var lb: TListBox; i: Integer);
var
  s: string;
begin
  s:= Trim(lb.Items[i-1]);
  lb.Items[i-1]:= s;
end;

//������ ������� i-� � j-� ������ �� lb
procedure Swap(var lb: TListBox; i,j: Integer);
var
  s: string;
begin
  s:= lb.Items[i-1];
  lb.Items[i-1]:= lb.Items[j-1];
  lb.Items[j-1]:= s;
end;

procedure ShakerSort(var mas: TMas; var lb: TListBox);
var
  i, tmp: integer;
  firstIndex, lastIndex: integer;
  k: integer;     //������ ��������� ������������
begin
  firstIndex:= 1;    //������ ������� �������� ������� ���� �������
  lastIndex:= N;     //������ ���������� �������� ������� ���� �������
  repeat

    //�������� � listbox
    Move(lb,firstIndex);
    Application.ProcessMessages;

    k:= firstIndex;
    //������ ����� ������� (������ ����)
    for i:= firstIndex to lastIndex-1 do
      begin

        //�������� � listbox
        Move(lb,i+1);
        Application.ProcessMessages;   //����� �� listbox ����������� ���������
        sleep(ssleep);

        if mas[i] > mas[i+1] then
          begin
            k:= i; //����������� ������ ���������� ��������������� ��������

            //����� ���������
            tmp:= mas[i];
            mas[i]:= mas[i+1];
            mas[i+1]:= tmp;

            //�������� � listbox
            Swap(lb,i,i+1);
            Application.ProcessMessages;
            sleep(ssleep);

          end;

        //�������� � listbox
        MoveBack(lb,i);
        Application.ProcessMessages;

      end;

    //�������� � listbox
    MoveBack(lb,lastIndex);
    Application.ProcessMessages;
    sleep(ssleep);

    lastIndex:= k;   //��������� ��������������� �������  (�� ����� ��������� ������������)

    //�������� � listbox
    Move(lb,lastIndex);
    Application.ProcessMessages;

    //������ ������ ������ (����� �����)
    for i:= lastIndex downto firstIndex+1 do
      begin

        //�������� � listbox
        Move(lb,i-1);
        Application.ProcessMessages;
        sleep(ssleep);

        if mas[i] < mas[i-1] then
          begin
            k:= i; //����������� ������ ���������� ��������������� ��������

            //����� ���������
            tmp:= mas[i];
            mas[i]:= mas[i-1];
            mas[i-1]:= tmp;

            //�������� � listbox
            Swap(lb,i,i-1);
            Application.ProcessMessages;
            sleep(ssleep);

          end;

        //�������� � listbox
        MoveBack(lb,i);
        Application.ProcessMessages;

      end;

    //�������� � listbox
    MoveBack(lb,firstIndex);
    Application.ProcessMessages;
    sleep(ssleep);

    firstIndex:= k;   //��������� ��������������� �������  (�� ����� ��������� ������������)

  until (firstIndex >= lastIndex);
end;

end.
