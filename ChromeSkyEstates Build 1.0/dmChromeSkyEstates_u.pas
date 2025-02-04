unit dmChromeSkyEstates_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TdmCSE = class(TDataModule)
    conCSE: TADOConnection;
    tblLogin: TADOTable;
    dscLogin: TDataSource;
    tblAgents: TADOTable;
    dscAgents: TDataSource;
    tblClients: TADOTable;
    dscClients: TDataSource;
    tblProperties: TADOTable;
    dscProperties: TDataSource;
    qryClients: TADOQuery;
    dscClientQRY: TDataSource;
    qryProperties: TADOQuery;
    dscPropertyQRY: TDataSource;
    qryAgents: TADOQuery;
    dscAgentsQRY: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCSE: TdmCSE;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
