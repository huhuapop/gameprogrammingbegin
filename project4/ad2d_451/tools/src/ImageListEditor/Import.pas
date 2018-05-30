unit Import;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons;

type
  TImportDlg = class(TForm)
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ListView1: TListView;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  ImportDlg: TImportDlg;

implementation

{$R *.dfm}

end.
