unit AgentDashboard_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dmChromeSkyEstates_u, Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, AgentClients_u, AgentProperty_u,
  Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.Imaging.GIFImg, Vcl.Buttons;

type
  TfrmAgentDashboard = class(TForm)
    lblAgentName: TLabel;
    Label2: TLabel;
    lblAgentRace: TLabel;
    Label3: TLabel;
    lblAgentGender: TLabel;
    Label5: TLabel;
    lblAgentAge: TLabel;
    pnlClose: TPanel;
    pnlLogout: TPanel;
    pnlClients: TPanel;
    pnlAgentInfo: TPanel;
    pnlProperty: TPanel;
    dbgClientsQRY: TDBGrid;
    dbgPropertyQRY: TDBGrid;
    pnlPpf: TPanel;
    pnlStatusBar: TPanel;
    pnlClientGrid: TPanel;
    pnlPropertyGrid: TPanel;
    lblClock: TLabel;
    lblDate: TLabel;
    tClock: TTimer;
    imgProfilePicture: TImage;
    spdLogout: TSpeedButton;
    spdClose: TSpeedButton;
    spdClients: TSpeedButton;
    spdProperties: TSpeedButton;
    lblAgentDashboard: TLabel;
    pnlAgentID: TPanel;
    lblAgentID: TLabel;
    Image1: TImage;
    pbLevelbar: TProgressBar;
    lblCurrentLevel: TLabel;
    lblNextLevel: TLabel;
    lblCurrentTier: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure RoundCornerof(Component: Twincontrol);
    procedure tClockTimer(Sender: TObject);
    procedure spdLogoutClick(Sender: TObject);
    procedure spdCloseClick(Sender: TObject);
    procedure spdPropertiesClick(Sender: TObject);
    procedure spdClientsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    { Property Variables }
    sPropertyID, sPropertyName, sClientID, sPropertyLocation: string;
    iRoomAmount: Integer;

    { Client Variables }
    rAmountPaid: real;

    { Agent Variables }
    sAgent_ID: string;
    iProgressBarLvl: Integer;
  end;

var
  frmAgentDashboard: TfrmAgentDashboard;

implementation

uses
  ChromeSkyEstates_u;

{$R *.dfm}

procedure TfrmAgentDashboard.FormActivate(Sender: TObject);
var
  sAgent_ID: string;

begin
  lblAgentName.Caption := frmLoginScreen.oAgentInfo.getFullName;
  // Recieves information from Login screen and displays the corresponding information.
  lblAgentGender.Caption := frmLoginScreen.sGender;
  lblAgentAge.Caption := INtToStr(frmLoginScreen.iAge);
  lblAgentRace.Caption := frmLoginScreen.sRace;
  sAgent_ID := frmLoginScreen.sAgent_ID;
  lblCurrentTier.Caption := frmLoginScreen.oAgentInfo.DetermineTier
    (frmLoginScreen.iCurrent_Level);
  lblCurrentLevel.Caption := INtToStr(frmLoginScreen.iCurrent_Level);
  // Current Level of User
  lblNextLevel.Caption := INtToStr(frmLoginScreen.iCurrent_Level + 1);
  iProgressBarLvl := frmLoginScreen.iCurrent_Level div 2;
  pbLevelbar.Position := iProgressBarLvl;
  RoundCornerof(pnlClients);
  RoundCornerof(pnlLogout);
  RoundCornerof(pnlAgentInfo);
  RoundCornerof(pnlProperty);
  RoundCornerof(pnlClose);
  RoundCornerof(pnlClientGrid);
  RoundCornerof(pnlPropertyGrid);
  RoundCornerof(pnlAgentID);
  lblAgentID.Caption := frmLoginScreen.sAgent_ID;
  sAgent_ID := frmLoginScreen.sAgent_ID;

  with dmCSE do // Creates a query for tblClients.
  begin
    qryClients.Close;
    qryClients.SQL.Clear;
    qryClients.SQL.Add('Select * FROM tblClients WHERE Assigned_Agent= "' +
      sAgent_ID + '"');
    qryClients.Open;

    rAmountPaid := qryClients['AmountPaid'];

  end;

  (imgProfilePicture.Picture.Graphic as TGIFImage).Animate := True;
  (imgProfilePicture.Picture.Graphic as TGIFImage).AnimationSpeed := 50;
  frmAgentDashboard.DoubleBuffered := True;

  TNumericField(dbgClientsQRY.DataSource.Dataset.FieldbyName('AmountPaid'))
  // Sets the format currency fields.
    .DisplayFormat := 'R,##0.00';
  // Code provided by experts-exchange.com to format Amount field.
  dbgClientsQRY.Columns[0].Width := 70; // Adjusts the column width of table.
  dbgClientsQRY.Columns[1].Width := 80;
  dbgClientsQRY.Columns[2].Width := 80;
  dbgClientsQRY.Columns[3].Width := 70;
  dbgClientsQRY.Columns[4].Width := 80;
  dbgClientsQRY.Columns[5].Width := 100;
  dbgClientsQRY.Columns[6].Width := 100;
  dbgClientsQRY.Columns[7].Width := 90;

  with dmCSE do // Creats a query for tblProperties.
  begin
    qryProperties.Close;
    qryProperties.SQL.Clear;
    qryProperties.SQL.Add('Select * FROM tblProperties WHERE Assigned_Agent= "'
      + sAgent_ID + '"');
    qryProperties.Open;

    sPropertyID := qryProperties['Property_ID'];
    sPropertyName := qryProperties['Property_Name'];
    sPropertyLocation := qryProperties['Property_Location'];
    sClientID := qryProperties['Client_ID'];
    iRoomAmount := qryProperties['Room_Amount'];

  end;
  dbgPropertyQRY.Columns[0].Width := 70; // Adjusts the column width of table.
  dbgPropertyQRY.Columns[1].Width := 80;
  dbgPropertyQRY.Columns[2].Width := 80;
  dbgPropertyQRY.Columns[3].Width := 70;
  dbgPropertyQRY.Columns[4].Width := 80;

end;

procedure TfrmAgentDashboard.FormCreate(Sender: TObject);
begin
  dbgClientsQRY.DrawingStyle := gdsThemed;
  dbgClientsQRY.Columns[0].Title.Color := clRed;
end;

procedure TfrmAgentDashboard.RoundCornerof(Component: Twincontrol);
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

procedure TfrmAgentDashboard.spdClientsClick(Sender: TObject);
begin
  frmClients_u.Show;
  frmAgentDashboard.Close;
  Writeln(frmLoginScreen.tLogFile, 'Opened Client Management at: ' +
    TimeToStr(Now)); // Updates log
end;

procedure TfrmAgentDashboard.spdCloseClick(Sender: TObject);
begin
  frmLoginScreen.Close;
  frmAgentDashboard.Close;
  CloseFile(frmLoginScreen.tLogFile);
end;

procedure TfrmAgentDashboard.spdLogoutClick(Sender: TObject);
begin
  frmLoginScreen.Show;
  frmAgentDashboard.Close;
  Writeln(frmLoginScreen.tLogFile, 'Logged out at: ' + TimeToStr(Now));// Updates log
  CloseFile(frmLoginScreen.tLogFile);
end;

procedure TfrmAgentDashboard.spdPropertiesClick(Sender: TObject);
begin
  frmAgentDashboard.Close;
  frmAgentProperty.Show;
  Append(frmLoginScreen.tLogFile);
  Writeln(frmLoginScreen.tLogFile, 'Opened Property Management at: ' +
    TimeToStr(Now)); // Updates log
end;

procedure TfrmAgentDashboard.tClockTimer(Sender: TObject);
begin
  lblClock.Caption := TimeToStr(Time); // Current Time.
  lblDate.Caption := DateToStr(Date); // Current Date.
end;

end.
