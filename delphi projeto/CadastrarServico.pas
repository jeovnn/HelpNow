unit CadastrarServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, pg_home, conexao, Vcl.Imaging.jpeg;

type
  TForm7 = class(TForm)
    GroupBox1: TGroupBox;
    Image1: TImage;
    LabelMensagem: TLabel;
    ButtonVoltar: TButton;
    Labeltitulo: TLabel;
    EditTitulo: TEdit;
    LabelDescricao: TLabel;
    EditDescricao: TEdit;
    Labelpreco: TLabel;
    Editpreço: TEdit;
    ButtonSalvar: TButton;
    ComboCategoria: TComboBox;
    Label1: TLabel;
    Image2: TImage;
    procedure ButtonVoltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses
  Paguina_servicos;
{$R *.dfm}

procedure TForm7.ButtonSalvarClick(Sender: TObject);
var
  NovoID, CategoriaID, IDPrestador: Integer;
begin
  if ComboCategoria.ItemIndex = -1 then
  begin
    ShowMessage('Selecione uma categoria.');
    Exit;
  end;

  CategoriaID := Integer(ComboCategoria.Items.Objects
    [ComboCategoria.ItemIndex]);

  // ?? Gera novo ID para o serviço
  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text :=
      'SELECT COALESCE(MAX(ID_SERVICO), 0) + 1 AS NovoID FROM SERVICO';
    Open;
    NovoID := FieldByName('NovoID').AsInteger;
    Close;
  end;

  // ?? Pega o ID do prestador vinculado ao usuário logado
  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT id_prestador FROM prestador WHERE id_usuario = :id';
    ParamByName('id').AsInteger := UsuarioLogadoID;
    Open;

    if EOF then
    begin
      ShowMessage('Erro: usuário não está cadastrado como prestador.');
      Exit;
    end;

    IDPrestador := FieldByName('id_prestador').AsInteger;
    Close;
  end;

  // ?? Faz o INSERT na tabela de serviços
  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text :=
      'INSERT INTO servico (id_servico, id_categoria, id_prestador, titulo, descricao, preco) '
      + 'VALUES (:id, :cat, :prest, :tit, :desc, :preco)';
    ParamByName('id').AsInteger := NovoID;
    ParamByName('cat').AsInteger := CategoriaID;
    ParamByName('prest').AsInteger := IDPrestador;
    ParamByName('tit').AsString := EditTitulo.Text;
    ParamByName('desc').AsString := EditDescricao.Text;
    ParamByName('preco').AsFloat := StrToFloatDef(Editpreço.Text, 0);
    ExecSQL;
  end;
  // Atualiza a query de serviços logo após o cadastro
  if DataModule2.FDQueryServicos.Active then
  begin
    DataModule2.FDQueryServicos.Close;
    DataModule2.FDQueryServicos.Open;
  end;

  ShowMessage('Serviço cadastrado com sucesso!');
  pag_home.MostrarFormularioEmbed(Form2);
  Form2.CarregarServicos; // ?? atualiza a lista de serviços
end;

procedure TForm7.ButtonVoltarClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(Form2);
  Form2.CarregarServicos; // ?? força atualizar ao voltar
end;

procedure TForm7.FormShow(Sender: TObject);
begin
  if not DataModule2.FDConnection1.Connected then
    DataModule2.FDConnection1.Connected := True;

  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT id_categoria, nome FROM categoria ORDER BY nome';
    Open;

    ComboCategoria.Items.Clear;
    while not EOF do
    begin
      // Adiciona o nome da categoria, mas guarda o ID no objeto
      ComboCategoria.Items.AddObject(FieldByName('nome').AsString,
        TObject(FieldByName('id_categoria').AsInteger));
      Next;
    end;
    Close;
  end;
end;

end.
