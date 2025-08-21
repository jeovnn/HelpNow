unit pg_home;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Paguina_cadastro, Paguina_login, Paguina_incial_login, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls;

type
  Tpag_home = class(TForm)
    Panel1: TPanel;
  procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MostrarFormularioEmbed(AForm: TForm);
  end;

var
  pag_home: Tpag_home;

implementation

{$R *.dfm}

procedure Tpag_home.FormCreate(Sender: TObject);
begin
  pag_inicial := Tpag_inicial.Create(Self);
  pag_login := Tpag_login.Create(Self);
  pag_cadastro := Tpag_cadastro.Create(Self);


  pag_inicial.Visible := False;
  pag_login.Visible := False;
  pag_cadastro.Visible := False;

  MostrarFormularioEmbed(pag_inicial);
end;

procedure Tpag_home.MostrarFormularioEmbed(AForm: TForm);
begin
  // Hide all embedded forms
  if Assigned(pag_inicial) then pag_inicial.Visible := False;
  if Assigned(pag_login) then pag_login.Visible := False;
  if Assigned(pag_cadastro) then pag_cadastro.Visible := False;

  // Embed the requested form
  AForm.Parent := Panel1;
  AForm.BorderStyle := bsNone;
  AForm.Align := alClient;
  AForm.Visible := True;
  AForm.Show;
end;


end.
