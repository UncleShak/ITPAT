unit AdminDashboard_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Imaging.GIFImg, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons, dmChromeSkyEstates_u, AdminManagement_u,
  ShellAPI;

type
  TfrmAdminDashboard = class(TForm)
    pnlAdminInfo: TPanel;
    pnlAdminUser: TPanel;
    pnlAdminImage: TPanel;
    imgProfilePicture: TImage;
    pnlAgentPreview: TPanel;
    pnlPropertyPreview: TPanel;
    pnlStats: TPanel;
    lblFullName: TLabel;
    lblTopPerformers: TLabel;
    pnlTop1: TPanel;
    pnlTop2: TPanel;
    pnlTop3: TPanel;
    lblHighListers: TLabel;
    pnlHighLstOne: TPanel;
    pnlHighLstTwo: TPanel;
    pnlHighLstThree: TPanel;
    pnlClose: TPanel;
    pnlLogout: TPanel;
    spdClose: TSpeedButton;
    spdLogout: TSpeedButton;
    pnlDBView: TPanel;
    lblClock: TLabel;
    tClock: TTimer;
    lblDate: TLabel;
    pnlStatusBar: TPanel;
    lblFullName1: TLabel;
    pnlTopScore1: TPanel;
    lblFullName2: TLabel;
    pnlTopScore2: TPanel;
    lblFullName3: TLabel;
    pnlTopScore3: TPanel;
    lblPropertyName1: TLabel;
    pnlPropertyListing1: TPanel;
    lblPropertyName2: TLabel;
    pnlPropertyListing2: TPanel;
    lblPropertyName3: TLabel;
    pnlPropertyListing3: TPanel;
    spdDBView: TSpeedButton;
    pnlLog: TPanel;
    spdOpenLogFiles: TSpeedButton;
    pnlAverageSales: TPanel;
    pnlTotalAgents: TPanel;
    pnlTotalProperties: TPanel;
    lblAverageSales: TLabel;
    lblTotalAgents: TLabel;
    lblTotalProperties: TLabel;
    lblAverageSales2: TLabel;
    lblTotalAgents2: TLabel;
    lblTotalProperties2: TLabel;
    lblAgentID: TLabel;
    Image1: TImage;
    procedure RoundCornerof(Component: Twincontrol);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pnlCloseClick(Sender: TObject);
    procedure spdCloseClick(Sender: TObject);
    procedure tClockTimer(Sender: TObject);
    procedure spdDBViewClick(Sender: TObject);
    procedure spdOpenLogFilesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdminDashboard: TfrmAdminDashboard;
  arrPropertyCode: array [1 .. 99] of string;
  arrPropertyListings: array [1 .. 99] of real;

implementation

uses
  ChromeSkyEstates_u;

{$R *.dfm}
{ TfrmAdminDashboard }

procedure TfrmAdminDashboard.FormActivate(Sender: TObject);
var
  i, j, iNumProperties, iNumAgents, iTotalSales: integer;
  rTemp, rAverageSales: real;
  sTemp: String;
begin
  iNumProperties := 0;
  iNumAgents := 0;
  lblFullName.Caption := frmLoginScreen.sFull_Name; //Recieves Full Name from Login Screen.
  with dmCSE do
  begin
    tblAgents.Sort := ('Sales_Record DESC');
    tblAgents.First;                                //Sorts dbGrid[Agents] in descending order.
    lblFullName1.Caption := tblAgents['First_Name'] + ' ' + tblAgents
      ['Last_Name'];
    pnlTopScore1.Caption := tblAgents['Sales_Record'];
    tblAgents.Next;
    lblFullName2.Caption := tblAgents['First_Name'] + ' ' + tblAgents
      ['Last_Name'];
    pnlTopScore2.Caption := tblAgents['Sales_Record'];
    tblAgents.Next;
    lblFullName3.Caption := tblAgents['First_Name'] + ' ' + tblAgents
      ['Last_Name'];
    pnlTopScore3.Caption := tblAgents['Sales_Record'];
  end;

  (imgProfilePicture.Picture.Graphic as TGIFImage).Animate := True;   //Allows gif to move.
  (imgProfilePicture.Picture.Graphic as TGIFImage).AnimationSpeed := 50;
  frmAdminDashboard.DoubleBuffered := True;
  i := 0;
  j := 0;
  rTemp := 0;
  for i := 1 to High(arrPropertyListings) - 1 do  // Sorts Parallel Array(arrPropertyListings and arrPropertyCode) in Ascending order.
    for j := i + 1 to High(arrPropertyListings) do
      if arrPropertyListings[i] < arrPropertyListings[j] then
      begin
        rTemp := arrPropertyListings[j];
        sTemp := arrPropertyCode[j];

        arrPropertyListings[j] := arrPropertyListings[i];
        arrPropertyCode[j] := arrPropertyCode[i];

        arrPropertyListings[i] := rTemp;
        arrPropertyCode[i] := sTemp;
      end;
  lblPropertyName1.Caption := arrPropertyCode[1];                    //Recieves 1st,2nd and 3rd postion from array and displays them.
  pnlPropertyListing1.Caption := FloatToStrf(arrPropertyListings[1],
    ffCurrency, 8, 2);

  lblPropertyName2.Caption := arrPropertyCode[2];
  pnlPropertyListing2.Caption := FloatToStrf(arrPropertyListings[2],
    ffCurrency, 8, 2);

  lblPropertyName3.Caption := arrPropertyCode[3];
  pnlPropertyListing3.Caption := FloatToStrf(arrPropertyListings[3],
    ffCurrency, 8, 2);

  with dmCSE do
  begin
    tblProperties.First;          //Counts the amount of properties.
    while not tblProperties.Eof do
    begin
      Inc(iNumProperties, 1);
      tblProperties.Next;
    end;
    lblTotalProperties2.Caption := IntToStr(iNumProperties);

    tblAgents.First;
    while not tblAgents.Eof do  //Counts the amount of Agents.
    begin
      iTotalSales := iTotalSales + tblAgents['Sales_Record'];
      Inc(iNumAgents, 1);
      tblAgents.Next;
    end;
    rAverageSales := iTotalSales / iNumAgents;  //Calculates the average amount of sales.
    lblAverageSales2.Caption := FloatToStrf(rAverageSales, ffNumber, 8, 2);
    lblTotalAgents2.Caption := IntToStr(iNumAgents);

    RoundCornerof(pnlAdminInfo);
    RoundCornerof(pnlAdminUser);
    RoundCornerof(pnlAgentPreview);
    RoundCornerof(pnlAgentPreview);
    RoundCornerof(pnlDBView);
    RoundCornerof(pnlLog);
    RoundCornerof(pnlAverageSales);
    RoundCornerof(pnlTotalAgents);
    RoundCornerof(pnlTotalProperties);
    RoundCornerof(pnlTop1);
    RoundCornerof(pnlTop2);
    RoundCornerof(pnlTop3);
    RoundCornerof(pnlHighLstOne);
    RoundCornerof(pnlHighLstTwo);
    RoundCornerof(pnlHighLstThree);
  end;

end;

procedure TfrmAdminDashboard.FormCreate(Sender: TObject);
var
  tPropertyValues: textfile;
  sline: string;
  N, i: integer;

begin
  RoundCornerof(pnlAdminUser);        //Rounds the corner of panels
  RoundCornerof(pnlAdminInfo);
  RoundCornerof(pnlDBView);

  RoundCornerof(pnlAgentPreview);
  RoundCornerof(pnlTop1);
  RoundCornerof(pnlTopScore1);
  RoundCornerof(pnlTop2);
  RoundCornerof(pnlTopScore2);
  RoundCornerof(pnlTop3);
  RoundCornerof(pnlTopScore3);

  RoundCornerof(pnlPropertyPreview);
  RoundCornerof(pnlHighLstOne);
  RoundCornerof(pnlPropertyListing1);
  RoundCornerof(pnlHighLstTwo);
  RoundCornerof(pnlPropertyListing2);
  RoundCornerof(pnlHighLstThree);
  RoundCornerof(pnlPropertyListing3);

  RoundCornerof(pnlAverageSales);
  RoundCornerof(pnlTotalAgents);
  RoundCornerof(pnlTotalProperties);

  RoundCornerof(pnlAdminImage);
  RoundCornerof(pnlLog);
  RoundCornerof(pnlStats);

  if FileExists('PropertyListings.txt') = false then //Loads text file contents into arrays: arrPropertyCode and arrPropertyListing.
  begin
    showmessage('Error: File does not exists');
    exit;
  end;
  N := 0;
  AssignFile(tPropertyValues, 'PropertyListings.txt');
  reset(tPropertyValues);

  while not Eof(tPropertyValues) do
  begin
    Readln(tPropertyValues, sline);
    Inc(N, 1);
    arrPropertyCode[N] := copy(sline, 1, pos('#', sline) - 1);
    arrPropertyListings[N] := StrToFloat(copy(sline, pos('#', sline) + 1,
      length(sline)));

  end;
  CloseFile(tPropertyValues);
end;

procedure TfrmAdminDashboard.pnlCloseClick(Sender: TObject);
begin
  frmAdminDashboard.Close;
  frmLoginScreen.Close;
end;

procedure TfrmAdminDashboard.RoundCornerof(Component: Twincontrol);
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

procedure TfrmAdminDashboard.spdCloseClick(Sender: TObject);
begin
  frmAdminDashboard.Close;
  frmLoginScreen.Close;
end;

procedure TfrmAdminDashboard.spdDBViewClick(Sender: TObject);
begin
  frmAdminManagement.Show;
  frmAdminDashboard.Hide;
end;

procedure TfrmAdminDashboard.spdOpenLogFilesClick(Sender: TObject);
var
  FilePath: string;
begin
  FilePath := 'LogFiles\' + FormatDateTime('yyyy-mm-dd', date) + '.txt';//Opens Text file from delphi, code does not belong to me.
  ShellExecute(0, 'open', PChar(FilePath), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmAdminDashboard.tClockTimer(Sender: TObject);
begin
  lblClock.Caption := TimeToStr(Time);
  lblDate.Caption := DateToStr(date);
end;

end.
