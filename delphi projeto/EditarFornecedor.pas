unit EditarFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, pg_home, conexao, Vcl.Imaging.jpeg;

type
  TForm6 = class(TForm)
    ButtonConcluir: TButton;
    ButtonVoltar: TButton;
    EditHabilidades: TEdit;
    EditRegiao: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    LabelMensagem: TLabel;
    LabelPerguntaHabilidades: TLabel;
    LabelPerguntaRegiao: TLabel;
    Image2: TImage;
    procedure ButtonVoltarClick(Sender: TObject);
    procedure ButtonConcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses
  editarinformacoes;

{$R *.dfm}

procedure TForm6.ButtonConcluirClick(Sender: TObject);
begin
  if not DataModule2.FDConnection1.Connected then
    DataModule2.FDConnection1.Connected := True;

  // Verifica se os campos estão preenchidos
  if Trim(EditHabilidades.Text) = '' then
  begin
    ShowMessage('Preencha suas habilidades.');
    Exit;
  end;

  if Trim(EditRegiao.Text) = '' then
  begin
    ShowMessage('Preencha sua região de atendimento.');
    Exit;
  end;

  // Atualiza as informações no banco
  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text := 'UPDATE prestador SET habilidades = :hab, regiao = :reg ' +
      'WHERE id_usuario = :id';
    ParamByName('hab').AsString := EditHabilidades.Text;
    ParamByName('reg').AsString := EditRegiao.Text;
    ParamByName('id').AsInteger := UsuarioLogadoID;
    ExecSQL;
  end;

  ShowMessage('Informações do prestador atualizadas com sucesso!');
  pag_home.MostrarFormularioEmbed(Form5);
  // volta para tela de editar informações
end;

procedure TForm6.ButtonVoltarClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(Form5); // volta para tela de alterar dados
end;

procedure TForm6.FormShow(Sender: TObject);
begin
  if not DataModule2.FDConnection1.Connected then
    DataModule2.FDConnection1.Connected := True;

  // Busca habilidades e região já cadastradas no banco
  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text :=
      'SELECT habilidades, regiao FROM prestador WHERE id_usuario = :id';
    ParamByName('id').AsInteger := UsuarioLogadoID;
    Open;

    if not EOF then
    begin
      EditHabilidades.Text := FieldByName('habilidades').AsString;
      EditRegiao.Text := FieldByName('regiao').AsString;
    end
    else
    begin
      EditHabilidades.Clear;
      EditRegiao.Clear;
    end;

    Close;
  end;
end;

end.
