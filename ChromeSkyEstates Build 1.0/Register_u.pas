unit Register_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, dmChromeSkyEstates_u, Vcl.Buttons;

type
  TfrmRegister = class(TForm)
    pnlRegisterInfo: TPanel;
    edtFirstName: TEdit;
    edtLastName: TEdit;
    edtEmail: TEdit;
    edtPassword: TEdit;
    edtPasswordConfirmation: TEdit;
    pnlRegister: TPanel;
    pnlLogin: TPanel;
    pnlClose: TPanel;
    lblFirstName: TLabel;
    lblLastName: TLabel;
    lblEmail: TLabel;
    lblPassword: TLabel;
    lblPasswordConfirm: TLabel;
    cmbUserType: TComboBox;
    lblUserType: TLabel;
    lblCreateAccount: TLabel;
    lblInstruction: TLabel;
    lblAge: TLabel;
    edtAge: TEdit;
    lblGender: TLabel;
    edtGender: TEdit;
    lblAgentID: TLabel;
    edtAgentID: TEdit;
    lblPasswordMessage: TLabel;
    spdCreateAccount: TSpeedButton;
    lblRace: TLabel;
    edtRace: TEdit;
    imgLogo: TImage;
    lblMessage: TLabel;
    spdLogin: TSpeedButton;
    spdClose: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure pnlCloseClick(Sender: TObject);
    procedure cmbUserTypeSelect(Sender: TObject);
    procedure edtPasswordConfirmationChange(Sender: TObject);
    procedure spdCreateAccountClick(Sender: TObject);
    procedure spdLoginClick(Sender: TObject);
    procedure spdCloseClick(Sender: TObject);
    procedure RoundCornerof(Component: Twincontrol);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegister: TfrmRegister;

implementation

uses
  ChromeSkyEstates_u;

{$R *.dfm}

procedure TfrmRegister.cmbUserTypeSelect(Sender: TObject);
Var
  sUserType: string;
begin
  sUserType := cmbUserType.Text;
  if sUserType = 'Agent' then
  begin
    lblAge.Visible := True;
    edtAge.Visible := True;

    lblGender.Visible := True;
    edtGender.Visible := True;

    lblAgentID.Visible := True;
    edtAgentID.Visible := True;

    lblRace.Visible := True;
    edtRace.Visible := True;
  end
  else if sUserType = 'Administrator' then
  begin
    lblAge.Visible := False;
    edtAge.Visible := False;

    lblGender.Visible := False;
    edtGender.Visible := False;

    lblAgentID.Visible := False;
    edtAgentID.Visible := False;

    lblRace.Visible := False;
    edtRace.Visible := False;
  end;

end;

procedure TfrmRegister.edtPasswordConfirmationChange(Sender: TObject);
var
  sPassword1, sPassword2: string;
begin
  sPassword1 := edtPassword.Text;
  sPassword2 := edtPasswordConfirmation.Text;
  if (sPassword1 = sPassword2) then
  begin
    lblPasswordMessage.Font.Color := $00429F00;
    lblPasswordMessage.Caption := 'Password matching';
    spdCreateAccount.Enabled := True;
  end
  else if sPassword1 <> sPassword2 then
  begin
    lblPasswordMessage.Font.Color := $002B1CB4;
    lblPasswordMessage.Caption := 'Passwords do not match';
    spdCreateAccount.Enabled := False;
  end;

end;

procedure TfrmRegister.FormActivate(Sender: TObject);
begin
RoundCornerof(pnlClose);
RoundCornerof(pnlLogin);
RoundCornerof(pnlRegister);
end;

procedure TfrmRegister.FormCreate(Sender: TObject);
begin
  cmbUserType.Items.Add('Administrator');
  cmbUserType.Items.Add('Agent');
end;

procedure TfrmRegister.pnlCloseClick(Sender: TObject);
begin
  frmRegister.Close;
  frmLoginScreen.Close;
end;

procedure TfrmRegister.RoundCornerof(Component: Twincontrol);
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

procedure TfrmRegister.spdCloseClick(Sender: TObject);
begin
  frmRegister.Close;
  frmLoginScreen.Close;
end;

procedure TfrmRegister.spdCreateAccountClick(Sender: TObject);
var
  bFound: Boolean;
  sAgent_ID: string;
  iAge: Integer;
begin
  bFound := False;
  sAgent_ID := edtAgentID.Text;
  iAge := StrToInt(edtAge.Text);
  if iAge <= 18 then
  begin
    lblInstruction.Font.Color := $002B1CB4;
    lblInstruction.Caption := 'User must be over the age of 18';
    exit;
  end;

  if cmbUserType.Text = 'Administrator' then
  begin
    with dmCSE do
    begin
      tblLogin['Email'] := edtEmail.Text;
      tblLogin['Password'] := edtPasswordConfirmation.Text;
      tblLogin['User_Type'] := cmbUserType.Text;
      tblLogin['Full_Name'] := edtFirstName.Text;
      tblLogin['Last_Name'] := edtLastName.Text;
    end;
  end
  else if cmbUserType.Text = 'Agent' then
  begin
    with dmCSE do
    begin
      tblAgents.First;
      while not tblAgents.Eof do
      begin
        if sAgent_ID = tblAgents['Agent_ID'] then
        begin
          bFound := True;
          lblInstruction.Font.Color := $002B1CB4;
          lblInstruction.Caption := 'Agent ID already exists';
          exit;
        end
        else
          tblAgents.Next;
      end;
      if bFound = False then
      begin
        tblLogin.Insert;
        tblLogin['Email'] := edtEmail.Text;
        tblLogin['Password'] := edtPasswordConfirmation.Text;
        tblLogin['User_Type'] := cmbUserType.Text;
        tblLogin['First_Name'] := edtFirstName.Text;
        tblLogin['Last_Name'] := edtLastName.Text;
        tblLogin.Post;
        tblAgents.Insert;
        tblAgents['Agent_ID'] := sAgent_ID;
        tblAgents['First_Name'] := edtFirstName.Text;
        tblAgents['Last_Name'] := edtLastName.Text;
        tblAgents['Age'] := iAge;
        tblAgents['Gender'] := edtGender.Text;
        tblAgents['Race'] := edtRace.Text;
        tblAgents['Sales_Record'] := 0;
        tblAgents.Post;
        pnlRegisterInfo.Visible := False;
        imgLogo.Left := 372;
        imgLogo.Top := 126;
        pnlClose.Left := 665;
        pnlClose.Top := 664;
        lblMessage.Visible := True;
        pnlLogin.Visible := True;
      end;

    end;
  end;

end;

procedure TfrmRegister.spdLoginClick(Sender: TObject);
begin
  frmRegister.Close;
  frmLoginScreen.Show;
end;

end.
