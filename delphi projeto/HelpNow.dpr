program HelpNow;

uses
  Vcl.Forms,
  Paguina_incial_login in 'Paguina_incial_login.pas' {pag_inicial},
  Paguina_login in 'Paguina_login.pas' {pag_login},
  Paguina_cadastro in 'Paguina_cadastro.pas' {pag_cadastro},
  pg_home in 'pg_home.pas' {pag_home},
  Conexao in 'Conexao.pas' {DataModule2: TDataModule},
  Perfil in 'Perfil.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tpag_home, pag_home);
  Application.CreateForm(Tpag_inicial, pag_inicial);
  Application.CreateForm(Tpag_login, pag_login);
  Application.CreateForm(Tpag_cadastro, pag_cadastro);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
