object DataModule2: TDataModule2
  Height = 537
  Width = 728
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      
        'Database=C:\Users\emili\OneDrive\'#193'rea de Trabalho\HelpNow\WELPNO' +
        'W3.FDB'
      'DriverID=FB')
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
end
