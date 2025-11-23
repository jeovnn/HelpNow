object DataModule2: TDataModule2
  Height = 537
  Width = 728
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=C:\Users\jeova\Bancos\WELPNOW3.FDB'
      'DriverID=FB')
    Connected = True
    Left = 128
    Top = 40
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 128
    Top = 120
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 352
    Top = 40
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 248
    Top = 40
  end
  object FDQueryConta: TFDQuery
    Connection = FDConnection1
    Left = 248
    Top = 320
  end
  object DataSource2: TDataSource
    DataSet = FDQueryConta
    Left = 328
    Top = 320
  end
  object FDQueryServicos: TFDQuery
    Connection = FDConnection1
    Left = 248
    Top = 384
  end
  object DataSourceServicos: TDataSource
    DataSet = FDQueryServicos
    Left = 328
    Top = 384
  end
  object FDQueryAvaliacoes: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      '')
    Left = 248
    Top = 448
  end
  object DataSourceAvaliacoes: TDataSource
    DataSet = FDQueryAvaliacoes
    Left = 328
    Top = 448
  end
end
