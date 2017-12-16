unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynEdit, synhighlighterunixshellscript,
  TreeFilterEdit, Forms, Controls, Graphics, Dialogs, ShellCtrls, ExtCtrls,
  ComCtrls, Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    ShellListView1: TShellListView;
    ShellTreeView1: TShellTreeView;
    Splitter1: TSplitter;
    SynEdit1: TSynEdit;
    SynUNIXShellScriptSyn1: TSynUNIXShellScriptSyn;
    Timer1: TTimer;
    TreeFilterEdit1: TTreeFilterEdit;
    procedure FormActivate(Sender: TObject);
    procedure ShellListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: boolean);
    procedure ShellTreeView1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure GetFile;
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.FormActivate(Sender: TObject);
begin
  TreeFilterEdit1.FilteredTreeView := ShellTreeView1;
  ActiveControl := TreeFilterEdit1;
  Timer1.Interval := 1;
  Timer1.Enabled := True;

end;

procedure TForm1.GetFile;
var
  path, filename: string;
  SelItem: TListItem;
  sl: TStringList;
begin

  SelItem := ShellListView1.Selected;
  if SelItem <> nil then
  begin
    path := IncludeTrailingPathDelimiter(ShellTreeView1.Path);
    filename := path + SelItem.Caption;
    //ShowMessage('filename=' + path + filename);

    SynEdit1.Lines.LoadFromFile(filename);
  end;

end;


procedure TForm1.ShellListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: boolean);
begin
  GetFile();
end;

procedure TForm1.ShellTreeView1Click(Sender: TObject);
begin
  SynEdit1.Lines.Clear();
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ActiveControl := ShellTreeView1;
  Application.ProcessMessages;
  Timer1.Enabled := False;
end;

end.


