# TplRefresh
TplRefresh is an utility (exe file) that redraws template dialog window. This is useful if your extension
contains "#BUTTON,FROM(...),INLINE" (which is displayed as a listbox), and there is a code modifying button's PROMPTs.
For example, if you have 2 buttons...
```
#! listbox displaying all window controls and their "Friendly names" (blank by default)
#BUTTON('All controls'),FROM(%Control,%Control &'<9>'& %lFriendlyName),INLINE,PROP(PROP:HScroll,1),PROP(PROP:Format,'100L(1)|M~Control~F500L(1)|M~Friendly name~')
  #DISPLAY('Set friendly name for '& %Control)
  #PROMPT('Friendly name:',@s255),%lFriendlyName
#ENDBUTTON
  
#! button sets all blank friendly names to control labels without question mark
#BUTTON('Generate names'), WHENACCEPTED(%GenerateNames())
#ENDBUTTON
```
and %GenerateNames function:
```
#GROUP(%GenerateNames)
#FOR(%Control),WHERE(%lFriendlyName='')
  #SET(%lFriendlyName,SUB(%Control,2))
#ENDFOR
```
... and press 'Generate names' button, you'll see the listbox still displays blank friendly names, 
until you click on list rows.

To fix this issue:

1. Copy TplRefresh.exe to c:\Clarion11\accessory\bin folder.
2. Copy TplRefresh.tpw to c:\Clarion11\accessory\template\win folder and register it.
3. Add this line to your template:
```
#INCLUDE('TplRefresh.tpw')
```
4. Call %RefreshDialog function passing a dialog title (an extension description) as an argument:
```
#CALL(%RefreshDialog, 'My Procedure Extension')
```

So %GenerateNames function will look like this:
```
#GROUP(%GenerateNames)
#FOR(%Control),WHERE(%lFriendlyName='')
  #SET(%lFriendlyName,SUB(%Control,2))
#ENDFOR
#! Refresh dialog
#CALL(%RefreshDialog, 'Test TplRefresh')
```
and the listbox will be refreshed immediately.

template\TestTplRefresh.tpl is a template sample to reproduce the issue and show how to fix it.

