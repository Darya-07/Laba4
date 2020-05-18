unit UChart;

interface

type
  TInfo = record   //���������� � ����������
    CntCompare: Integer;    //���������� ���������
    CntMove: Integer;       //���������� �����������
  end;

  //�� �������� ����� ������� ���������� ���������� � ����������
  function CulcSort(N: Integer): TInfo;

implementation



//������� ����� ��������� � �����������
function CulcSort(N: integer): TInfo;
var
  mas: array of Integer;
  i, tmp: integer;
  firstIndex, lastIndex: integer;
  k: integer;     //������ ��������� ������������
begin
  SetLength(mas,N);
  for i:= 0 to N-1 do  //������� � ��������� ������ ���������� ����������
    mas[i]:=  Random(100);

  with Result do
    begin
      CntCompare:= 0;    //���������
      CntMove:= 0;    //�����������
      firstIndex:= 1;    //������ ������� �������� ������� ���� �������
      lastIndex:= N;     //������ ���������� �������� ������� ���� �������
      repeat

        k:= firstIndex;
        //������ ����� ������� (������ ����)
        for i:= firstIndex to lastIndex-1 do
          begin
            Inc(CntCompare); //����������� ������� ���������
            if mas[i] > mas[i+1] then
              begin
                k:= i; //����������� ������ ���������� ��������������� ��������

                Inc(CntMove); //����������� ������� ������������

                //����� ���������
                tmp:= mas[i];
                mas[i]:= mas[i+1];
                mas[i+1]:= tmp;
              end;
          end;

        lastIndex:= k;   //��������� ��������������� �������  (�� ����� ��������� ������������)

        //������ ������ ������ (����� �����)
        for i:= lastIndex downto firstIndex+1 do
          begin
            Inc(CntCompare); //����������� ������� ���������
            if mas[i] < mas[i-1] then
              begin
                k:= i; //����������� ������ ���������� ��������������� ��������

                Inc(CntMove); //����������� ������� ������������

                //����� ���������
                tmp:= mas[i];
                mas[i]:= mas[i-1];
                mas[i-1]:= tmp;
              end;
          end;

        firstIndex:= k;   //��������� ��������������� �������  (�� ����� ��������� ������������)

      until (firstIndex >= lastIndex);
    end;
end;

end.
