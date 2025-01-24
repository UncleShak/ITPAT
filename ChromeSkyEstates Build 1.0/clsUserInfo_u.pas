unit clsUserInfo_u;

interface

type
  TUserInfo = class(TObject)
  private
    fUser_Code: string;
    fFirst_Name: string;
    fLast_Name: string;
    fAge: integer;
    fRace: string;
    fSalesRecord: integer;

  public
    constructor create(sUser_Code,sFirst_Name,sLast_Name,sRace: string; iSales_Record,iAge:integer );

    procedure setUserCode(sUser_Code: string);
    procedure setFirstName(sFirst_Name: string);
    procedure setLastName(sLast_Name: string);
    procedure setAge(iAge: string);
    procedure setRace(sRace: string);
    procedure setSalesRecord(iSalesRecord: integer);

    function getFullName:string;
  end;

implementation

{ TUserInfo }

{ TUserInfo }

constructor TUserInfo.create(sUser_Code, sFirst_Name, sLast_Name, sRace: string;
  iSales_Record,iAge: integer);
begin
  fAge := iAge;
  fFirst_Name := sFirst_Name;
  fLast_Name := sLast_Name;
  fRace := sRace;
  fSalesRecord := iSales_Record;
  fUser_Code := sUser_Code;
end;

function TUserInfo.getFullName: string;
begin
result := fFirst_Name+''+fLast_Name;
end;

{procedure TUserInfo.setAge(iAge: string);
begin
  fAge := iAge;
end;

procedure TUserInfo.setFirstName(sFirst_Name: string);
begin
  fFirst_Name := sFirst_Name;
end;

procedure TUserInfo.setLastName(sLast_Name: string);
begin
  fLast_Name := sLast_Name;
end;

procedure TUserInfo.setRace(sRace: string);
begin
  fRace := sRace;
end;

procedure TUserInfo.setSalesRecord(iSalesRecord: integer);
begin
  fSalesRecord := iSalesRecord;
end;

procedure TUserInfo.setUserCode(sUser_Code: string);
begin
  fUser_Code := sUser_Code;
end;   }

end.
