unit uHWSCheckListClientUsuariosMobileAlteracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls;

type
  THWS_Form_Usuarios_Mobile_Alteracao = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    HWS_Edit_Codigo: TEdit;
    HWS_Edit_Nome: TEdit;
    HWS_Edit_EMail: TEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    HWS_Edit_Usuario: TEdit;
    HWS_Edit_Senha: TEdit;
    HWS_Edit_SenhaRedigite: TEdit;
    HWS_CheckBox_AlterarSenha: TCheckBox;
    StatusBar1: TStatusBar;
    HWS_BitBtn_Gravar: TBitBtn;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure HWS_BitBtn_GravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HWS_Form_Usuarios_Mobile_Alteracao: THWS_Form_Usuarios_Mobile_Alteracao;

implementation

uses uHWSCheckListClientDataModule,  uHWSFuncoes, uHWSCheckListClientAutenticacao;

{$R *.dfm}

procedure THWS_Form_Usuarios_Mobile_Alteracao.BitBtn1Click(Sender: TObject);
begin
   Close;
end;

procedure THWS_Form_Usuarios_Mobile_Alteracao.FormCreate(Sender: TObject);
begin
   HWS_Edit_Codigo.Text          := FormatFloat('000000',HWS_ClientModule.HWS_ClientDataSet_HI01HI_CODIGO.AsInteger);
   HWS_Edit_Nome.Text            := HWS_ClientModule.HWS_ClientDataSet_HI01HI_NOME.AsString;
   HWS_Edit_EMail.Text           := HWS_ClientModule.HWS_ClientDataSet_HI01HI_EMAIL.AsString;
   HWS_Edit_Usuario.Text         := HWS_ClientModule.HWS_ClientDataSet_HI01HI_USER.AsString;
   HWS_Edit_Senha.Text           := HWS_ClientModule.HWS_ClientDataSet_HI01HI_SENHA.AsString;
   HWS_Edit_SenhaRedigite.Text   := HWS_ClientModule.HWS_ClientDataSet_HI01HI_SENHA.AsString;
   if HWS_ClientModule.HWS_ClientDataSet_HI01HI_RESENHA.AsString = 'S' then
      HWS_CheckBox_AlterarSenha.Checked := True;
end;

procedure THWS_Form_Usuarios_Mobile_Alteracao.HWS_BitBtn_GravarClick(
  Sender: TObject);
begin
   if F_HWS_ValidaDadosFormulario(HWS_ClientModule.HWS_ClientDataSet_HI01,'A','HI_CODIGO',HWS_Edit_Codigo.Text,HWS_Form_Usuarios_Mobile_Alteracao) then begin
      if Trim(HWS_Edit_Senha.Text) <> Trim(HWS_Edit_SenhaRedigite.Text) then begin
         MessageDlg('As senhas digitadas est�o incorretas.' ,mtError,[mbOK],0);
         HWS_Edit_SenhaRedigite.SetFocus;
         Exit;
      end;
      try
         HWS_ClientModule.HWS_ClientDataSet_HI01.Edit;
         HWS_ClientModule.HWS_ClientDataSet_HI01HI_CODEMP.AsString   := HWS_PUBLIC_CODCLIENTE;
         HWS_ClientModule.HWS_ClientDataSet_HI01HI_CODIGO.AsString   := HWS_Edit_Codigo.Text;
         HWS_ClientModule.HWS_ClientDataSet_HI01HI_NOME.AsString     := HWS_Edit_Nome.Text;
         HWS_ClientModule.HWS_ClientDataSet_HI01HI_EMAIL.AsString    := HWS_Edit_EMail.Text;
         HWS_ClientModule.HWS_ClientDataSet_HI01HI_DATAUPD.AsDateTime:= Date;
         HWS_ClientModule.HWS_ClientDataSet_HI01HI_USER.AsString     := HWS_Edit_Usuario.Text;
         HWS_ClientModule.HWS_ClientDataSet_HI01HI_SENHA.AsString    := HWS_Edit_Senha.Text;
         if HWS_CheckBox_AlterarSenha.Checked then
            HWS_ClientModule.HWS_ClientDataSet_HI01HI_RESENHA.AsString    := 'S'
         else
            HWS_ClientModule.HWS_ClientDataSet_HI01HI_RESENHA.AsString    := 'N';
         HWS_ClientModule.HWS_ClientDataSet_HI01.Post;
         HWS_ClientModule.HWS_ClientDataSet_HI01.ApplyUpdates(-1);
         Close;
      except on E: Exception do
         MessageDlg(E.ToString,mtError,[mbOK],0);
      end;
   end;
end;

end.
