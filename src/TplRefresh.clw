!TplRefresh: refreshes template dialog window.
!Usage: TplRefresh.exe "Dialog Title"
!mikeduglas (c) 2020
!mikeduglas@yandex.ru, mikeduglas66@gmail.com
  
  PROGRAM

  INCLUDE('winapi.inc'), ONCE

  MAP
    INCLUDE('printf.inc'), ONCE

    Invalidate(STRING pWindowName)
  END

  CODE
!  printd('COMMAND(1)=%s', COMMAND(1))
  Invalidate(COMMAND(1))
  
Invalidate                  PROCEDURE(STRING pWindowName)
winMain                       TWnd
winChild                      TWnd
hwndParent                    HWND, AUTO
  CODE
  IF NOT pWindowName
    printd('Usage: TplRefresh.exe "Dialog Title" ')
    RETURN
  END
  
  !- find Main window
  IF winMain.FindWindow(pWindowName)
!    printd('Main hwnd %x', winMain.GetHandle())
    
    !- find 1st child window with class name ClaChildClient
    hwndParent = winMain.GetHandle()
    LOOP
      IF winChild.FindWindowEx(hwndParent, 0, '', '')
!        printd('Child hwnd %x', winChild.GetHandle())

        IF winChild.GetClassName() = 'ClaChildClient'
          !- redraw all controls
!          winChild.InvalidateRect(FALSE)
          winChild.InvalidateRect(TRUE)
          RETURN
        END
      
        !- next level
        hwndParent = winChild.GetHandle()
      ELSE
        !- no more children
        RETURN
      END
    END
  ELSE
    !- window with title pWindowName not found
    printd('Window "%s" not found', pWindowName)
  END
