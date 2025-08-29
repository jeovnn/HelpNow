object DataModule2: TDataModule2
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=C:\Users\jeova\Bancos\WELPNOW.FDB'
      'DriverID=FB')
    Left = 128
    Top = 64
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 120
    Top = 176
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 352
    Top = 64
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 248
    Top = 64
  end
end
