ControlFocus("Open","","Edit1")
Log($CmdLine[1])
ControlSetText("Open","","Edit1",$CmdLine[1])
ControlClick("Open","","Button1")