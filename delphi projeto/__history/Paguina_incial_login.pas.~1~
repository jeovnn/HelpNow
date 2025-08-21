unit Paguina_incial_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  Tpag_inicial = class(TForm)
    painel_principal: TPanel;
    botao_login: TImage;
    text_login_inicial: TLabel;
    botao_cadastro: TImage;
    descricao: TLabel;
    Image1: TImage;
    procedure botao_loginMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure botao_loginMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure botao_loginClick(Sender: TObject);
    procedure botao_cadastroClick(Sender: TObject);
    procedure botao_cadastroMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure botao_cadastroMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pag_inicial: Tpag_inicial;

implementation

uses
  pg_home, Paguina_login, Paguina_cadastro;

{$R *.dfm}


//faz o botao de cadastro mudar de tamanho no click
procedure Tpag_inicial.botao_cadastroMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
botao_login.Height := 71;
botao_login.Width := 280;
botao_login.top := 344;
botao_login.left := 70;
end;

procedure Tpag_inicial.botao_cadastroMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
botao_login.Height := 81;
botao_login.Width := 300;
botao_login.top := 339;
botao_login.left := 60;
end;

procedure Tpag_inicial.botao_loginClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(pag_login);
end;

procedure Tpag_inicial.botao_cadastroClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(pag_cadastro);
end;

//faz o botao de login mudar de tamanho no click
procedure Tpag_inicial.botao_loginMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
botao_login.Height := 71;
botao_login.Width := 280;
botao_login.top := 344;
botao_login.left := 70;
end;

procedure Tpag_inicial.botao_loginMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
botao_login.Height := 81;
botao_login.Width := 300;
botao_login.top := 339;
botao_login.left := 60;
end;

end.
