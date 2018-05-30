object ImportDlg: TImportDlg
  Left = 0
  Top = 0
  Caption = 'Choose images to import'
  ClientHeight = 425
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object BitBtn1: TBitBtn
    Left = 248
    Top = 216
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 256
    Top = 224
    Width = 75
    Height = 25
    Caption = 'BitBtn2'
    TabOrder = 2
  end
  object ListView1: TListView
    Left = 8
    Top = 35
    Width = 211
    Height = 382
    Checkboxes = True
    Columns = <
      item
        Caption = 'Icon'
        MaxWidth = 50
        MinWidth = 50
      end
      item
        Caption = 'Name'
        MaxWidth = 150
        MinWidth = 150
        Width = 150
      end>
    DragMode = dmAutomatic
    MultiSelect = True
    OwnerDraw = True
    ReadOnly = True
    RowSelect = True
    ShowColumnHeaders = False
    TabOrder = 3
    ViewStyle = vsReport
  end
end
