unit AdminManagement_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, dmChromeSkyEstates_u, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.DBCtrls, Vcl.Imaging.pngimage;

type
  TFrmAdminManagement = class(TForm)
    pnlAgents: TPanel;
    pnlClients: TPanel;
    dbgAgents: TDBGrid;
    pnlClose: TPanel;
    spdClose: TSpeedButton;
    dbgProperties: TDBGrid;
    pnlControls: TPanel;
    pnlNavBar: TPanel;
    lblSearch: TLabel;
    edtSearch: TEdit;
    pnlSearch: TPanel;
    SpeedButton1: TSpeedButton;
    pnlSortAlphabeticallyASC: TPanel;
    pnlSortAlphabeticallyDESC: TPanel;
    spdSortAlpheticallyASC: TSpeedButton;
    spdSortAlphabeticallyDESC: TSpeedButton;
    pnlControlFirst: TPanel;
    pnlControlPrior: TPanel;
    pnlControlNext: TPanel;
    pnlControlLast: TPanel;
    spdControlFirst: TSpeedButton;
    spdControlPrior: TSpeedButton;
    spdControlNext: TSpeedButton;
    spdControlLast: TSpeedButton;
    pnlControls2: TPanel;
    pnlControlFirst2: TPanel;
    spdControlFirst2: TSpeedButton;
    pnlControlPrior2: TPanel;
    spdControlPrior2: TSpeedButton;
    pnlControlNext2: TPanel;
    spdControlNext2: TSpeedButton;
    pnlControlLast2: TPanel;
    spdControlLast2: TSpeedButton;
    pnlSearch1: TPanel;
    pnlFilter: TPanel;
    lblRoomAmount: TLabel;
    spnRoomAmount: TSpinEdit;
    lblClientID: TLabel;
    edtClientID: TEdit;
    tClock: TTimer;
    lblClock: TLabel;
    lblHeader: TLabel;
    pnlAddUser: TPanel;
    pnlEditUser: TPanel;
    pnlDeleteUser: TPanel;
    spdAddUser: TSpeedButton;
    spdEditUser: TSpeedButton;
    spdDeleteAgent: TSpeedButton;
    pnlInfo: TPanel;
    dbAgentID: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    lblAgentID: TLabel;
    lblFirstName: TLabel;
    lblLastName: TLabel;
    lblAge: TLabel;
    lblGender: TLabel;
    lblRace: TLabel;
    lblSalesRecord: TLabel;
    edtAgentID: TEdit;
    edtFirstName: TEdit;
    edtLastName: TEdit;
    edtAge: TEdit;
    edtGender: TEdit;
    edtRace: TEdit;
    edtSalesRecord: TEdit;
    pnlAdd: TPanel;
    spdAddAgent2: TSpeedButton;
    pnlDeleteUser2: TPanel;
    spdDeleteUser2: TSpeedButton;
    Image1: TImage;
    pnlBack: TPanel;
    spdBack: TSpeedButton;
    lblAgentDB: TLabel;
    lblPropertiesDB: TLabel;
    procedure spdCloseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure spdSortAlpheticallyASCClick(Sender: TObject);
    procedure spdSortAlphabeticallyDESCClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure spdControlFirstClick(Sender: TObject);
    procedure spdControlPriorClick(Sender: TObject);
    procedure spdControlNextClick(Sender: TObject);
    procedure spdControlLastClick(Sender: TObject);
    procedure spdControlFirst2Click(Sender: TObject);
    procedure spdControlPrior2Click(Sender: TObject);
    procedure spdControlNext2Click(Sender: TObject);
    procedure spdControlLast2Click(Sender: TObject);
    procedure tClockTimer(Sender: TObject);
    procedure spdAddUserClick(Sender: TObject);
    procedure spdAddAgent2Click(Sender: TObject);
    procedure spdEditUserClick(Sender: TObject);
    procedure spdDeleteAgentClick(Sender: TObject);
    procedure spdDeleteUser2Click(Sender: TObject);
    procedure spdBackClick(Sender: TObject);
    procedure edtSearchClick(Sender: TObject);
    procedure edtClientIDClick(Sender: TObject);
    procedure RoundCornerof(Component: Twincontrol);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAdminManagement: TFrmAdminManagement;

implementation

uses
  ChromeSkyEstates_u, AdminDashboard_u;

{$R *.dfm}

procedure TFrmAdminManagement.edtClientIDClick(Sender: TObject);
begin
  edtClientID.Text := '';
end;

procedure TFrmAdminManagement.edtSearchClick(Sender: TObject);
begin
  edtSearch.Text := '';
end;

procedure TFrmAdminManagement.FormActivate(Sender: TObject);
begin
  with dmCSE do // Creates query for tblAgents and tblProperties.
  begin
    qryAgents.Close;
    qryAgents.SQL.Clear;
    qryAgents.SQL.Add('SELECT * FROM tblAgents');
    qryAgents.Open;

    qryProperties.Close;
    qryProperties.SQL.Clear;
    qryProperties.SQL.Add('SELECT * FROM tblProperties');
    qryProperties.Open;
  end;

  dbgProperties.Columns[0].Width := 70; // Adjusts width of dbgProperties.
  dbgProperties.Columns[1].Width := 115;
  dbgProperties.Columns[2].Width := 85;
  dbgProperties.Columns[3].Width := 79;
  dbgProperties.Columns[4].Width := 100;
  dbgProperties.Columns[5].Width := 75;

  dbgAgents.Columns[0].Width := 70; // Adjusts width of dbgAgents
  dbgAgents.Columns[1].Width := 80;
  dbgAgents.Columns[2].Width := 80;
  dbgAgents.Columns[3].Width := 70;
  dbgAgents.Columns[4].Width := 80;
  dbgAgents.Columns[5].Width := 100;
  dbgAgents.Columns[6].Width := 90;

  spnRoomAmount.MinValue := 3;
  spnRoomAmount.MaxValue := 10;

  RoundCornerof(pnlNavBar);
   RoundCornerof(pnlAgents);
    RoundCornerof(pnlClients);
     RoundCornerof(pnlNavBar);
      RoundCornerof(pnlControls);
      RoundCornerof(pnlControlFirst);
      RoundCornerof(pnlControlPrior);
      RoundCornerof(pnlControlNext);
      RoundCornerof(pnlControlLast);
      RoundCornerof(pnlControls2);
      RoundCornerof(pnlControlFirst2);
      RoundCornerof(pnlControlNext2);
      RoundCornerof(pnlControlPrior2);
      RoundCornerof(pnlControlLast2);

end;

procedure TFrmAdminManagement.RoundCornerof(Component: Twincontrol);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Component do
  // Rounds the edges of components (Not my code,copied from StackOverflow)
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 20, 20);
    Perform(EM_GETRECT, 0, lParam(@R));
    InflateRect(R, -4, -4);
    Perform(EM_SETRECTNP, 0, lParam(@R));
    SetWindowRgn(Handle, Rgn, True);
    Invalidate;
  end;

end;

procedure TFrmAdminManagement.spdAddAgent2Click(Sender: TObject);
var
  sAgentID, sFirstName, sLastName, sGender, sRace: string;
  iAge, iSalesRecord: integer;
begin
  sAgentID := edtAgentID.Text;
  sFirstName := edtFirstName.Text;
  sLastName := edtLastName.Text;
  sGender := edtGender.Text;
  sRace := edtRace.Text;
  iAge := StrToInt(edtAge.Text);
  iSalesRecord := StrToInt(edtSalesRecord.Text);
  if (spdAddAgent2.Caption = 'Add') then
  begin
    with dmCSE do // Algorithm to add an Agent.
    begin
      tblAgents.First;
      while not tblAgents.Eof do
      begin
        if sAgentID = tblAgents['Agent_ID'] then
        begin
          ShowMessage('Agent ID already exists');
          exit;
        end
        else
          tblAgents.Next;
      end;
      if iAge >= 18 then
      begin
        tblAgents.Insert;
        tblAgents['Agent_ID'] := sAgentID;
        tblAgents['First_Name'] := sFirstName;
        tblAgents['Last_Name'] := sLastName;
        tblAgents['Gender'] := sGender;
        tblAgents['Race'] := sRace;
        tblAgents['Age'] := iAge;
        tblAgents['Sales_Record'] := iSalesRecord;
        tblAgents.Post;
      end
      else
        ShowMessage('Agent must be over the age of 18');

    end;
  end
  else if (spdAddAgent2.Caption = 'Edit') then
  begin
    with dmCSE do
    begin
      if (tblAgents.Locate('Agent_ID', sAgentID, []) = True) AND (iAge >= 18)
      then
      begin
        tblAgents.Edit;
        tblAgents['Agent_ID'] := sAgentID;
        tblAgents['First_Name'] := sFirstName;
        tblAgents['Last_Name'] := sLastName;
        tblAgents['Gender'] := sGender;
        tblAgents['Race'] := sRace;
        tblAgents['Age'] := iAge;
        tblAgents['Sales_Record'] := iSalesRecord;
        tblAgents.Post;
      end
      else
      begin
        ShowMessage('Record not found.')
      end;

    end;
  end;

  with dmCSE do // Recreates qeury with new Agent added.
  begin
    qryAgents.Close;
    qryAgents.SQL.Clear;
    qryAgents.SQL.Add('SELECT * FROM tblAgents WHERE Agent_ID="' +
      sAgentID + '"');
    qryAgents.Open;
  end;

end;

procedure TFrmAdminManagement.spdAddUserClick(Sender: TObject);
begin
  edtAgentID.Visible := True;
  edtFirstName.Visible := True;
  edtLastName.Visible := True;
  edtAge.Visible := True;
  edtGender.Visible := True;
  edtRace.Visible := True;
  edtSalesRecord.Visible := True;
  spdAddAgent2.Caption := 'Add';
  pnlAdd.Visible := True;
end;

procedure TFrmAdminManagement.spdBackClick(Sender: TObject);
begin
  FrmAdminManagement.Close;
  frmAdminDashboard.Show;
end;

procedure TFrmAdminManagement.spdCloseClick(Sender: TObject);
begin
  frmLoginScreen.Close;
  FrmAdminManagement.Close;
end;

procedure TFrmAdminManagement.spdControlFirst2Click(Sender: TObject);
begin
  dmCSE.qryProperties.First;
end;

procedure TFrmAdminManagement.spdControlFirstClick(Sender: TObject);
begin
  dmCSE.qryAgents.First;
  // Control dbgAgents and loads information into a panel.
  with dmCSE do
  begin
    edtAgentID.Text := qryAgents['Agent_ID'];
    edtFirstName.Text := qryAgents['First_Name'];
    edtLastName.Text := qryAgents['Last_Name'];
    edtAge.Text := qryAgents['Age'];
    edtGender.Text := qryAgents['Gender'];
    edtRace.Text := qryAgents['Race'];
    edtSalesRecord.Text := qryAgents['Sales_Record'];
  end;
end;

procedure TFrmAdminManagement.spdControlLast2Click(Sender: TObject);
begin
  dmCSE.qryProperties.Last;
end;

procedure TFrmAdminManagement.spdControlLastClick(Sender: TObject);
begin
  dmCSE.qryAgents.Last; // Control dbgAgents and loads information into a panel.
  with dmCSE do
  begin
    edtAgentID.Text := qryAgents['Agent_ID'];
    edtFirstName.Text := qryAgents['First_Name'];
    edtLastName.Text := qryAgents['Last_Name'];
    edtAge.Text := qryAgents['Age'];
    edtGender.Text := qryAgents['Gender'];
    edtRace.Text := qryAgents['Race'];
    edtSalesRecord.Text := qryAgents['Sales_Record'];
  end;
end;

procedure TFrmAdminManagement.spdControlNext2Click(Sender: TObject);
begin
  dmCSE.qryProperties.Next;
end;

procedure TFrmAdminManagement.spdControlNextClick(Sender: TObject);
begin
  dmCSE.qryAgents.Next; // Control dbgAgents and loads information into a panel.
  with dmCSE do
  begin
    edtAgentID.Text := qryAgents['Agent_ID'];
    edtFirstName.Text := qryAgents['First_Name'];
    edtLastName.Text := qryAgents['Last_Name'];
    edtAge.Text := qryAgents['Age'];
    edtGender.Text := qryAgents['Gender'];
    edtRace.Text := qryAgents['Race'];
    edtSalesRecord.Text := qryAgents['Sales_Record'];
  end;

end;

procedure TFrmAdminManagement.spdControlPrior2Click(Sender: TObject);
begin
  dmCSE.qryProperties.prior;
end;

procedure TFrmAdminManagement.spdControlPriorClick(Sender: TObject);
begin
  dmCSE.qryAgents.prior;
  // Control dbgAgents and loads information into a panel.
  with dmCSE do
  begin
    edtAgentID.Text := qryAgents['Agent_ID'];
    edtFirstName.Text := qryAgents['First_Name'];
    edtLastName.Text := qryAgents['Last_Name'];
    edtAge.Text := qryAgents['Age'];
    edtGender.Text := qryAgents['Gender'];
    edtRace.Text := qryAgents['Race'];
    edtSalesRecord.Text := qryAgents['Sales_Record'];
  end;
end;

procedure TFrmAdminManagement.spdDeleteUser2Click(Sender: TObject);
var
  sAgentID: string;
begin
  edtAgentID.Visible := false;
  edtFirstName.Visible := false;
  edtLastName.Visible := false;
  edtAge.Visible := false;
  edtGender.Visible := false;
  edtRace.Visible := false;
  edtSalesRecord.Visible := false;
  pnlAdd.Visible := false;
  sAgentID := dbAgentID.Caption;
  with dmCSE do
  begin
    if qryAgents.Locate('Agent_ID', sAgentID, []) = True then
    begin
      qryAgents.Delete;
      ShowMessage('Record Deleted');
    end
    else
    begin
      ShowMessage('Record not found.')
    end;

  end;
end;

procedure TFrmAdminManagement.spdDeleteAgentClick(Sender: TObject);
begin
  pnlDeleteUser2.Visible := True;
end;

procedure TFrmAdminManagement.spdEditUserClick(Sender: TObject);
begin
  edtAgentID.Visible := True;
  edtFirstName.Visible := True;
  edtLastName.Visible := True;
  edtAge.Visible := True;
  edtGender.Visible := True;
  edtRace.Visible := True;
  edtSalesRecord.Visible := True;
  pnlAdd.Visible := True;

  spdAddAgent2.Caption := 'Edit';
  with dmCSE do
  begin
    edtAgentID.Text := qryAgents['Agent_ID'];
    edtFirstName.Text := qryAgents['First_Name'];
    edtLastName.Text := qryAgents['Last_Name'];
    edtAge.Text := qryAgents['Age'];
    edtGender.Text := qryAgents['Gender'];
    edtRace.Text := qryAgents['Race'];
    edtSalesRecord.Text := qryAgents['Sales_Record'];
  end;
end;

procedure TFrmAdminManagement.spdSortAlphabeticallyDESCClick(Sender: TObject);
begin
  with dmCSE do // Sorts dbGrids in descending order.
  begin
    qryAgents.Sort := ('Agent_ID DESC');
    qryProperties.Sort := ('Assigned_Agent DESC')

  end;
end;

procedure TFrmAdminManagement.spdSortAlpheticallyASCClick(Sender: TObject);
begin
  with dmCSE do // Sorts dbGrids in acsending order.
  begin
    qryAgents.Sort := ('Agent_ID ASC');
    qryProperties.Sort := ('Assigned_Agent ASC')

  end;
end;

procedure TFrmAdminManagement.SpeedButton1Click(Sender: TObject);
var
  iRoomAmount: integer;
  sAgentID, sClientID: string;
begin
  iRoomAmount := spnRoomAmount.Value;
  // Searches for Agent, aswell as filters dbGrid based on the room amount and/or ClientID.
  sAgentID := edtSearch.Text;
  sClientID := edtClientID.Text;
  if (sAgentID = '') or (sAgentID = 'Enter Agent ID') then
  begin
    ShowMessage('Please enter an Agent Identification Number');
    exit;
  end;
  if (iRoomAmount < 3) and (edtClientID.Text = 'Enter Client ID') then
  begin
    with dmCSE do
    begin
      qryAgents.Close;
      qryAgents.SQL.Clear;
      qryAgents.SQL.Add('SELECT * FROM tblAgents WHERE Agent_ID="' +
        sAgentID + '"');
      qryAgents.Open;

      qryProperties.Close;
      qryProperties.SQL.Clear;
      qryProperties.SQL.Add('SELECT * FROM tblProperties WHERE Assigned_Agent="'
        + sAgentID + '"');
      qryProperties.Open;
    end;
  end
  else if (iRoomAmount >= 3) and (sClientID = 'Enter Client ID') then
  begin
    with dmCSE do
    begin
      qryAgents.Close;
      qryAgents.SQL.Clear;
      qryAgents.SQL.Add('SELECT * FROM tblAgents WHERE Agent_ID="' +
        sAgentID + '"');
      qryAgents.Open;

      qryProperties.Close;
      qryProperties.SQL.Clear;
      qryProperties.SQL.Add('SELECT * FROM tblProperties WHERE Assigned_Agent="'
        + sAgentID + '" AND Room_Amount=' + IntToStr(iRoomAmount) + '');
      qryProperties.Open;
    end;
  end
  else if (iRoomAmount >= 3) and (sClientID <> 'Enter Client ID') then
  begin
    with dmCSE do
    begin
      qryAgents.Close;
      qryAgents.SQL.Clear;
      qryAgents.SQL.Add('SELECT * FROM tblAgents WHERE Agent_ID="' +
        sAgentID + '"');
      qryAgents.Open;

      qryProperties.Close;
      qryProperties.SQL.Clear;
      qryProperties.SQL.Add('SELECT * FROM tblProperties WHERE Assigned_Agent="'
        + sAgentID + '" AND Client_ID="' + sClientID + '"');
      qryProperties.Open;
    end;

  end
  else
  begin
    with dmCSE do
    begin
      qryAgents.Close;
      qryAgents.SQL.Clear;
      qryAgents.SQL.Add('SELECT * FROM tblAgents');
      qryAgents.Open;

      qryProperties.Close;
      qryProperties.SQL.Clear;
      qryProperties.SQL.Add('SELECT * FROM tblProperties');
      qryProperties.Open;
    end;
  end;

  dbgProperties.Columns[0].Width := 70;
  dbgProperties.Columns[1].Width := 115;
  dbgProperties.Columns[2].Width := 85;
  dbgProperties.Columns[3].Width := 79;
  dbgProperties.Columns[4].Width := 100;
  dbgProperties.Columns[5].Width := 75;

  dbgAgents.Columns[0].Width := 70;
  dbgAgents.Columns[1].Width := 80;
  dbgAgents.Columns[2].Width := 80;
  dbgAgents.Columns[3].Width := 70;
  dbgAgents.Columns[4].Width := 80;
  dbgAgents.Columns[5].Width := 100;
  dbgAgents.Columns[6].Width := 90;

end;

procedure TFrmAdminManagement.tClockTimer(Sender: TObject);
begin
  lblClock.Caption := TimeToStr(Time); // Current Time.
end;

end.
