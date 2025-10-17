unit EditarInformacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,pg_home,paguina_perfil,conexao,tornarprestador,editarfornecedor;

type
  TForm5 = class(TForm)
    LabelNome: TLabel;
    Image1: TImage;
    LabelMensagem: TLabel;
    LabelEMail: TLabel;
    LabelTelefone: TLabel;
    ButtonSalvar: TButton;
    CampoNome: TEdit;
    CampoEmail: TEdit;
    CampoTelefone: TEdit;
    ButtonVoltar: TButton;
    ButtonAlterarSenha: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    CampoSenha: TEdit;
    ButtonSalvarSenha: TButton;
    procedure ButtonVoltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ButtonAlterarSenhaClick(Sender: TObject);
    procedure ButtonSalvarSenhaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.ButtonAlterarSenhaClick(Sender: TObject);
begin
camposenha.Visible:= true;
buttonsalvarsenha.Visible:= true;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
pag_home.MostrarFormularioEmbed(Form6); // volta para tela de perfil
end;

procedure TForm5.ButtonSalvarClick(Sender: TObject);
begin
  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text :=
      'UPDATE usuario SET nome = :n, email = :e, telefone = :t WHERE id_usuario = :id';
    ParamByName('n').AsString := CampoNome.Text;
    ParamByName('e').AsString := CampoEmail.Text;
    ParamByName('t').AsString := CampoTelefone.Text;
    ParamByName('id').AsInteger := UsuarioLogadoID;
    ExecSQL;
  end;

  ShowMessage('Informações atualizadas com sucesso!');

end;

procedure TForm5.ButtonSalvarSenhaClick(Sender: TObject);
begin
  if Trim(CampoSenha.Text) = '' then
  begin
    ShowMessage('Digite uma nova senha.');
    Exit;
  end;

  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text := 'UPDATE conta SET senha = :s WHERE id_usuario = :id';
    ParamByName('s').AsString := CampoSenha.Text;
    ParamByName('id').AsInteger := UsuarioLogadoID;
    ExecSQL;
  end;

  ShowMessage('Senha atualizada com sucesso!');
  CampoSenha.Visible := False;
  ButtonSalvarSenha.Visible := False;
end;

procedure TForm5.ButtonVoltarClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(Form3); // volta para tela de perfil
end;

procedure TForm5.FormShow(Sender: TObject);
begin
  if not DataModule2.FDConnection1.Connected then
    DataModule2.FDConnection1.Connected := True;

  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT nome, email, telefone FROM usuario WHERE id_usuario = :id';
    ParamByName('id').AsInteger := UsuarioLogadoID;
    Open;

    if not EOF then
    begin
      CampoNome.Text     := FieldByName('nome').AsString;
      CampoEmail.Text    := FieldByName('email').AsString;
      CampoTelefone.Text := FieldByName('telefone').AsString;

      //Verifica se o telefone já existe no banco
      if Trim(FieldByName('telefone').AsString) = '' then
        LabelTelefone.Caption := '! Cadastrar telefone'
      else
        LabelTelefone.Caption := 'Alterar telefone';
    end;

    Close;
  end;
    // 🔹 Verifica se o usuário é prestador
  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT tipo FROM conta WHERE id_usuario = :id';
    ParamByName('id').AsInteger := UsuarioLogadoID;
    Open;

    if not EOF and SameText(FieldByName('tipo').AsString, 'prestador') then
      Button2.Visible := True   // mostra o botão
    else
      Button2.Visible := False; // esconde o botão
    Close;
  end;
   with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT senha FROM conta WHERE id_usuario = :id';
    ParamByName('id').AsInteger := UsuarioLogadoID;
    Open;

    if not EOF then
      CampoSenha.Text := FieldByName('senha').AsString
    else
      CampoSenha.Clear;

    Close;
  end;
end;

end.
