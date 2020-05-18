unit UChart;

interface

type
  TInfo = record   //информация о сортировке
    CntCompare: Integer;    //количество сравнений
    CntMove: Integer;       //количество перемещений
  end;

  //по заданной длине массива возвращает информацию о сортировке
  function CulcSort(N: Integer): TInfo;

implementation



//считает число сравнений и перемещений
function CulcSort(N: integer): TInfo;
var
  mas: array of Integer;
  i, tmp: integer;
  firstIndex, lastIndex: integer;
  k: integer;     //индекс последней перестановки
begin
  SetLength(mas,N);
  for i:= 0 to N-1 do  //создаем и заполняем массив случайными значениями
    mas[i]:=  Random(100);

  with Result do
    begin
      CntCompare:= 0;    //сравнения
      CntMove:= 0;    //перемещения
      firstIndex:= 1;    //индекс первого элемента рабочей зоны массива
      lastIndex:= N;     //индекс последнего элемента рабочей зоны массива
      repeat

        k:= firstIndex;
        //проход слева направо (сверху вниз)
        for i:= firstIndex to lastIndex-1 do
          begin
            Inc(CntCompare); //увеличиваем счетчик сравнений
            if mas[i] > mas[i+1] then
              begin
                k:= i; //присваиваем индекс последнего переставленного элемента

                Inc(CntMove); //увеличиваем счетчик перестановок

                //обмен элементов
                tmp:= mas[i];
                mas[i]:= mas[i+1];
                mas[i+1]:= tmp;
              end;
          end;

        lastIndex:= k;   //уменьшаем просматриваемую область  (до места последней перестановки)

        //проход справа налево (снизу вверх)
        for i:= lastIndex downto firstIndex+1 do
          begin
            Inc(CntCompare); //увеличиваем счетчик сравнений
            if mas[i] < mas[i-1] then
              begin
                k:= i; //присваиваем индекс последнего переставленного элемента

                Inc(CntMove); //увеличиваем счетчик перестановок

                //обмен элементов
                tmp:= mas[i];
                mas[i]:= mas[i-1];
                mas[i-1]:= tmp;
              end;
          end;

        firstIndex:= k;   //уменьшаем просматриваемую область  (до места последней перестановки)

      until (firstIndex >= lastIndex);
    end;
end;

end.
