unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  WinINet, System.Threading;

type

  TForm1 = class(TForm)
    Button7: TButton;

    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Button5: TButton;
    Edit1: TEdit;
    Button6: TButton;
    TestMode: TCheckBox;
    ProgressBar1: TProgressBar;
    //nroArrDados:integer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

    procedure AttMemo3(valor:string);
    function getMemo2:string;
    //sites : array of TStringlist;



    //procedure BuscaDados(listaLinks:string; nro:integer);
    //procedure BuscaDados(listaLinks:string; nro:integer);
  end;

var
  Form1: TForm1;
  //arrDados: array of tstringlist;
  nroThreads:integer;
  ListaDD : tstringlist;

implementation

{$R *.dfm}

procedure TForm1.AttMemo3(valor: string);
begin
  memo3.Lines.Add(valor);
end;

function TForm1.getMemo2: string;
//var
//Resultado:tstringlist;
begin
   //Resultado := tstringlist.Create;
   //Resultado.Text := memo2.Lines.Text;
   result := memo2.Lines.Text;
  // resultado.Destroy;
end;

function GetURL(const AURL: string): string;
var
  HttpClient: THttpClient;
  HttpResponse: IHttpResponse;
begin

  HttpClient := THttpClient.Create;
  try
    HttpResponse := HttpClient.Get(AURL);
    Result := HttpResponse.ContentAsString();
  finally
    HttpClient.Free;
  end;
end;

procedure BuscaDados(listaLinks:string; nro:integer);
var
retorno, lista, memoPg:tstringlist;
i,ii,g,j:integer;
link,linkFrame,poster:string;
begin
    retorno := TStringList.Create;
    lista   := TStringList.Create;
    memoPg  := TStringList.Create;
    //link := memo2.Lines[1];
    //link := copy(link,1,)
    //memo4.Lines.Text := geturl(copy(memo2.Lines[1],1,pos('@',memo2.Lines[1])-1));
    memoPg.Text := listaLinks;
    memoPg.Text := ListaDD.Text;

    try
     for I := 0 to memoPg.Count -1 do begin
     //if edit1.Text <> '' then
     //Sleep(strtoint(edit1.Text));
      retorno.Text := GetURL(copy(memoPg[i],1,pos('@',memoPg[i])-1));
      retorno.Text := Copy(retorno.Text,pos('iframe',retorno.Text));
      retorno.Text := Copy(retorno.Text,pos('src="',retorno.Text)+5);
      linkFrame := Copy(retorno.Text, 1, pos('"',retorno.Text)-1);
      retorno.Text := GetURL('https://redecanais.bz'+linkFrame);
      retorno.Text := Copy(retorno.Text,pos('baixar="',retorno.Text)+8);
      link := Copy(retorno.Text, 1, Pos('.mp4',retorno.Text)+3);

      retorno.Text := Copy(retorno.Text,pos('poster=".',retorno.Text)+9);
      poster := Copy(retorno.Text,1,pos('"',retorno.Text)-1);
      ListaDD.Add(link+'@'+'https://redecanais.bz/player3'+poster+copy(memoPg[i],pos('@',memoPg[i])));

     end;
    except
      ShowMessage('Ocorreu Algum problema, O site pode estar fora do ar, você está sem internet, a estrutura do site mudou, ou começou o apocalipse!' + 'Thread: '+inttostr(nro));
    end;

    //arrDados[nro].Text := lista.Text;
    retorno.Destroy;
    lista.Destroy;
    memoPg.Destroy;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
retorno, lista:tstringlist;
i,ii,g,j:integer;
identificador,link:string;
begin
  //
  retorno := TStringList.Create;
  lista   := TStringList.Create;
    retorno.Text := GetURL(ComboBox1.Text);
    identificador := '<li><a href="/browse-';

    try
    while retorno.Text.Contains(identificador) do begin
      retorno.Text := copy(retorno.Text, pos(identificador,retorno.Text));
      link := copy(retorno.Text, pos('/',retorno.Text));
      link := copy(link,1,pos('"',link)-1);
      lista.Add('https://redecanais.bz'+link);
      retorno.Text := copy(retorno.Text,5);
    end;
    except
      ShowMessage('Ocorreu Algum problema, O site pode estar fora do ar, você está sem internet, a estrutura do site mudou, ou começou o apocalipse!');
    end;


  memo1.Lines.Text := lista.Text;
  lista.Destroy;
  retorno.Destroy;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
retorno,lista, temp:TStringList;
i,ii,g,j:integer;
identificador,link, temporada, episodeo,opcao,opcao2, titleSerie:string;
begin
    retorno := TStringList.Create;
    lista   := TStringList.Create;
    temp    := TStringList.Create;

    identificador := '/musicvideo.php?';

    for I := 0 to memo1.Lines.Count -1 do begin
      retorno.Text := GetURL(memo1.Lines[i]);
      retorno.Text := Copy(retorno.Text, pos('<title>',retorno.Text)+7);
      titleSerie := Copy(retorno.Text, 1,pos('</title>',retorno.Text)-1);
      while retorno.Text.Contains('<strong>Epis&oacute;dio ') do begin

        if (pos('Temporada</strong>',retorno.Text) < pos('<strong>Epis&oacute;dio ',retorno.Text))and (retorno.text.contains('Temporada</strong>')) then begin
          retorno.Text := copy(retorno.Text, pos('Temporada</strong>',retorno.Text)-20);
          retorno.Text := copy(retorno.Text, pos('<strong>',retorno.Text)+8);
          temporada := copy(retorno.Text,1,pos('&',retorno.Text)-1);
          retorno.text := copy(retorno.Text,pos('</strong>',retorno.Text));
        end else begin
          retorno.Text := copy(retorno.Text, pos('<strong>Epis&oacute;dio ', retorno.Text));
          retorno.Text := copy(retorno.Text, length('<strong>Epis&oacute;dio ')+1);
          episodeo := copy(retorno.Text, 1,pos(' ',retorno.Text)-1);

          retorno.Text := copy(retorno.Text, pos('<a href="',retorno.Text)+9);
          if pos('Dublado',retorno.Text) < pos('Legendado',retorno.Text) then begin
             opcao := 'Dublado';
             opcao2 := 'Legendado'
          end else begin
            opcao := 'Legendado';
            opcao2 := 'Dublado';
          end;
          link := copy(retorno.Text, 1,pos('"',retorno.Text)-1);
          link := 'https://redecanais.bz'+link;
          lista.Add(link+'@T'+temporada+'E'+episodeo+' '+opcao+'@'+titleSerie);

          if pos('<strong>Epis&oacute;dio ',retorno.Text) > pos(opcao2,retorno.Text)  then begin
             retorno.Text := copy(retorno.Text,5);
             retorno.Text := copy(retorno.Text, pos('<a href="',retorno.Text)+9);
             link := copy(retorno.Text, 1,pos('"',retorno.Text)-1);
             link := 'https://redecanais.bz'+link;
             lista.Add(link+'@T'+temporada+'E'+episodeo+' '+opcao2+'@'+titleSerie);
             retorno.Text := copy(retorno.Text, pos(opcao2,retorno.Text));
          end else begin
             retorno.Text := copy(retorno.Text, pos(opcao,retorno.Text));
          end;

        end;
      end;
    end;


    memo2.Lines.Text := lista.Text;
    temp.Destroy;
    lista.Destroy;
    retorno.Destroy;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
i,nroLinks:integer;
listaAtual:TStringList;
Tarefa: ITask;
textoEnviar: string;
begin
  if ListaDD = nil then
  ListaDD := TStringList.Create;
  ListaDD.Text := '';
  ListaDD.Text := memo2.Lines.Text;
  nroThreads := 0;
  //nroArrDados := 0;
  listaAtual := tstringlist.Create;
  nroLinks := memo2.Lines.Count;
  ProgressBar1.Max := memo2.Lines.Count;
 { for I := 0 to nroLinks-1 do begin
     //listaAtual.Add(memo2.Lines[i]);
     if ((listaAtual.Count mod 10) = 0) and (i>1) then begin
         //SetLength(Tarefa   , High(Tarefa   ) + 2);
         //SetLength(arrDados , High(arrDados ) + 2);
         //nroThreads := High(Tarefa);
         //arrDados[High(Tarefa)] := tstringlist.create;
         //textoenviar := listaAtual.Text;
         Tarefa[High(Tarefa)] := TTask.Create(procedure
                                              begin
                                                BuscaDados(textoenviar,nroThreads)
                                              end);
        { TThread.Queue(TThread.CurrentThread,
                procedure
                begin
                  BuscaDados(listaAtual.Text,nroThreads);
                end);   }
        { Tarefa[High(Tarefa)].Start;
         //if TestMode.Checked then begin
         //  ShowMessage(listaAtual.Text);
         //end;

         //listaAtual.Text := '';
     end;
  end;
      if listaAtual.Count <> 0 then begin
         //SetLength(Tarefa   , High(Tarefa   ) + 2);
         //SetLength(arrDados , High(arrDados ) + 2);
         //nroThreads := High(Tarefa);
         //arrDados[High(arrDados)] := tstringlist.create;   }
         Tarefa := TTask.Create(procedure

var
retorno, lista, memoPg:tstringlist;
i,ii,g,j:integer;
link,linkFrame,poster:string;
begin
    retorno := TStringList.Create;
    lista   := TStringList.Create;
    memoPg  := TStringList.Create;
    //link := memo2.Lines[1];
    //link := copy(link,1,)
    //memo4.Lines.Text := geturl(copy(memo2.Lines[1],1,pos('@',memo2.Lines[1])-1));
    //memoPg.Text := listaLinks;
    memoPg.Text := self.Memo2.Lines.Text;

    self.ProgressBar1.Visible:= true;
     for I := 0 to memoPg.Count -1 do begin
     //if edit1.Text <> '' then
     //Sleep(strtoint(edit1.Text));
     self.ProgressBar1.Position := i;
      try
      retorno.Text := GetURL(copy(memoPg[i],1,pos('@',memoPg[i])-1));
      retorno.Text := Copy(retorno.Text,pos('iframe',retorno.Text));
      retorno.Text := Copy(retorno.Text,pos('src="',retorno.Text)+5);
      linkFrame := Copy(retorno.Text, 1, pos('"',retorno.Text)-1);
      retorno.Text := GetURL('https://redecanais.bz'+linkFrame);
      retorno.Text := Copy(retorno.Text,pos('baixar="',retorno.Text)+8);
      link := Copy(retorno.Text, 1, Pos('.mp4',retorno.Text)+3);

      retorno.Text := Copy(retorno.Text,pos('poster=".',retorno.Text)+9);
      poster := Copy(retorno.Text,1,pos('"',retorno.Text)-1);
      self.Memo3.lines.Add(link+'@'+'https://redecanais.bz/player3'+poster+copy(memoPg[i],pos('@',memoPg[i])));
      except
      self.Memo3.lines.Add('@@@'+memoPg[i]+'@@@')
    end;

     end;
     Self.ProgressBar1.Position := 0;
       self.ProgressBar1.Visible:= false;

    //arrDados[nro].Text := lista.Text;
    retorno.Destroy;
    lista.Destroy;
    memoPg.Destroy;
end);
        { TThread.Queue(TThread.CurrentThread,
                procedure
                begin
                  BuscaDados(listaAtual.Text,nroThreads);
                end); }
         Tarefa.Start;
         //listaAtual.Text := '';
      //end;

      //TTask.WaitForAll(Tarefa);

      {ShowMessage('Nro Threads: '+inttostr(nroThreads+1));
      memo3.Lines.Text := '';
      for I := 0 to High(arrDados) do begin
        if TestMode.Checked then
          memo3.Lines.Add('Thread: '+ inttostr(i));
        memo3.Lines.Add(arrDados[i].Text)
      end;                   }

      //for I := 0 to High(tarefa)-1 do begin
      //  FreeAndNil(tarefa);
      //  FreeAndNil(arrDados);
      //end;
  listaAtual.Destroy;
end;



procedure TForm1.Button4Click(Sender: TObject);
var
dados, linkvideos, lista: tstringlist;
i,ii,g,j:integer;
grupo, nome, capa,link,linha: string;
begin
    dados := TStringList.Create;
    lista := TStringList.Create;

    dados.Text := memo3.Lines.Text;

    for I := 0 to dados.Count-1 do begin
      linha := dados[i];
      link := copy(linha,1,pos('@',linha)-1);
      linha := copy(linha,pos('@',linha)+1);
      capa := copy(linha,1,pos('@',linha)-1);
      linha := copy(linha,pos('@',linha)+1);
      nome := copy(linha,1,pos('@',linha)-1);
      linha := copy(linha,pos('@',linha)+1);
      grupo := linha;

      lista.Add('#EXTINF:-1 tvg-logo="'+capa+'" group-title="'+grupo+'",'+nome);
      lista.Add(link);

    end;


    memo4.Lines.Text := lista.Text;
    dados.Destroy;
    lista.Destroy;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
lista:tstringlist;
begin
     lista := TStringList.Create;

     lista.Add('#EXTM3U');

     lista.Add('#EXTINF:-1 tvg-logo="https://i.pinimg.com/280x280_RS/18/0b/72/180b721c6a9bc3efa678d1b87fd1b57e.jpg" group-title="Créditos",Créditos: Alexsandro Zanella');
     lista.Add('http://0.0.0.0');
     lista.Add('#EXTINF:-1 tvg-logo="https://i.pinimg.com/280x280_RS/18/0b/72/180b721c6a9bc3efa678d1b87fd1b57e.jpg" group-title="Créditos",WPP:+5554991245573');
     lista.Add('http://0.0.0.0');
     lista.Add('');
     lista.Add(memo4.Lines.Text);


     lista.SaveToFile('Zanella_Series.m3u8');

     lista.Destroy;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
    if PageControl1.ActivePage = TabSheet1 then begin
            //
    end else if PageControl1.ActivePage = TabSheet2 then begin

    end else if PageControl1.ActivePage = TabSheet3 then begin

    end;

end;

procedure TForm1.Button7Click(Sender: TObject);
begin
    memo3.Lines.Text := ListaDD.Text;
end;

end.
