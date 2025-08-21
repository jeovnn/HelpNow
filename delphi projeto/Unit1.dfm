object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=C:\Users\jeova\Bancos\WELPNOW.FDB'
      'DriverID=FB')
    Left = 88
    Top = 96
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 192
    Top = 96
  end
  object DataSource1: TDataSource
    Left = 288
    Top = 96
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 88
    Top = 168
  end
end
