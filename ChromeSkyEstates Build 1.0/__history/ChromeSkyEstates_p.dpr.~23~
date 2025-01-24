program ChromeSkyEstates_p;

uses
  Vcl.Forms,
  ChromeSkyEstates_u in 'ChromeSkyEstates_u.pas' {frmLoginScreen},
  dmChromeSkyEstates_u in 'dmChromeSkyEstates_u.pas' {dmCSE: TDataModule},
  AdminDashboard_u in 'AdminDashboard_u.pas' {frmAdminDashboard},
  clsAgentInfo_u in 'clsAgentInfo_u.pas',
  AgentDashboard_u in 'AgentDashboard_u.pas' {frmAgentDashboard},
  AgentClients_u in 'AgentClients_u.pas' {frmClients_u},
  Register_u in 'Register_u.pas' {frmRegister},
  AgentProperty_u in 'AgentProperty_u.pas' {frmAgentProperty},
  AdminManagement_u in 'AdminManagement_u.pas' {FrmAdminManagement},
  ForgotPassword_u in 'ForgotPassword_u.pas' {frmForgotPassword};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLoginScreen, frmLoginScreen);
  Application.CreateForm(TdmCSE, dmCSE);
  Application.CreateForm(TfrmAdminDashboard, frmAdminDashboard);
  Application.CreateForm(TfrmAgentDashboard, frmAgentDashboard);
  Application.CreateForm(TfrmClients_u, frmClients_u);
  Application.CreateForm(TfrmRegister, frmRegister);
  Application.CreateForm(TfrmAgentProperty, frmAgentProperty);
  Application.CreateForm(TFrmAdminManagement, FrmAdminManagement);
  Application.CreateForm(TfrmForgotPassword, frmForgotPassword);
  Application.Run;
end.
