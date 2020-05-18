unit USort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, TeEngine, Series, TeeProcs, Chart,
  ComCtrls;

const
  N = 13;   //количество элементов в демонстрационном массиве для сортировки
  ssleep = 800;   //задержка в мс
  tab = '       '; //отступ

type
  TIndex = 1..N;    //тип-индексы массива
  TElem = Integer;  //тип-элемент массива
  TMas = array[TIndex] of TElem;   //тип-массив

  procedure RandomFill(var mas: TMas);  //заполнение массива случайными числами
  function ToString(mas: TMas): string;    //возвращат массив в виде строки
  procedure ShakerSort(var mas: TMas; var lb: TListBox); //сортировка шелла с выводом процесса на listbox

implementation

//заполнение массива случайными числами (в диапазоне 1-99)
procedure RandomFill(var mas: TMas);
var
  i: Integer;
begin
  Randomize;
  for i:= 1 to N do
    mas[i]:= 1 + Random(99);
end;

//возвращат массив в виде строки
function ToString(mas: TMas): string;
var
  i: Integer;
begin
  Result:= '';
  for i:= 1 to N do
    Result:= Result + IntToStr(mas[i]) + ' ';
end;

//сдвигает i-ю строку на lb на отступ tab
procedure Move(var lb: TListBox; i: Integer);
var
  s: string;
begin
  s:= tab + Trim(lb.Items[i-1]);
  lb.Items[i-1]:= s;
end;

//удаляет отступ i-й строки на lb
procedure MoveBack(var lb: TListBox; i: Integer);
var
  s: string;
begin
  s:= Trim(lb.Items[i-1]);
  lb.Items[i-1]:= s;
end;

//меняет местами i-ю и j-ю строки на lb
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
  k: integer;     //индекс последней перестановки
begin
  firstIndex:= 1;    //индекс первого элемента рабочей зоны массива
  lastIndex:= N;     //индекс последнего элемента рабочей зоны массива
  repeat

    //действия с listbox
    Move(lb,firstIndex);
    Application.ProcessMessages;

    k:= firstIndex;
    //проход слева направо (сверху вниз)
    for i:= firstIndex to lastIndex-1 do
      begin

        //действия с listbox
        Move(lb,i+1);
        Application.ProcessMessages;   //чтобы на listbox применились изменения
        sleep(ssleep);

        if mas[i] > mas[i+1] then
          begin
            k:= i; //присваиваем индекс последнего переставленного элемента

            //обмен элементов
            tmp:= mas[i];
            mas[i]:= mas[i+1];
            mas[i+1]:= tmp;

            //действия с listbox
            Swap(lb,i,i+1);
            Application.ProcessMessages;
            sleep(ssleep);

          end;

        //действия с listbox
        MoveBack(lb,i);
        Application.ProcessMessages;

      end;

    //действия с listbox
    MoveBack(lb,lastIndex);
    Application.ProcessMessages;
    sleep(ssleep);

    lastIndex:= k;   //уменьшаем просматриваемую область  (до места последней перестановки)

    //действия с listbox
    Move(lb,lastIndex);
    Application.ProcessMessages;

    //проход справа налево (снизу вверх)
    for i:= lastIndex downto firstIndex+1 do
      begin

        //действия с listbox
        Move(lb,i-1);
        Application.ProcessMessages;
        sleep(ssleep);

        if mas[i] < mas[i-1] then
          begin
            k:= i; //присваиваем индекс последнего переставленного элемента

            //обмен элементов
            tmp:= mas[i];
            mas[i]:= mas[i-1];
            mas[i-1]:= tmp;

            //действия с listbox
            Swap(lb,i,i-1);
            Application.ProcessMessages;
            sleep(ssleep);

          end;

        //действия с listbox
        MoveBack(lb,i);
        Application.ProcessMessages;

      end;

    //действия с listbox
    MoveBack(lb,firstIndex);
    Application.ProcessMessages;
    sleep(ssleep);

    firstIndex:= k;   //уменьшаем просматриваемую область  (до места последней перестановки)

  until (firstIndex >= lastIndex);
end;

end.
