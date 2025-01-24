unit ForgotPassword_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dmChromeSkyEstates_u, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Imaging.pngimage;

type
  TfrmForgotPassword = class(TForm)
    imgLogo: TImage;
    lblHeader: TLabel;
    lblInstruction: TLabel;
    pnlVerify: TPanel;
    spdVerify: TSpeedButton;
    edtNewPassword: TEdit;
    edtVerifyPassword: TEdit;
    edtUsername: TEdit;
    lblNewPassword: TLabel;
    lblConfirmPassword: TLabel;
    pnlGreetings: TPanel;
    Image1: TImage;
    lblMessage: TLabel;
    pnlLogin: TPanel;
    spdLogin: TSpeedButton;
    lblPasswordMessage: TLabel;
    lblPasswordMessage2: TLabel;
    pnlClose: TPanel;
    pnlLogin1: TPanel;
    spdLogin2: TSpeedButton;
    spdClose: TSpeedButton;
    procedure spdVerifyClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure spdLoginClick(Sender: TObject);
    procedure edtVerifyPasswordChange(Sender: TObject);
    procedure edtUsernameChange(Sender: TObject);
    procedure spdCloseClick(Sender: TObject);
    procedure spdLogin2Click(Sender: TObject);
    procedure RoundCornerof(Component: Twincontrol);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmForgotPassword: TfrmForgotPassword;

implementation

uses
  ChromeSkyEstates_u;

{$R *.dfm}

procedure TfrmForgotPassword.edtUsernameChange(Sender: TObject);
var
  iPasslength: integer;
begin
  iPasslength := Length(edtNewPassword.Text);
  if Length(edtNewPassword.Text) >= 5 then
  begin
    lblPasswordMessage2.Caption := 'Password Available';

  end
  else if Length(edtNewPassword.Text) < 5 then
  begin
    lblPasswordMessage2.Font.Color := $002B1CB4;
    lblPasswordMessage2.Caption := 'Password must contain five or more digits';

  end;
end;

procedure TfrmForgotPassword.edtVerifyPasswordChange(Sender: TObject);
var
  sPassword1, sPassword2: string;
begin
  sPassword1 := edtNewPassword.Text;
  sPassword2 := edtVerifyPassword.Text;

  if (sPassword1 = sPassword2) then
  begin
    lblPasswordMessage.Font.Color := $00429F00;
    lblPasswordMessage.Caption := 'Password matching';

  end
  else if sPassword1 <> sPassword2 then
  begin
    lblPasswordMessage.Font.Color := $002B1CB4;
    lblPasswordMessage.Caption := 'Passwords do not match';

  end;

end;

procedure TfrmForgotPassword.FormActivate(Sender: TObject);
begin
  edtNewPassword.Visible := False;
  edtVerifyPassword.Visible := False;
  pnlGreetings.Visible := False;
  lblNewPassword.Visible := False;
  lblConfirmPassword.Visible := False;
  lblPasswordMessage.Visible:=False;
  lblPasswordMessage2.Visible:=False;

  RoundCornerof(pnlGreetings);
  RoundCornerof(pnlVerify);
  RoundCornerof(pnlLogin);
  RoundCornerof(pnlClose);
end;

procedure TfrmForgotPassword.RoundCornerof(Component: Twincontrol);
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

procedure TfrmForgotPassword.spdCloseClick(Sender: TObject);
begin
  frmForgotPassword.Close;
  frmLoginScreen.Close;
end;

procedure TfrmForgotPassword.spdLogin2Click(Sender: TObject);
begin
frmForgotPassword.Close;
frmLoginScreen.Show;
end;

procedure TfrmForgotPassword.spdLoginClick(Sender: TObject);
begin
  frmForgotPassword.Close;
  frmLoginScreen.Show;
end;

procedure TfrmForgotPassword.spdVerifyClick(Sender: TObject);
var
  sPassword, sUser: string;
  bFound: boolean;

begin
  sUser := edtUsername.Text;
  bFound := False;
  if spdVerify.Caption = 'Verify Account' then
  begin
    sUser := edtUsername.Text;
    with dmCSE do
    begin
      tblLogin.First;
      while not tblLogin.Eof do
      begin
        if tblLogin['Email'] = sUser then
        begin
          bFound := True;
          Showmessage('Account Verified');
          edtUsername.Visible := False;
          edtNewPassword.Visible := True;
          edtVerifyPassword.Visible := True;
          lblNewPassword.Visible := True;
          lblConfirmPassword.Visible := True;
          lblInstruction.Caption := 'Please enter your new password.';
          lblPasswordMessage.Visible:=True;
          lblPasswordMessage2.Visible:=True;
          spdVerify.Caption := 'Reset Password';
          exit;
        end
        else
          tblLogin.Next;

      end;
      if bFound = False then
      begin
        Showmessage('User not Found');
      end;

    end;
  end;
  sPassword := edtVerifyPassword.Text;
  if spdVerify.Caption = 'Reset Password' then
  begin
    with dmCSE do
    begin
      tblLogin.First;

      if tblLogin.Locate('Email', sUser, []) = True then
      begin
        tblLogin.Edit;
        tblLogin['Password'] := sPassword;
        tblLogin.Post;
        pnlGreetings.Visible := True;
      end
      else
      begin
        Showmessage('User not found');

      end;

    end;
  end;

end;

end.
