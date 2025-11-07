unit Paguina_incial_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.Mask, Vcl.Buttons;

type
  Tpag_inicial = class(TForm)
    painel_principal: TPanel;
    text_login_inicial: TLabel;
    descricao: TLabel;
    Image1: TImage;
    ButtonLogin: TButton;
    ButtonCadastro: TButton;
    Image2: TImage;
    ButtonConvidado: TButton;
    procedure ButtonLoginClick(Sender: TObject);
    procedure ButtonCadastroClick(Sender: TObject);
    procedure ButtonConvidadoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pag_inicial: Tpag_inicial;
  high_login: Integer;
  high_cadastro: Integer;
  high_label: Integer;
  high_label2: Integer;

implementation

uses
  pg_home, Paguina_login, Paguina_cadastro,UnitConvidado;

{$R *.dfm}

procedure Tpag_inicial.ButtonCadastroClick(Sender: TObject);
begin
UsuarioConvidado := False;
pag_home.MostrarFormularioEmbed(pag_cadastro);
end;

procedure Tpag_inicial.ButtonConvidadoClick(Sender: TObject);
begin
UsuarioConvidado := True;
pag_home.MostrarFormularioEmbed(Form10);
end;

procedure Tpag_inicial.ButtonLoginClick(Sender: TObject);
begin
UsuarioConvidado := False;
pag_home.MostrarFormularioEmbed(pag_login);
end;

end.
