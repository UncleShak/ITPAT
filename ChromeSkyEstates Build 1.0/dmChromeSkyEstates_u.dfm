object dmCSE: TdmCSE
  OldCreateOrder = False
  Height = 361
  Width = 478
  object conCSE: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\IT\Shakir Alexan' +
      'der IT PAT 2024\Phase 2\ChromeSkyEstates Build 1.0\Win32\Debug\C' +
      'hromeSkyEstates.mdb;Mode=ReadWrite;Persist Security Info=False;J' +
      'et OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB' +
      ':Database Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database' +
      ' Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Gl' +
      'obal Bulk Transactions=1;Jet OLEDB:New Database Password="";Jet ' +
      'OLEDB:Create System Database=False;Jet OLEDB:Encrypt Database=Fa' +
      'lse;Jet OLEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compa' +
      'ct Without Replica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 160
  end
  object tblLogin: TADOTable
    Active = True
    Connection = conCSE
    CursorType = ctStatic
    TableName = 'tblLogin'
    Left = 152
    Top = 40
  end
  object dscLogin: TDataSource
    DataSet = tblLogin
    Left = 224
    Top = 40
  end
  object tblAgents: TADOTable
    Active = True
    Connection = conCSE
    CursorType = ctStatic
    TableName = 'tblAgents'
    Left = 152
    Top = 120
  end
  object dscAgents: TDataSource
    DataSet = tblAgents
    Left = 288
    Top = 120
  end
  object tblClients: TADOTable
    Active = True
    Connection = conCSE
    CursorType = ctStatic
    TableName = 'tblClients'
    Left = 152
    Top = 200
  end
  object dscClients: TDataSource
    DataSet = tblClients
    Left = 288
    Top = 200
  end
  object tblProperties: TADOTable
    Active = True
    Connection = conCSE
    CursorType = ctStatic
    TableName = 'tblProperties'
    Left = 152
    Top = 280
  end
  object dscProperties: TDataSource
    DataSet = tblProperties
    Left = 296
    Top = 280
  end
  object qryClients: TADOQuery
    Connection = conCSE
    CursorType = ctStatic
    DataSource = dscClients
    Parameters = <>
    Left = 224
    Top = 200
  end
  object dscClientQRY: TDataSource
    DataSet = qryClients
    Left = 352
    Top = 200
  end
  object qryProperties: TADOQuery
    Connection = conCSE
    CursorType = ctStatic
    DataSource = dscProperties
    Parameters = <>
    Left = 224
    Top = 280
  end
  object dscPropertyQRY: TDataSource
    DataSet = qryProperties
    Left = 376
    Top = 280
  end
  object qryAgents: TADOQuery
    Connection = conCSE
    CursorType = ctStatic
    DataSource = dscAgents
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM tblAgents')
    Left = 224
    Top = 120
  end
  object dscAgentsQRY: TDataSource
    DataSet = qryAgents
    Left = 360
    Top = 120
  end
end
