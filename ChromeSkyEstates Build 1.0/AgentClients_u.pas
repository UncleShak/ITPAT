unit AgentClients_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dmChromeSkyEstates_u, Data.DB,
  Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.Imaging.pngimage;

type
  TfrmClients_u = class(TForm)
    pnlClose: TPanel;
    pnlBack: TPanel;
    lblClientID: TLabel;
    lblFullName: TLabel;
    lblAge: TLabel;
    lblRace: TLabel;
    lblStatus: TLabel;
    lblAmountDue: TLabel;
    lblPayment: TLabel;
    lblCurrentAmnt: TLabel;
    lblNewAmount: TLabel;
    edtAddAmount: TEdit;
    lblPropertyCode: TLabel;
    edtSearch: TEdit;
    lblSearch: TLabel;
    pnlAgentClientInfo: TPanel;
    SpeedButton1: TSpeedButton;
    pnlClientInfo: TPanel;
    pnlClientImage: TPanel;
    imgGender: TImage;
    pnlFinancialInfo: TPanel;
    pnlControl: TPanel;
    pnlControlFirst: TPanel;
    pnlControlPrevious: TPanel;
    pnlControlNext: TPanel;
    pnlControlLast: TPanel;
    spdControlFirst: TSpeedButton;
    spdControlLast: TSpeedButton;
    spdControlNext: TSpeedButton;
    spdControlPrior: TSpeedButton;
    lblPropertyCode1: TLabel;
    lblStatus1: TLabel;
    lblAmountDue1: TLabel;
    lblClientID1: TLabel;
    lblName1: TLabel;
    lblRace1: TLabel;
    lblAge1: TLabel;
    lblGender: TLabel;
    lblGender1: TLabel;
    lblCurrentAmount: TLabel;
    pnlPayments: TPanel;
    pnlAddPayment2: TPanel;
    spdAddPayment2: TSpeedButton;
    pnlAddNewClient: TPanel;
    lblNewClient: TLabel;
    lblClientID2: TLabel;
    lblFirstName: TLabel;
    lblLastName: TLabel;
    lblAge2: TLabel;
    lblGender2: TLabel;
    lblRace2: TLabel;
    pnlNewClient: TPanel;
    edtFirstName: TEdit;
    edtLastName: TEdit;
    edtAge: TEdit;
    edtGender: TEdit;
    edtRace: TEdit;
    spdAddClient: TSpeedButton;
    edtClientID: TEdit;
    pnlAdd1: TPanel;
    pnlDeleteClient: TPanel;
    spdAddClient2: TSpeedButton;
    spdDeleteClient: TSpeedButton;
    spdClose: TSpeedButton;
    spdBack: TSpeedButton;
    Image1: TImage;
    procedure RoundCornerof(Component: Twincontrol);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure spdControlNextClick(Sender: TObject);
    procedure spdControlLastClick(Sender: TObject);
    procedure spdControlPriorClick(Sender: TObject);
    procedure spdControlFirstClick(Sender: TObject);
    procedure spdAddClientClick(Sender: TObject);
    procedure spdAddClient2Click(Sender: TObject);
    procedure spdDeleteClientClick(Sender: TObject);
    procedure spdAddPayment2Click(Sender: TObject);
    procedure spdCloseClick(Sender: TObject);
    procedure spdBackClick(Sender: TObject);
    procedure edtAddAmountClick(Sender: TObject);
    procedure edtSearchClick(Sender: TObject);
  private
    { Private declarations }
    sClient_ID: string;
    rAmountPaid, rAmountDue, rListingPrice: real;
  public
    { Public declarations }
  end;

var
  frmClients_u: TfrmClients_u;
  arrPropertyCode: array [1 .. 99] of string;
  arrPropertyListings: array [1 .. 99] of real;

implementation

uses
  ChromeSkyEstates_u, AgentDashboard_u, AgentProperty_u;

{$R *.dfm}

procedure TfrmClients_u.edtAddAmountClick(Sender: TObject);
begin
  edtAddAmount.Text := ''; // Empties text field on click
end;

procedure TfrmClients_u.edtSearchClick(Sender: TObject);
begin
edtSearch.Text:='';
end;

procedure TfrmClients_u.FormActivate(Sender: TObject);
var
  sAgent_ID: string;
  N: integer;
begin
  sAgent_ID := frmLoginScreen.sAgent_ID;
  with dmCSE do // Creates Query for tblClients
  begin
    qryClients.Close;
    qryClients.SQL.Clear;
    qryClients.SQL.Add('Select * FROM tblClients WHERE Assigned_Agent= "' +
      sAgent_ID + '"');
    qryClients.Open;

    qryClients.Close; // Creates Query for tblAgent
    qryClients.SQL.Clear;
    qryClients.SQL.Add('Select * FROM tblClients WHERE Assigned_Agent= "' +
      sAgent_ID + '"');
    qryClients.Open;

    qryClients.First;
    lblClientID1.Caption := qryClients['Client_ID'];
    sClient_ID := qryClients['Client_ID'];
    lblName1.Caption := qryClients['First_Name'] + ' ' + qryClients
      ['Last_Name'];
    lblAge1.Caption := qryClients['Age'];

    if qryClients['Gender'] = 'Male' then
    // Loads a specific image based on gender.
    begin
      lblGender1.Caption := qryClients['Gender'];
      imgGender.Picture.LoadFromFile('Male0.png');
    end
    else if qryClients['Gender'] = 'Female' then
    begin
      lblGender1.Caption := qryClients['Gender'];
      imgGender.Picture.LoadFromFile('Female0.png');
    end;
    lblRace1.Caption := qryClients['Race'];
    N := 0;
    qryProperties.First;
    while N <= 99 do
    begin
      inc(N, 1);
      if qryProperties['Property_ID'] = arrPropertyCode[N] then
      // Code that determines the status of a property based on the amount already paid by client.
      begin
        rListingPrice := arrPropertyListings[N];
        if qryProperties['Client_ID'] = sClient_ID then
        begin
          lblPropertyCode1.Caption := qryProperties['Property_ID'];
          rAmountPaid := frmAgentDashboard.rAmountPaid;
          lblAmountDue1.Caption := floatToStrf(rAmountPaid, ffCurrency, 8, 2);
          if rAmountPaid = 0 then
          begin
            lblStatus1.Caption := 'Available';
          end
          else if rAmountPaid <= 130000 then
          begin
            lblStatus1.Caption := 'Processing';
          end
          else if rAmountPaid > 130000 then
          begin
            lblStatus1.Caption := 'Sold';
          end;
        end;
        rAmountDue := rListingPrice - rAmountPaid;
        if rAmountDue < 0 then
        begin
          lblAmountDue1.Caption := 'PAID';
        end
        Else
          lblAmountDue1.Caption := floatToStrf(rAmountDue, ffCurrency, 8, 2);
      end;

    end;
    lblCurrentAmount.Caption := floatToStrf(qryClients['AmountPaid'],
      ffCurrency, 8, 2);
  end;

  RoundCornerof(pnlClose);
  RoundCornerof(pnlBack);
  RoundCornerof(pnlClientInfo);
  RoundCornerof(pnlClientImage);
  RoundCornerof(pnlClientInfo);
  RoundCornerof(pnlAgentClientInfo);
  RoundCornerof(pnlControl);
  RoundCornerof(pnlFinancialInfo);
  RoundCornerof(pnlPayments);
  RoundCornerof(pnlAddNewClient);
  RoundCornerof(pnlControlPrevious);
  RoundCornerof(pnlControlFirst);
  RoundCornerof(pnlControlNext);
  RoundCornerof(pnlControlLast);
  RoundCornerof(pnlAddPayment2);
  RoundCornerof(pnlAddNewClient);
  RoundCornerof(pnlAdd1);
  RoundCornerof(pnlDeleteClient);
end;

procedure TfrmClients_u.FormCreate(Sender: TObject);
var
  tPropertyValues: textfile;
  sline: string;
  N, i: integer;

begin
  if FileExists('PropertyListings.txt') = false then
  // Loads text file contents into arrays: arrPropertyCode and arrPropertyListing.
  begin
    showmessage('Error: File does not exists');
    exit;
  end;
  N := 0;
  AssignFile(tPropertyValues, 'PropertyListings.txt');
  reset(tPropertyValues);

  while not eof(tPropertyValues) do
  begin
    Readln(tPropertyValues, sline);
    inc(N, 1);
    arrPropertyCode[N] := copy(sline, 1, pos('#', sline) - 1);
    arrPropertyListings[N] := StrToFloat(copy(sline, pos('#', sline) + 1,
      length(sline)));

  end;
  CloseFile(tPropertyValues);
end;

procedure TfrmClients_u.RoundCornerof(Component: Twincontrol);
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

procedure TfrmClients_u.spdAddClient2Click(Sender: TObject);
begin
  pnlAddNewClient.Visible := True;
  Image1.Visible := false;
end;

procedure TfrmClients_u.spdAddClientClick(Sender: TObject);
var
  sClientId, sFirstName, sLastName, sRace, sGender, sAssignedAgent: string;
  iAge: integer;
  rAmountPaid: real;
begin
  sClientId := edtClientID.Text;
  sFirstName := edtFirstName.Text;
  sLastName := edtLastName.Text;
  sRace := edtLastName.Text;
  sGender := edtGender.Text;
  iAge := StrToInt(edtAge.Text);
  rAmountPaid := 0;
  sAssignedAgent := frmAgentDashboard.sAgent_ID;
  with dmCSE do
  begin
    tblClients.First;
    while not tblClients.eof do
    begin
      if sClient_ID = tblClients['Client_ID'] then
      // Algorithm to add a client to tblClient.
      begin
        showmessage('Client ID already exists');
        exit;
      end
      else if iAge >= 20 then
      begin
        tblClients.Insert;
        tblClients['Client_ID'] := sClientId;
        tblClients['First_Name'] := sFirstName;
        tblClients['Last_Name'] := sLastName;
        tblClients['Age'] := iAge;
        tblClients['Gender'] := sGender;
        tblClients['Race'] := sRace;
        tblClients['Assigned_Agent'] := sAssignedAgent;
        tblClients['AmountPaid'] := rAmountPaid;
        tblClients.Post;
        frmAgentDashboard.iProgressBarLvl :=
          frmAgentDashboard.iProgressBarLvl + 10;
      end
      else
      begin
        showmessage('Client must be over the age of 20');
        exit;
      end;
    end;
  end;
  Writeln(frmLoginScreen.tLogFile, 'Added a Client at: ' + TimeToStr(Now));

end;

procedure TfrmClients_u.spdAddPayment2Click(Sender: TObject);
var
  rNewPayment, rCurrentAmount: real;
begin
  if edtAddAmount.Text = '' then
  begin
    showmessage('Please enter a value.');
    exit;
  end;
  rNewPayment := StrToFloat(edtAddAmount.Text);
  with dmCSE do
  begin
    rCurrentAmount := qryClients['AmountPaid'];
    rCurrentAmount := rCurrentAmount + rNewPayment;
    qryClients.edit;
    qryClients['AmountPaid'] := rCurrentAmount;
    qryClients.Post;
    lblCurrentAmount.Caption := floatToStrf(rCurrentAmount, ffCurrency, 8, 2)
  end;
  Writeln(frmLoginScreen.tLogFile, 'Updated a payment for Client ' + sClient_ID
    + ' at:' + TimeToStr(Now));
  frmAgentDashboard.iProgressBarLvl := frmAgentDashboard.iProgressBarLvl + 15;
end;

procedure TfrmClients_u.spdBackClick(Sender: TObject);
begin
  frmClients_u.Close;
  frmAgentDashboard.Show;
  CloseFile(frmLoginScreen.tLogFile);
end;

procedure TfrmClients_u.spdCloseClick(Sender: TObject);
begin
  frmClients_u.Close;
  frmAgentDashboard.Close;
  frmLoginScreen.Close;
end;

procedure TfrmClients_u.spdDeleteClientClick(Sender: TObject);
begin
  pnlAddNewClient.Visible := false;
  with dmCSE do // Deletes a client from database.
  begin
    if tblClients.Locate('Client_ID', sClient_ID, []) = True then
    begin
      tblClients.Delete;
      showmessage('Record Deleted');
    end
    else
    begin
      showmessage('Record not found.');
    end;
    Writeln(frmLoginScreen.tLogFile, 'Deleted a Client at: ' + TimeToStr(Now));
    // Updates log

  end;
end;

procedure TfrmClients_u.SpeedButton1Click(Sender: TObject);
var
  sSearch: String;
  bFound: boolean;

begin
  bFound := false;
  sSearch := edtSearch.Text;
  with dmCSE do
  begin
    qryClients.First;
    while not qryClients.eof do
    begin
      if qryClients['Client_ID'] = sSearch then // Creates query for tblClients
      begin
        lblName1.Caption := qryClients['First_Name'] + ' ' + qryClients
          ['Last_Name'];
        lblClientID1.Caption := qryClients['Client_ID'];
        lblAge1.Caption := IntToStr(qryClients['Age']);
        lblRace1.Caption := qryClients['Race'];

      end
      else if qryClients['First_Name'] = sSearch then
      begin
        lblName1.Caption := qryClients['First_Name'] + ' ' + qryClients
          ['Last_Name'];
        lblClientID1.Caption := qryClients['Client_ID'];
        lblAge1.Caption := IntToStr(qryClients['Age']);
        lblRace1.Caption := qryClients['Race'];
      end;
      qryClients.Next;
    end;

  end;

end;

procedure TfrmClients_u.spdControlFirstClick(Sender: TObject);
var
  N: integer;
begin
  with dmCSE do
  begin
    qryClients.First;
    lblClientID1.Caption := qryClients['Client_ID'];
    sClient_ID := qryClients['Client_ID'];
    lblName1.Caption := qryClients['First_Name'] + qryClients['Last_Name'];
    lblAge1.Caption := qryClients['Age'];

    if qryClients['Gender'] = 'Male' then
    begin
      lblGender1.Caption := qryClients['Gender'];
      imgGender.Picture.LoadFromFile('Male0.png');
    end
    else if qryClients['Gender'] = 'Female' then
    begin
      lblGender1.Caption := qryClients['Gender'];
      imgGender.Picture.LoadFromFile('Female0.png');
    end;
    lblRace1.Caption := qryClients['Race'];
    N := 0;
    qryProperties.First;
    while N <= 99 do
    begin
      inc(N, 1);
      if qryProperties['Property_ID'] = arrPropertyCode[N] then
      begin
        rListingPrice := arrPropertyListings[N];
        if qryProperties['Client_ID'] = sClient_ID then
        begin
          lblPropertyCode1.Caption := qryProperties['Property_ID'];
          rAmountPaid := frmAgentDashboard.rAmountPaid;
          lblAmountDue1.Caption := floatToStrf(rAmountPaid, ffCurrency, 8, 2);
          if rAmountPaid = 0 then
          begin
            lblStatus1.Caption := 'Available';
          end
          else if rAmountPaid <= 130000 then
          begin
            lblStatus1.Caption := 'Processing';
          end
          else if rAmountPaid > 130000 then
          begin
            lblStatus1.Caption := 'Sold';
          end;
        end;
        rAmountDue := rListingPrice - rAmountPaid;
        if rAmountDue < 0 then
        begin
          lblAmountDue1.Caption := 'PAID';
        end
        Else
          lblAmountDue1.Caption := floatToStrf(rAmountDue, ffCurrency, 8, 2);
      end;

    end;
    lblCurrentAmount.Caption := floatToStrf(qryClients['AmountPaid'],
      ffCurrency, 8, 2);
  end;
end;

procedure TfrmClients_u.spdControlLastClick(Sender: TObject);
var
  N: integer;
begin
  with dmCSE do
  begin
    qryClients.Last;
    lblClientID1.Caption := qryClients['Client_ID'];
    sClient_ID := qryClients['Client_ID'];
    lblName1.Caption := qryClients['First_Name'] + ' ' + qryClients
      ['Last_Name'];
    lblAge1.Caption := qryClients['Age'];

    if qryClients['Gender'] = 'Male' then
    begin
      lblGender1.Caption := qryClients['Gender'];
      imgGender.Picture.LoadFromFile('Male0.png');
    end
    else if qryClients['Gender'] = 'Female' then
    begin
      lblGender1.Caption := qryClients['Gender'];
      imgGender.Picture.LoadFromFile('Female0.png');
    end;
    lblRace1.Caption := qryClients['Race'];
    N := 0;
    qryProperties.Last;
    while N <= 99 do
    begin
      inc(N, 1);
      if qryProperties['Property_ID'] = arrPropertyCode[N] then
      begin
        rListingPrice := arrPropertyListings[N];
        if qryProperties['Client_ID'] = sClient_ID then
        begin
          lblPropertyCode1.Caption := qryProperties['Property_ID'];
          rAmountPaid := frmAgentDashboard.rAmountPaid;
          lblAmountDue1.Caption := floatToStrf(rAmountPaid, ffCurrency, 8, 2);
          if rAmountPaid = 0 then
          begin
            lblStatus1.Caption := 'Available';
          end
          else if rAmountPaid <= 130000 then
          begin
            lblStatus1.Caption := 'Processing';
          end
          else if rAmountPaid > 130000 then
          begin
            lblStatus1.Caption := 'Sold';
          end;
        end;
        rAmountDue := rListingPrice - rAmountPaid;
        if rAmountDue < 0 then
        begin
          lblAmountDue1.Caption := 'PAID';
        end
        Else
          lblAmountDue1.Caption := floatToStrf(rAmountDue, ffCurrency, 8, 2);
      end;

    end;
    lblCurrentAmount.Caption := floatToStrf(qryClients['AmountPaid'],
      ffCurrency, 8, 2);
  end;
end;

procedure TfrmClients_u.spdControlNextClick(Sender: TObject);
var
  N: integer;
begin
  with dmCSE do
  begin
    qryClients.Next;
    lblClientID1.Caption := qryClients['Client_ID'];
    sClient_ID := qryClients['Client_ID'];
    lblName1.Caption := qryClients['First_Name'] + ' ' + qryClients
      ['Last_Name'];
    lblAge1.Caption := qryClients['Age'];

    if qryClients['Gender'] = 'Male' then
    begin
      lblGender1.Caption := qryClients['Gender'];
      imgGender.Picture.LoadFromFile('Male0.png');
    end
    else if qryClients['Gender'] = 'Female' then
    begin
      lblGender1.Caption := qryClients['Gender'];
      imgGender.Picture.LoadFromFile('Female0.png');
    end;
    lblRace1.Caption := qryClients['Race'];
    N := 0;
    qryProperties.Next;
    while N <= 99 do
    begin
      inc(N, 1);
      if qryProperties['Property_ID'] = arrPropertyCode[N] then
      begin
        rListingPrice := arrPropertyListings[N];
        if qryProperties['Client_ID'] = sClient_ID then
        begin
          lblPropertyCode1.Caption := qryProperties['Property_ID'];
          rAmountPaid := frmAgentDashboard.rAmountPaid;
          lblAmountDue1.Caption := floatToStrf(rAmountPaid, ffCurrency, 8, 2);
          if rAmountPaid = 0 then
          begin
            lblStatus1.Caption := 'Available';
          end
          else if rAmountPaid <= 130000 then
          begin
            lblStatus1.Caption := 'Processing';
          end
          else if rAmountPaid > 130000 then
          begin
            lblStatus1.Caption := 'Sold';
          end;
        end;
        rAmountDue := rListingPrice - rAmountPaid;
        if rAmountDue < 0 then
        begin
          lblAmountDue1.Caption := 'PAID';
        end
        Else
          lblAmountDue1.Caption := floatToStrf(rAmountDue, ffCurrency, 8, 2);
      end;

    end;
    lblCurrentAmount.Caption := floatToStrf(qryClients['AmountPaid'],
      ffCurrency, 8, 2);
  end;
end;

procedure TfrmClients_u.spdControlPriorClick(Sender: TObject);
var
  N: integer;
begin
  with dmCSE do
  begin
    qryClients.Prior;
    lblClientID1.Caption := qryClients['Client_ID'];
    sClient_ID := qryClients['Client_ID'];
    lblName1.Caption := qryClients['First_Name'] + ' ' + qryClients
      ['Last_Name'];
    lblAge1.Caption := qryClients['Age'];

    if qryClients['Gender'] = 'Male' then
    begin
      lblGender1.Caption := qryClients['Gender'];
      imgGender.Picture.LoadFromFile('Male0.png');
    end
    else if qryClients['Gender'] = 'Female' then
    begin
      lblGender1.Caption := qryClients['Gender'];
      imgGender.Picture.LoadFromFile('Female0.png');
    end;
    lblRace1.Caption := qryClients['Race'];
    N := 0;
    qryProperties.Prior;
    while N <= 99 do
    begin
      inc(N, 1);
      if qryProperties['Property_ID'] = arrPropertyCode[N] then
      begin
        rListingPrice := arrPropertyListings[N];
        if qryProperties['Client_ID'] = sClient_ID then
        begin
          lblPropertyCode1.Caption := qryProperties['Property_ID'];
          rAmountPaid := frmAgentDashboard.rAmountPaid;
          lblAmountDue1.Caption := floatToStrf(rAmountPaid, ffCurrency, 8, 2);
          if rAmountPaid = 0 then
          begin
            lblStatus1.Caption := 'Available';
          end
          else if rAmountPaid <= 130000 then
          begin
            lblStatus1.Caption := 'Processing';
          end
          else if rAmountPaid > 130000 then
          begin
            lblStatus1.Caption := 'Sold';
          end;
        end;
        rAmountDue := rListingPrice - rAmountPaid;
        if rAmountDue < 0 then
        begin
          lblAmountDue1.Caption := 'PAID';
        end
        Else
          lblAmountDue1.Caption := floatToStrf(rAmountDue, ffCurrency, 8, 2);
      end;

    end;
    lblCurrentAmount.Caption := floatToStrf(qryClients['AmountPaid'],
      ffCurrency, 8, 2);
  end;
end;

end.
