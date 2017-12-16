unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynEdit, synhighlighterunixshellscript,
  SynHighlighterPerl, SynHighlighterPHP, SynHighlighterPython,
  SynHighlighterJScript, TreeFilterEdit, Forms, Controls, Graphics, Dialogs,
  ShellCtrls, ExtCtrls, ComCtrls, Menus, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    ShellTreeView1: TShellTreeView;
    Splitter1: TSplitter;
    SynEdit1: TSynEdit;
    SynJScriptSyn1: TSynJScriptSyn;
    SynPerlSyn1: TSynPerlSyn;
    SynPHPSyn1: TSynPHPSyn;
    SynPythonSyn1: TSynPythonSyn;
    SynUNIXShellScriptSyn1: TSynUNIXShellScriptSyn;
    Timer1: TTimer;
    TreeFilterEdit1: TTreeFilterEdit;
    procedure ComboBox1Select(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ShellTreeView1Collapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: boolean);
    procedure ShellTreeView1SelectionChanged(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
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

procedure TForm1.ComboBox1Select(Sender: TObject);
var
  t: string;
begin
  if Combobox1.ItemIndex > -1 then
    t := Combobox1.Items[Combobox1.ItemIndex];

  t := AnsiLowerCase(t);

  case t of
       'shell' : SynEdit1.Highlighter := SynUNIXShellScriptSyn1;
       'perl' : SynEdit1.Highlighter := SynPerlSyn1;
       'python' : SynEdit1.Highlighter := SynPythonSyn1;
       'php' : SynEdit1.Highlighter := SynPHPSyn1;
       'javascript' : SynEdit1.Highlighter := SynJScriptSyn1;
  end;
end;

procedure TForm1.ShellTreeView1Collapsing(Sender: TObject; Node: TTreeNode;
  var AllowCollapse: boolean);
begin
  AllowCollapse := False;
end;

procedure TForm1.ShellTreeView1SelectionChanged(Sender: TObject);
var
  filename: string;
begin
  filename := ShellTreeView1.Path;
  if not DirectoryExists(filename) then
  begin
    if FileExists(filename) then
    begin
      SynEdit1.Lines.Clear();
      SynEdit1.Lines.LoadFromFile(filename);
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ActiveControl := ShellTreeView1;
  Application.ProcessMessages;
  Timer1.Enabled := False;
end;

end.


