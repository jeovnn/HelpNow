unit MaisInformacoesServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage,ShellAPI,conexao;

type
  TForm9 = class(TForm)
    td: TImage;
    LabelMaisInformacoes: TLabel;
    LabelCategirua: TLabel;
    LabelCategoriaBanco: TLabel;
    LabelTitulo: TLabel;
    LabelTitulodobanco: TLabel;
    LabelDescricao: TLabel;
    LabelDescricaodobanco: TLabel;
    LabelPreco: TLabel;
    LabelValordobanco: TLabel;
    LabelPrestador: TLabel;
    LabelPrestadordobanco: TLabel;
    LabelTelefone: TLabel;
    LabelTelefonedobanco: TLabel;
    ImagePerfil: TImage;
    LabelEmail: TLabel;
    LabelEmaildobanco: TLabel;
    LabelRegiao: TLabel;
    LabelRegiaodobanco: TLabel;
    ButtonVoltar: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    LinkLabel1: TLinkLabel;
    Image1: TImage;
    GroupBox5: TGroupBox;
    procedure ButtonVoltarClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure LinkLabel1LinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation
uses
Paguina_servicos,pg_home;
{$R *.dfm}

procedure TForm9.ButtonVoltarClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(Form2);
end;

procedure TForm9.FormHide(Sender: TObject);
begin
  // Limpa todas as labels
  LabelTitulodobanco.Caption      := '';
  LabelDescricaodobanco.Caption   := '';
  LabelValordobanco.Caption       := '';
  LabelCategoriaBanco.Caption     := '';
  LabelPrestadordobanco.Caption   := '';
  LabelTelefonedobanco.Caption    := '';
  LabelEmaildobanco.Caption       := '';
  LabelRegiaodobanco.Caption      := '';

  // Limpa a imagem
  td.Picture := nil;
end;

procedure TForm9.LinkLabel1LinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
var
  Numero, Mensagem, LinkWhats: string;
begin
  if not DataModule2.FDConnection1.Connected then
    DataModule2.FDConnection1.Connected := True;

  // busca o telefone do prestador do serviço mostrado na tela
  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text :=
      'SELECT u.telefone ' +
      'FROM usuario u ' +
      'JOIN prestador p ON p.id_usuario = u.id_usuario ' +
      'JOIN servico s ON s.id_prestador = p.id_prestador ' +
      'WHERE s.titulo = :titulo'; // ou o campo que você usa pra identificar o serviço
    ParamByName('titulo').AsString := LabelTitulodobanco.Caption;
    Open;

    if not EOF then
      Numero := Trim(FieldByName('telefone').AsString)
    else
    begin
      ShowMessage('Telefone não encontrado para este prestador.');
      Exit;
    end;
    Close;
  end;

  // remove caracteres especiais
  Numero := StringReplace(Numero, '(', '', [rfReplaceAll]);
  Numero := StringReplace(Numero, ')', '', [rfReplaceAll]);
  Numero := StringReplace(Numero, '-', '', [rfReplaceAll]);
  Numero := StringReplace(Numero, ' ', '', [rfReplaceAll]);

  if Numero = '' then
  begin
    ShowMessage('Prestador não possui telefone cadastrado.');
    Exit;
  end;

  Mensagem := 'Olá! Gostaria de mais informações sobre o serviço: ' + LabelTitulodobanco.Caption;
  Mensagem := StringReplace(Mensagem, ' ', '%20', [rfReplaceAll]);
  LinkWhats := 'https://wa.me/55' + Numero + '?text=' + Mensagem;

  ShellExecute(0, 'open', PChar(LinkWhats), nil, nil, SW_SHOWNORMAL);
end;

end.
