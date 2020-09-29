#! Test template. Register it and add pxTestTplRefresh extension to WINDOW procedure.
#!
#TEMPLATE(TestTplRefresh,'Test TplRefresh'),FAMILY('ABC'),FAMILY('CW20')
#! --------------------------------------------------------------------------
#INCLUDE('TplRefresh.tpw')
#! --------------------------------------------------------------------------
#EXTENSION(pxTestTplRefresh, 'Test TplRefresh'),PROCEDURE
#RESTRICT
  #IF(%Window)
    #ACCEPT
  #ELSE
    #REJECT
  #ENDIF
#ENDRESTRICT
#BUTTON('All controls'),FROM(%Control,%Control &'<9>'& %lFriendlyName),INLINE,PROP(PROP:HScroll,1),PROP(PROP:Format,'100L(1)|M~Control~F500L(1)|M~Friendly name~')
  #DISPLAY('Set friendly name for '& %Control)
  #PROMPT('Friendly name:',@s255),%lFriendlyName
#ENDBUTTON
#BUTTON('Generate names'), WHENACCEPTED(%GenerateNames())
#ENDBUTTON
#BUTTON('Reset names'), WHENACCEPTED(%ResetNames())
#ENDBUTTON
#PROMPT('Use TplRefresh',CHECK),%UseTplRefresh,DEFAULT(%False),AT(10)
#BUTTON('Force Refresh'), WHENACCEPTED(%RefreshDialog('Test TplRefresh'))
#ENDBUTTON
#! --------------------------------------------------------------------------
#GROUP(%GenerateNames)
#FOR(%Control),WHERE(%lFriendlyName='')
  #SET(%lFriendlyName,SUB(%Control,2))
#ENDFOR
#IF(%UseTplRefresh)
  #CALL(%RefreshDialog, 'Test TplRefresh')
#ENDIF
#! --------------------------------------------------------------------------
#GROUP(%ResetNames)
#FOR(%Control)
  #CLEAR(%lFriendlyName)
#ENDFOR
#IF(%UseTplRefresh)
  #CALL(%RefreshDialog, 'Test TplRefresh')
#ENDIF
