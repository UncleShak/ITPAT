unit ChromeSkyEstates_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, dmChromeSkyEstates_u,
  Vcl.Imaging.pngimage, AgentDashboard_u, AdminDashboard_u, clsAgentInfo_u,
  Vcl.WinXCtrls, Vcl.Buttons, Vcl.ComCtrls, Register_u, CommCtrl,
  Vcl.Imaging.GIFImg, ShellAPI,ForgotPassword_u;

type
  TfrmLoginScreen = class(TForm)
    Label1: TLabel;
    edtLoginPassword: TEdit;
    pnlLogin: TPanel;
    lblForgotPassword: TLabel;
    lblCreateAccount: TLabel;
    edtLoginUsername: TEdit;
    Label2: TLabel;
    spdShowButton: TSpeedButton;
    pbLogin: TProgressBar;
    tAgent: TTimer;
    pnlLoginInfo: TPanel;
    pnlCreateAccount: TPanel;
    pnlClose: TPanel;
    spdLogin: TSpeedButton;
    Image2: TImage;
    spdClose: TSpeedButton;
    spdSignUp: TSpeedButton;
    tAdmin: TTimer;
    pnlHelp: TPanel;
    spdHelp: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
    procedure tglShowClick(Sender: TObject);
    procedure RoundCornerof(Component: Twincontrol);
    procedure spdShowButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tAgentTimer(Sender: TObject);
    procedure spdLoginClick(Sender: TObject);
    procedure spdCloseClick(Sender: TObject);
    procedure spdSignUpClick(Sender: TObject);
    procedure tAdminTimer(Sender: TObject);
    procedure spdHelpClick(Sender: TObject);
    procedure lblForgotPasswordMouseEnter(Sender: TObject);
    procedure lblForgotPasswordMouseLeave(Sender: TObject);
    procedure lblForgotPasswordClick(Sender: TObject);
    procedure edtLoginUsernameClick(Sender: TObject);
    procedure edtLoginPasswordClick(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
    oAgentInfo: TAgentInfo;

    sUsername, sPassword: String;

    sFirst_Name, sLast_Name, sAgent_ID, sRace, sGender: string;
    iSales_Record, iAge,iCurrent_Level: integer;

    sFull_Name: string;

    tLogFile: textfile;
  end;

var
  frmLoginScreen: TfrmLoginScreen;

implementation

{$R *.dfm}

procedure TfrmLoginScreen.btnShowClick(Sender: TObject);
begin

  if edtLoginPassword.PasswordChar = '*' then   //Checks the format of the edit box and returns the opposite format
  begin
    edtLoginPassword.PasswordChar := #0;
  end
  else if edtLoginPassword.PasswordChar = #0 then
  begin
    edtLoginPassword.PasswordChar := '*';
  end;

end;

procedure TfrmLoginScreen.edtLoginPasswordClick(Sender: TObject);
begin
edtLoginPassword.Text:='';
end;

procedure TfrmLoginScreen.edtLoginUsernameClick(Sender: TObject);
begin
edtLoginUsername.Text:='';
end;

procedure TfrmLoginScreen.FormActivate(Sender: TObject);
begin
  lblForgotPassword.Visible := false;
  spdShowButton.Glyph.LoadFromFile('eye.bmp');
  pbLogin.Position:=0;
  RoundCornerof(pnlLogin);
  RoundCornerof(pnlLoginInfo);
  RoundCornerof(pnlCreateAccount);//Rounds the corner of panels on form.
  RoundCornerof(pnlClose);

end;

procedure TfrmLoginScreen.FormCreate(Sender: TObject);
begin
  pbLogin.Visible := false;
  tAgent.Enabled := false;
  tAdmin.Enabled := false;
  pbLogin.Min := 0;
  pbLogin.Max := 100;
  AssignFile(tLogFile, 'LogFiles\' + FormatDateTime('yyyy-mm-dd', date)
    + '.txt');

end;

procedure TfrmLoginScreen.lblForgotPasswordClick(Sender: TObject);
begin
frmForgotPassword.Show;
frmLoginScreen.Hide;
end;

procedure TfrmLoginScreen.lblForgotPasswordMouseEnter(Sender: TObject);
begin
lblForgotPassword.Font.Color:=$00DEE0F2;
end;

procedure TfrmLoginScreen.lblForgotPasswordMouseLeave(Sender: TObject);
begin
lblForgotPassword.Font.Color:=clWhite;
end;

procedure TfrmLoginScreen.RoundCornerof(Component: Twincontrol);
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

procedure TfrmLoginScreen.spdShowButtonClick(Sender: TObject);
begin
  if edtLoginPassword.PasswordChar = '*' then
  begin
    edtLoginPassword.PasswordChar := #0;
    spdShowButton.Glyph.LoadFromFile('eye-crossed.bmp');
  end
  else if edtLoginPassword.PasswordChar = #0 then
  begin
    edtLoginPassword.PasswordChar := '*';
    spdShowButton.Glyph.LoadFromFile('eye.bmp');
  end;

end;

procedure TfrmLoginScreen.spdSignUpClick(Sender: TObject);
begin
  frmLoginScreen.Hide;
  frmRegister.Show;
end;

procedure TfrmLoginScreen.spdCloseClick(Sender: TObject);
begin
  frmLoginScreen.close;
end;

procedure TfrmLoginScreen.spdHelpClick(Sender: TObject);
var
  FilePath: string;
begin
  FilePath := 'ProjectNotes.txt';
  ShellExecute(0, 'open', PChar(FilePath), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmLoginScreen.spdLoginClick(Sender: TObject);
var
  bFound, bFound2: Boolean;
begin
  sUsername := edtLoginUsername.Text;
  sPassword := edtLoginPassword.Text;
  bFound := false;
  bFound2 := false;
  with dmCSE do
  begin
    tblLogin.first;
    while not tblLogin.Eof AND (bFound = false) do //Runs through database, until the credentials entered match those in the database.
    begin
      if (tblLogin['Email'] = sUsername) AND (tblLogin['Password'] = sPassword)
      then
      begin
        bFound := True;
        if bFound = True and (tblLogin['User_Type'] = 'Agent') then  //Assigns values to specific variables if the User type is "Agent"
        begin
          pbLogin.Visible := True;
          tAgent.Enabled := True;
          sFirst_Name := tblLogin['First_Name'];
          sLast_Name := tblLogin['Last_Name'];
          tblAgents.first;
          while not tblAgents.Eof AND (bFound2 = false) do
          begin
            if tblLogin['First_Name'] = tblAgents['First_Name'] then
            begin
              bFound2 := True;

              if bFound2 = True then
              begin
                sAgent_ID := tblAgents['Agent_ID'];
                sRace := tblAgents['Race'];
                sGender := tblAgents['Gender'];

                iSales_Record := tblAgents['Sales_Record'];
                iAge := tblAgents['Age'];
                iCurrent_Level:= tblAgents['Sales_Record']-5;
                oAgentInfo := TAgentInfo.create(sFirst_Name, sLast_Name,iCurrent_Level); //Instantiates the object.
                Append(tLogFile);
                Writeln(tLogFile, 'Agent: ' + sAgent_ID);// Writes code to Log Textfile.
                Writeln(tLogFile, 'Logged on at: ' + DateToStr(date) + ' ' +
                  TimeToStr(Now));
              end;

            end
            else
              tblAgents.Next;
          end;

        end
        else if bFound = True and (tblLogin['User_Type'] = 'Administrator') then  //Assigns values to specific variables if the User type is "Administrator"
        begin
          pbLogin.Visible := True;
          tAdmin.Enabled := True;
          sFirst_Name := tblLogin['First_Name'];
          sLast_Name := tblLogin['Last_Name'];
          oAgentInfo := TAgentInfo.create(sFirst_Name, sLast_Name,iCurrent_Level);
          sFull_Name := oAgentInfo.getFullName;

        end;

      end
      else

        tblLogin.Next;
    end;

  end;
  if bFound = false then
  begin
    Label2.Font.Color := $002B1CB4;
    Label2.Caption := 'Username or Password is incorrect.';
    lblForgotPassword.Visible := True;
    tAgent.Enabled := false;
    tAdmin.Enabled := false;
  end;

end;

procedure TfrmLoginScreen.tglShowClick(Sender: TObject);
begin
  edtLoginPassword.PasswordChar := #0;
end;

procedure TfrmLoginScreen.tAdminTimer(Sender: TObject);
begin
  pbLogin.Position := pbLogin.Position + 30; //Timer assigned to progress bar if user type is an "Administrator"
  if pbLogin.Position = 100 then
  begin
    tAdmin.Enabled := false;
    frmLoginScreen.Hide;
    frmAdminDashboard.Show;
  end;
end;

procedure TfrmLoginScreen.tAgentTimer(Sender: TObject);
begin
  pbLogin.Position := pbLogin.Position + 30; //Timer assigned to progress bar if user type is an "Agent"
  if pbLogin.Position = 100 then
  begin
    tAgent.Enabled := false;
    frmLoginScreen.Hide;
    frmAgentDashboard.Show;
  end;
end;

end.
