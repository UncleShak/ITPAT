unit AgentProperty_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, dmChromeSkyEstates_u, Vcl.StdCtrls, Vcl.Imaging.pngimage, math,
  Vcl.Buttons, Vcl.ComCtrls;

type
  TfrmAgentProperty = class(TForm)
    pnlPropertyInfo: TPanel;
    imgPropertyDisplay: TImage;
    pnlAgentID: TPanel;
    pnlRoomAmount: TPanel;
    pnlPropertyID: TPanel;
    pnlPropertyLocation: TPanel;
    pnlFinancialInfo: TPanel;
    pnlClose: TPanel;
    Panel7: TPanel;
    lblPropertyName: TLabel;
    lblPropertyID: TLabel;
    lblAgentID: TLabel;
    lblRoomAmount: TLabel;
    lblPropertyLocation: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    pnlLast: TPanel;
    pnlNext: TPanel;
    pnlPrevious: TPanel;
    pnlFirst: TPanel;
    lblPropertyID1: TLabel;
    lblAgentID1: TLabel;
    lblPropertyLocation1: TLabel;
    lblRoomAmount1: TLabel;
    pnlControls: TPanel;
    lblStatus: TLabel;
    lblAmountDue: TLabel;
    Panel1: TPanel;
    pnlListing: TPanel;
    lblPropertyInformation: TLabel;
    lblAmountPaid: TLabel;
    lblClientID: TLabel;
    lblListingPrice: TLabel;
    lblClientID1: TLabel;
    lblStatus1: TLabel;
    lblAmountPaid1: TLabel;
    lblAmountDue1: TLabel;
    pnlInstallmentCalculator: TPanel;
    pnlPropertyPrice: TPanel;
    pnlDuration: TPanel;
    pnlInterestRate: TPanel;
    lblInstallmentCalc: TLabel;
    edtPropertyListing: TEdit;
    edtDuration: TEdit;
    edtInterestRate: TEdit;
    pnlCalulate: TPanel;
    spdCalculate: TSpeedButton;
    pnlEMIInfo: TPanel;
    lblAmount: TLabel;
    lblTotalDuration: TLabel;
    lblInterestRate: TLabel;
    lblTotalInterest: TLabel;
    lblTotalAmount: TLabel;
    pnlEMI: TPanel;
    lblEMI: TLabel;
    lblAmount2: TLabel;
    lblDuration: TLabel;
    lblInterestRate2: TLabel;
    lblTotalInterest2: TLabel;
    lblTotalAmount2: TLabel;
    lblEmi2: TLabel;
    spdClose: TSpeedButton;
    pnlBack: TPanel;
    spdBack: TSpeedButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure RoundCornerof(Component: Twincontrol);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure tmMoveImageTimer(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure spdCalculateClick(Sender: TObject);
    procedure spdCloseClick(Sender: TObject);
    procedure spdBackClick(Sender: TObject);
    procedure edtPropertyListingClick(Sender: TObject);
    procedure edtDurationClick(Sender: TObject);
    procedure edtInterestRateClick(Sender: TObject);
  private
    { Private declarations }
    iPicRandom: integer;
    rAmountPaid, rAmountDue, rListingPrice: real;
  public
    { Public declarations }

  end;

var
  frmAgentProperty: TfrmAgentProperty;
  arrPropertyCode: array [1 .. 99] of string;
  arrPropertyListings: array [1 .. 99] of real;

implementation

uses
  ChromeSkyEstates_u, AgentDashboard_u;

{$R *.dfm}

procedure TfrmAgentProperty.Button1Click(Sender: TObject);
begin
  with dmCSE do
  begin
    qryProperties.Next;
  end;
end;

procedure TfrmAgentProperty.edtDurationClick(Sender: TObject);
begin
edtDuration.Text:='';
end;

procedure TfrmAgentProperty.edtInterestRateClick(Sender: TObject);
begin
edtInterestRate.Text:='';
end;

procedure TfrmAgentProperty.edtPropertyListingClick(Sender: TObject);
begin
edtPropertyListing.Text:='';
end;

procedure TfrmAgentProperty.FormActivate(Sender: TObject);
var
  sAgent_ID: string;
  sPropertyID: string;
  N: integer;
begin
  iPicRandom := RandomRange(0, 17);
  imgPropertyDisplay.Picture.LoadFromFile('House' + IntToStr(iPicRandom)
    + '.png');
  sAgent_ID := frmLoginScreen.sAgent_ID;
  with dmCSE do
  begin
    qryProperties.Close;
    qryProperties.SQL.Clear;
    qryProperties.SQL.Add('Select * FROM tblProperties WHERE Assigned_Agent= "'
      + sAgent_ID + '"');
    qryProperties.Open;

    qryClients.Close;
    qryClients.SQL.Clear;
    qryClients.SQL.Add('Select * FROM tblClients WHERE Assigned_Agent= "' +
      sAgent_ID + '"');
    qryClients.Open;

    qryProperties.First;
    lblPropertyID1.Caption := qryProperties['Property_ID'];
    lblAgentID1.Caption := frmLoginScreen.sAgent_ID;
    lblPropertyLocation1.Caption := qryProperties['Property_Location'];
    lblRoomAmount1.Caption := qryProperties['Room_Amount'];
    lblPropertyName.Caption := qryProperties['Property_Name'];
    lblClientID1.Caption := frmAgentDashboard.sClientID;
  end;
  N := 0;
  with dmCSE do
  begin
    qryProperties.First;
    while N <= 99 do
    begin
      inc(N, 1);
      if qryProperties['Property_ID'] = arrPropertyCode[N] then
      begin
        rListingPrice := arrPropertyListings[N];
        lblListingPrice.Caption := floatToStrf(rListingPrice, ffCurrency, 8, 2);
        edtPropertyListing.Text := FloatToStr(rListingPrice);
        if qryProperties['Client_ID'] = frmAgentDashboard.sClientID then
        begin
          rAmountPaid := frmAgentDashboard.rAmountPaid;
          lblAmountPaid1.Caption := floatToStrf(rAmountPaid, ffCurrency, 8, 2);
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
  end;

end;

procedure TfrmAgentProperty.FormCreate(Sender: TObject);
var
  tPropertyValues: textfile;
  sline: string;
  N, i: integer;

begin
  RoundCornerof(pnlPropertyInfo);
  RoundCornerof(pnlAgentID);
  RoundCornerof(pnlRoomAmount);
  RoundCornerof(pnlPropertyID);
  RoundCornerof(pnlPropertyLocation);
  RoundCornerof(pnlFinancialInfo);
  RoundCornerof(pnlClose);
  RoundCornerof(pnlListing);
  RoundCornerof(pnlLast);
  RoundCornerof(pnlNext);
  RoundCornerof(pnlFirst);
  RoundCornerof(pnlPrevious);
  RoundCornerof(pnlInstallmentCalculator);
  RoundCornerof(pnlEMIInfo);
  RoundCornerof(pnlEMI);
  RoundCornerof(pnlBack);

  if FileExists('PropertyListings.txt') = false then
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

procedure TfrmAgentProperty.RoundCornerof(Component: Twincontrol);
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

procedure TfrmAgentProperty.spdBackClick(Sender: TObject);
begin
frmAgentProperty.Close;
frmAgentDashboard.Show;
end;

procedure TfrmAgentProperty.spdCalculateClick(Sender: TObject);
var
  rPrincipleAmnt, rInterest, rEMI, rTotalInterest, rTotalAmount: real;
  iDuration: integer;
begin
  rPrincipleAmnt := StrToFloat(edtPropertyListing.Text);
  iDuration := StrToInt(edtDuration.Text);
  rInterest := (StrToFloat(edtInterestRate.Text)) / 100;
  //Calculates the EMI of the property for the client.
  rTotalAmount := rPrincipleAmnt *
    (power((1 + (rInterest / 12)), (iDuration * 12)));
  rTotalInterest := rTotalAmount - rPrincipleAmnt;
  rEMI := (rPrincipleAmnt * (((rInterest) * power((1 + (rInterest)),
    iDuration * 12)))) / (power((1 + (rInterest / 12)), (iDuration * 12) - 1));

  lblAmount2.Caption := floatToStrf(rPrincipleAmnt, ffCurrency, 8, 2);
  lblDuration.Caption := IntToStr(iDuration);
  lblInterestRate2.Caption := edtInterestRate.Text;
  lblTotalInterest2.Caption := floatToStrf(rTotalInterest, ffCurrency, 8, 2);
  lblTotalAmount2.Caption := floatToStrf(rTotalAmount, ffCurrency, 8, 2);
  lblEmi2.Caption := floatToStrf((rEMI / iDuration * 12), ffCurrency, 8, 2);

  Writeln(frmLoginScreen.tLogFile, 'Calculated the EMI of a property at: ' +
    TimeToStr(Now));
end;

procedure TfrmAgentProperty.spdCloseClick(Sender: TObject);
begin
  frmAgentProperty.Close;
  frmLoginScreen.Close;
  CloseFile(frmLoginScreen.tLogFile);
end;

procedure TfrmAgentProperty.SpeedButton1Click(Sender: TObject);
var
  N: integer;
begin
  iPicRandom := RandomRange(0, 17);
  imgPropertyDisplay.Picture.LoadFromFile('House' + IntToStr(iPicRandom)
    + '.png');
  with dmCSE do
  begin
    qryProperties.Prior;
    qryClients.Prior;
    lblPropertyID1.Caption := qryProperties['Property_ID'];
    lblAgentID1.Caption := frmLoginScreen.sAgent_ID;
    lblPropertyLocation1.Caption := qryProperties['Property_Location'];
    lblRoomAmount1.Caption := qryProperties['Room_Amount'];
    lblPropertyName.Caption := qryProperties['Property_Name'];

    N := 0;
    while N <= 99 do
    begin
      inc(N, 1);
      if qryProperties['Property_ID'] = arrPropertyCode[N] then
      begin
        rListingPrice := arrPropertyListings[N];
        lblListingPrice.Caption := floatToStrf(rListingPrice, ffCurrency, 8, 2);
        edtPropertyListing.Text := FloatToStr(rListingPrice);
        if qryProperties['Client_ID'] = qryClients['Client_ID'] then
        begin
          rAmountPaid := qryClients['AmountPaid'];;
          lblAmountPaid1.Caption := floatToStrf(rAmountPaid, ffCurrency, 8, 2);
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
  end;
end;

procedure TfrmAgentProperty.SpeedButton2Click(Sender: TObject);
var
  N: integer;
begin
  iPicRandom := RandomRange(0, 17);
  imgPropertyDisplay.Picture.LoadFromFile('House' + IntToStr(iPicRandom)
    + '.png');
  with dmCSE do
  begin
    qryProperties.First;
    qryClients.First;
    lblPropertyID1.Caption := qryProperties['Property_ID'];
    lblAgentID1.Caption := frmLoginScreen.sAgent_ID;
    lblPropertyLocation1.Caption := qryProperties['Property_Location'];
    lblRoomAmount1.Caption := qryProperties['Room_Amount'];
    lblPropertyName.Caption := qryProperties['Property_Name'];

    lblClientID1.Caption := qryProperties['Client_ID'];
    N := 0;
    while N <= 99 do
    begin
      inc(N, 1);
      if qryProperties['Property_ID'] = arrPropertyCode[N] then
      begin
        rListingPrice := arrPropertyListings[N];
        lblListingPrice.Caption := floatToStrf(rListingPrice, ffCurrency, 8, 2);
        edtPropertyListing.Text := FloatToStr(rListingPrice);
        if qryProperties['Client_ID'] = qryClients['Client_ID'] then
        begin
          rAmountPaid := qryClients['AmountPaid'];;
          lblAmountPaid1.Caption := floatToStrf(rAmountPaid, ffCurrency, 8, 2);
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
  end;
end;

procedure TfrmAgentProperty.SpeedButton3Click(Sender: TObject);
var
  N: integer;
begin
  iPicRandom := RandomRange(0, 17);
  imgPropertyDisplay.Picture.LoadFromFile('House' + IntToStr(iPicRandom)
    + '.png');
  with dmCSE do
  begin
    qryProperties.Next;
    qryClients.Next;
    lblPropertyID1.Caption := qryProperties['Property_ID'];
    lblAgentID1.Caption := frmLoginScreen.sAgent_ID;
    lblPropertyLocation1.Caption := qryProperties['Property_Location'];
    lblRoomAmount1.Caption := qryProperties['Room_Amount'];
    lblPropertyName.Caption := qryProperties['Property_Name'];

    lblClientID1.Caption := qryProperties['Client_ID'];
    N := 0;
    while N <= 99 do
    begin
      inc(N, 1);
      if qryProperties['Property_ID'] = arrPropertyCode[N] then
      begin
        rListingPrice := arrPropertyListings[N];
        lblListingPrice.Caption := floatToStrf(rListingPrice, ffCurrency, 8, 2);
        edtPropertyListing.Text := FloatToStr(rListingPrice);
        if qryProperties['Client_ID'] = qryClients['Client_ID'] then
        begin
          rAmountPaid := qryClients['AmountPaid'];
          lblAmountPaid1.Caption := floatToStrf(rAmountPaid, ffCurrency, 8, 2);
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
  end;

end;

procedure TfrmAgentProperty.SpeedButton4Click(Sender: TObject);
var
  N: integer;
begin
  iPicRandom := RandomRange(0, 17);
  imgPropertyDisplay.Picture.LoadFromFile('House' + IntToStr(iPicRandom)
    + '.png');
  with dmCSE do
  begin
    qryProperties.Last;
    qryClients.Last;
    lblPropertyID1.Caption := qryProperties['Property_ID'];
    lblAgentID1.Caption := frmLoginScreen.sAgent_ID;
    lblPropertyLocation1.Caption := qryProperties['Property_Location'];
    lblRoomAmount1.Caption := qryProperties['Room_Amount'];
    lblPropertyName.Caption := qryProperties['Property_Name'];

    lblClientID1.Caption := qryProperties['Client_ID'];
    N := 0;
    while N <= 99 do
    begin
      inc(N, 1);
      if qryProperties['Property_ID'] = arrPropertyCode[N] then
      begin
        rListingPrice := arrPropertyListings[N];
        lblListingPrice.Caption := floatToStrf(rListingPrice, ffCurrency, 8, 2);
        edtPropertyListing.Text := FloatToStr(rListingPrice);
        if qryProperties['Client_ID'] = qryProperties['Client_ID'] then
        begin
          rAmountPaid := qryClients['AmountPaid'];;
          lblAmountPaid1.Caption := floatToStrf(rAmountPaid, ffCurrency, 8, 2);
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
        if rAmountDue > 0 then
        begin
          lblAmountDue1.Caption := floatToStrf(rAmountDue, ffCurrency, 8, 2);
        end
        Else
          lblAmountDue1.Caption := 'PAID';
      end;

    end;
  end;
end;

procedure TfrmAgentProperty.tmMoveImageTimer(Sender: TObject);
begin

  while imgPropertyDisplay.Left < 704 do
  begin
    imgPropertyDisplay.Left := imgPropertyDisplay.Left + 10;
  end;

end;

end.
