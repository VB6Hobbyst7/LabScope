VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cLScope"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


'Graphic methods
Private Declare PtrSafe Function CreateCompatibleDC Lib "gdi32" (ByVal hDC As LongPtr) As LongPtr
Private Declare PtrSafe Function GetDC Lib "user32" (ByVal hWnd As LongPtr) As LongPtr
Private Declare PtrSafe Function ReleaseDC Lib "user32" (ByVal hWnd As LongPtr, ByVal hDC As LongPtr) As LongPtr
Private Declare PtrSafe Function SelectObject Lib "gdi32" (ByVal hDC As LongPtr, ByVal hObject As LongPtr) As Long
Private Declare PtrSafe Function MoveToEx Lib "gdi32" (ByVal hDC As LongPtr, ByVal x As Long, ByVal y As Long, ByVal lpPoint As LongPtr) As Boolean
Private Declare PtrSafe Function LineTo Lib "gdi32" (ByVal hDC As LongPtr, ByVal x As Long, ByVal y As Long) As Boolean
Private Declare PtrSafe Function DeleteDC Lib "gdi32" (ByVal hDC As LongPtr) As Long
Private Declare PtrSafe Function GetDIBits Lib "gdi32" (ByVal hDC As LongPtr, ByVal hbmp As LongPtr, ByVal uStartScan As Long, ByVal cScanLines As Long, ByVal lpvBits As LongPtr, ByRef lpbi As Any, ByVal uUsage As Long) As Long
Private Declare PtrSafe Function SetDIBits Lib "gdi32" (ByVal hDC As LongPtr, ByVal hbmp As LongPtr, ByVal uStartScan As Long, ByVal cScanLines As Long, ByVal lpvBits As LongPtr, ByRef lpbmi As Any, ByVal fuColorUse As Long) As Long
Private Declare PtrSafe Function GetDeviceCaps Lib "gdi32" (ByVal hDC As LongPtr, ByVal nIndex As Long) As Long
Private Declare PtrSafe Function BitBlt Lib "gdi32" (ByVal hdcDest As LongPtr, ByVal nXDest As Long, ByVal nYDest As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hdcSrc As LongPtr, ByVal nXSrc As Long, ByVal nYSrc As Long, ByVal dwRop As Long) As Boolean
Private Declare PtrSafe Function StretchBlt Lib "gdi32" (ByVal hdcDest As LongPtr, ByVal nXOriginDest As Long, ByVal nYOriginDest As Long, ByVal nWidthDest As Long, ByVal nHeightDest As Long, ByVal hdcSrc As LongPtr, ByVal nXOriginSrc As Long, ByVal nYOriginSrc As Long, ByVal nWidthSrc As Long, ByVal nHeightSrc As Long, ByVal dwRop As Long) As Boolean
Private Declare PtrSafe Function CreateCompatibleBitmap Lib "gdi32" (ByVal hDC As LongPtr, ByVal nWidth As Long, ByVal nHeight As Long) As LongPtr
Private Declare PtrSafe Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As LongPtr
Private Declare PtrSafe Function DeleteObject Lib "gdi32" (ByVal hObject As LongPtr) As Boolean
Private Declare PtrSafe Function CreatePen Lib "gdi32" (ByVal fnPenStyle As Long, ByVal nWidth As Long, ByVal crColor As Long) As LongPtr
Private Declare PtrSafe Function GetSysColor Lib "user32" (ByVal nIndex As Long) As Long
Private Declare PtrSafe Function Ellipse Lib "gdi32" (ByVal hDC As LongPtr, ByVal nLeftRect As Long, ByVal nTopRect As Long, ByVal nRightRect As Long, ByVal nBottomRect As Long) As Boolean
Private Declare PtrSafe Function GetStockObject Lib "gdi32" (ByVal fnObject As Long) As LongPtr
Private Declare PtrSafe Function OleCreatePictureIndirect Lib "oleaut32.dll" (PicDesc As PICTDESC, RefIID As GUID, ByVal fPictureOwnsHandle As LongPtr, IPic As IPicture) As LongPtr
Private Declare PtrSafe Function Rectangle Lib "gdi32" (ByVal hDC As LongPtr, ByVal nLeftRect As Long, ByVal nTopRect As Long, ByVal nRightRect As Long, ByVal nBottomRect As Long) As Boolean
Private Declare PtrSafe Function TabbedTextOut Lib "user32" Alias "TabbedTextOutW" (ByVal hDC As LongPtr, ByVal x As Long, ByVal y As Long, ByVal lpString As String, ByVal nCount As Long, ByVal nTabPositions As Long, ByRef lpnTabStopPositions As Any, ByVal nTabOrigin As Long) As Long
Private Declare PtrSafe Function SetBkMode Lib "gdi32" (ByVal hDC As LongPtr, ByVal iBkMode As Long) As Long
Private Declare PtrSafe Function Polygon Lib "gdi32" (ByVal hDC As LongPtr, ByVal lpPoints As LongPtr, ByVal nCount As Long) As Boolean
Private Declare PtrSafe Function SetTextColor Lib "gdi32" (ByVal hDC As LongPtr, ByVal crColor As Long) As Long

'Memory management methods
Private Declare PtrSafe Function HeapCreate Lib "kernel32" (ByVal flOptions As Long, ByVal dwInitialSize As Long, ByVal dwMaximumSize As Long) As LongPtr
Private Declare PtrSafe Function HeapAlloc Lib "kernel32" (ByVal hHeap As LongPtr, ByVal dwFlags As Long, ByVal dwBytes As Long) As LongPtr
Private Declare PtrSafe Function HeapFree Lib "kernel32" (ByVal hHeap As LongPtr, ByVal dwFlags As Long, ByVal lpMem As LongPtr) As Boolean
Private Declare PtrSafe Function HeapDestroy Lib "kernel32" (ByVal hHeap As LongPtr) As Boolean

Private Declare PtrSafe Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hWnd As LongPtr, ByVal lpString As LongPtr, ByVal nMaxCount As Long) As Long
Private Declare PtrSafe Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As LongPtr




Private pParent As Object
Private pDisplaySurface As MSForms.Image
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'Property variables
Private pForeColor As Long
Private pPadding As Long
Private pLineWidth As Long
Private pDivisions As Long
Private pReticleSize As Double
Private pReticleColor As Long
Private pUnitsPrDivision As Double
Private pHitLabL As Double
Private pTgtLabL As Double
Private pTgtLabA As Double
Private pTgtLabB As Double
Private pLabExaggeration As Double
Private pScrollBeyondLimit As Boolean
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private hHeap As LongPtr

Private hDcDisplaySurface As LongPtr
Private hDcDrawing As LongPtr
Private hDcBackground As LongPtr
Private hDcLabSurface As LongPtr

Private bmpLabSurfaceOrig As LongPtr
Private bmpBackgroundOrig As LongPtr

Private ReticleBrush As LongPtr
Private ForegroundPen As LongPtr
Private LightPen As LongPtr

Private bmpDrawingOrig As LongPtr
Private bmpLabSurface As LongPtr
Private bmpBackground As LongPtr
Private bmpDrawing As LongPtr

Private hWndForm As LongPtr
Private GlobalRect As RECT
Private LocalRect As RECT
Private CenterPixelX As Long
Private CenterPixelY As Long
Private pxWidth As Long
Private pxHeight As Long
Private ReticleSizeHalf As Double
Private TgtLmin As Double
Private TgtLmax As Double

Private bi As BITMAPINFO
Private HitTriangle(0 To 2) As POINT






''''''''''''''''''''''
' HitLabL property
''''''''''''''''''''''
Public Property Get HitLabL() As Double
    HitLabL = pHitLabL
End Property
Public Property Let HitLabL(value As Double)
    pHitLabL = value
    RedrawControl
End Property

''''''''''''''''''''''
' Foreground color property
''''''''''''''''''''''
Public Property Get ForeColor() As Double
    ForeColor = pForeColor
End Property
Public Property Let ForeColor(value As Double)
    pForeColor = value
    DeleteObject (ForegroundPen)
    ForegroundPen = CreatePen(PS_Solid, pLineWidth, pForeColor)
    Draw_Background
    RedrawControl
End Property




''''''''''''''''''''''
' Padding property
''''''''''''''''''''''
Public Property Get Padding() As Double
    Padding = pPadding
End Property
Public Property Let Padding(value As Double)
    If value < pxWidth / 2 Then pPadding = value _
                         Else pPadding = pxWidth / 2
    DefineDimensions
    CalculateLabSpace
    Draw_Background
    RedrawControl
End Property





''''''''''''''''''''''
' LineWidth property
''''''''''''''''''''''
Public Property Get LineWidth() As Double
    LineWidth = pLineWidth
End Property
Public Property Let LineWidth(value As Double)
    pLineWidth = value
    DeleteObject (ForegroundPen)
    ForegroundPen = CreatePen(PS_Solid, pLineWidth, pForeColor)
    Draw_Background
    RedrawControl
End Property

''''''''''''''''''''''
' Divisions property
''''''''''''''''''''''
Public Property Get Divisions() As Double
    Divisions = pDivisions
End Property
Public Property Let Divisions(value As Double)
    pDivisions = value
    CalculateLabSpace
    DefineDimensions
    Draw_Background
    RedrawControl
End Property

''''''''''''''''''''''
' Reticlesize property
''''''''''''''''''''''
Public Property Get ReticleSize() As Double
    ReticleSize = pReticleSize
End Property
Public Property Let ReticleSize(value As Double)
    pReticleSize = value
    ReticleSizeHalf = pReticleSize / 2
    RedrawControl
End Property

''''''''''''''''''''''
' TgtLabL property
''''''''''''''''''''''
Public Property Get TgtLabL() As Double
    TgtLabL = pTgtLabL
End Property
Public Property Let TgtLabL(value As Double)
    pTgtLabL = value
    CalculateLabSpace
    Draw_Background
    RedrawControl
End Property
''''''''''''''''''''''
' TgtLabA property
''''''''''''''''''''''
Public Property Get TgtLabA() As Double
    TgtLabA = pTgtLabA
End Property
Public Property Let TgtLabA(value As Double)
    pTgtLabA = value
    CalculateLabSpace
    Draw_Background
    RedrawControl
End Property
''''''''''''''''''''''
' TgtLabB property
''''''''''''''''''''''
Public Property Get TgtLabB() As Double
    TgtLabB = pTgtLabB
End Property
Public Property Let TgtLabB(value As Double)
    pTgtLabB = value
    CalculateLabSpace
    Draw_Background
    RedrawControl
End Property


''''''''''''''''''''''
' LabExaggeration property
''''''''''''''''''''''
Public Property Get LabExaggeration() As Double
    LabExaggeration = pLabExaggeration
End Property
Public Property Let LabExaggeration(value As Double)
    pLabExaggeration = value
    CalculateLabSpace
    Draw_Background
    RedrawControl
End Property


''''''''''''''''''''''
' UnitsPrDivision property
''''''''''''''''''''''
Public Property Get UnitsPrDivision() As Double
    UnitsPrDivision = pUnitsPrDivision
End Property
Public Property Let UnitsPrDivision(value As Double)
    If value > 0 Then pUnitsPrDivision = value _
                 Else Err.Raise vbObjectError + errInvalidPropertyValue, "cScope.UnitsPrDivision", "UnitsPrDivision should be a double greater than 0"
    
    DefineDimensions
    CalculateLabSpace
    Draw_Background
    RedrawControl
End Property

''''''''''''''''''''''
' ScrollBeyondLimit property
''''''''''''''''''''''
Public Property Get ScrollBeyondLimit() As Double
    ScrollBeyondLimit = pScrollBeyondLimit
End Property
Public Property Let ScrollBeyondLimit(value As Double)
    pScrollBeyondLimit = value
    CalculateLabSpace
    Draw_Background
    RedrawControl
End Property


Public Sub InitiateProperties(ByRef Parent As Object, _
                              ByRef DisplaySurface As MSForms.Image, _
                              Optional HitLabL As Double = 60#, _
                              Optional ForeColor As Long = &H80000012, _
                              Optional ReticleColor As Long = &HFF7F00, _
                              Optional Padding As Long = 5&, _
                              Optional Divisions As Long = 6&, _
                              Optional UnitsPrDivision As Double = 5#, _
                              Optional TgtLabL As Double = 60#, _
                              Optional TgtLabA As Double = 0#, _
                              Optional TgtLabB As Double = 0#, _
                              Optional LabExaggeration As Double = 2#, _
                              Optional ScrollBeyondLimit As Boolean = True)
Dim bufferSize As Long
Dim result As Long
    hHeap = HeapCreate(0, 0, 0)  ' Create a heap memory object to be used for allocating memory to usercontrol images (Max size 2^23 = 8Mb)
    
    'Set connection between me and my display surface
    Set pParent = Parent
    Set pDisplaySurface = DisplaySurface
    
    'Set properties
    pHitLabL = HitLabL
    pForeColor = ForeColor
    pReticleColor = ReticleColor
    pPadding = Padding
    pDivisions = Divisions
    pUnitsPrDivision = UnitsPrDivision
    pTgtLabL = TgtLabL
    pTgtLabA = TgtLabA
    pTgtLabB = TgtLabB
    pLabExaggeration = LabExaggeration
    pScrollBeyondLimit = ScrollBeyondLimit


    'Convert system colors to RGB values
    If (pForeColor And &H80000000) = &H80000000 Then pForeColor = GetSysColor(pForeColor And &HFFFFFFF)      'Convert system color to RGB
    If (pReticleColor And &H80000000) = &H80000000 Then pReticleColor = GetSysColor(pReticleColor And &HFFFFFFF)      'Convert system color to RGB
    

    
    'Create a Device Context to draw on and allocate memory for background image
    Find_Window_handle
    hDcDisplaySurface = GetDC(hWndForm)
    hDcDrawing = CreateCompatibleDC(0)            ' Create DeviceContext that matches the screen that image1 is shown on
    hDcBackground = CreateCompatibleDC(0)         ' Create DeviceContext that matches the screen that image1 is shown on
    hDcLabSurface = CreateCompatibleDC(0)
    
    SetBkMode hDcBackground, BkMode.TRANSPARENT
    
    DefineDimensions 'Set the controls dimensions. Requires hDcDrawing to be initialised
    
    bmpDrawing = CreateCompatibleBitmap(hDcDisplaySurface, pxWidth, pxHeight)  'This line creates a blank bitmap for doublebuffered drawing compatible with pDisplaySurface
    bmpBackground = CreateCompatibleBitmap(hDcDisplaySurface, pxWidth, pxHeight) 'This line creates a blank bitmap for background compatible with pDisplaySurface
    bmpLabSurface = CreateCompatibleBitmap(hDcDisplaySurface, 1, 100) 'This line creates a blank bitmap for background compatible with pDisplaySurface
    Set pDisplaySurface.Picture = HandleToPicture(bmpDrawing, PICTYPE_BITMAP)
    
    
    ReticleBrush = CreateSolidBrush(pReticleColor)
    ForegroundPen = CreatePen(PS_Solid, 1, pForeColor)
    LightPen = CreatePen(PS_Solid, pLineWidth, RGB(255, 255, 255))

    
    'Create the background for the control
    CalculateLabSpace
    Draw_Background
    RedrawControl
End Sub



Private Sub Class_Terminate()
    'Clean up
    HeapDestroy hHeap                  ' Heap memory object
    
    DeleteObject ReticleBrush
    DeleteObject ForegroundPen
    DeleteObject LightPen
    
    DeleteObject bmpDrawing
    DeleteObject bmpBackground
    DeleteObject bmpLabSurface

    ReleaseDC hWndForm, hDcDisplaySurface
    DeleteDC hDcDrawing
    DeleteDC hDcBackground                       ' Gdi32 Device Context created earlier
    DeleteDC hDcLabSurface                       ' Gdi32 Device Context created earlier
End Sub





Public Sub RedrawControl()
    Dim result As Long
    Dim i As Integer
    'Point the Device Context at a copy of the original background picture

    bmpDrawingOrig = SelectObject(hDcDrawing, bmpDrawing)
    bmpBackgroundOrig = SelectObject(hDcBackground, bmpBackground)
   
    result = BitBlt(hDcDrawing, 0, 0, pxWidth, pxHeight, hDcBackground, 0, 0, SRCCOPY)


    'Redraw the control
    Dim BrushDrawingOrig As LongPtr
    Dim hitPixelY As Long
    hitPixelY = r2r(TgtLmin, TgtLmax, pHitLabL, pxHeight - pPadding, pPadding)
   
    BrushDrawingOrig = SelectObject(hDcDrawing, ReticleBrush)
    HitTriangle(0).x = CenterPixelX + pReticleSize
    HitTriangle(0).y = hitPixelY
    HitTriangle(1).x = CenterPixelX + 0.866025403784439 * pReticleSize + pReticleSize
    HitTriangle(1).y = hitPixelY - ReticleSizeHalf
    HitTriangle(2).x = CenterPixelX + 0.866025403784439 * pReticleSize + pReticleSize
    HitTriangle(2).y = hitPixelY + ReticleSizeHalf
    result = Polygon(hDcDrawing, VarPtr(HitTriangle(0)), 3)
    
    SelectObject hDcDrawing, BrushDrawingOrig
    
    
    'Draw text
    Dim TabStops(1 To 1) As Long
    TabStops(1) = 60
    Dim s As String
    Dim sW As String
    
    SetBkMode hDcDrawing, BkMode.TRANSPARENT
    
    s = "Hit L*" & vbTab & Format(pHitLabL, "0.00")
    sW = StrConv(s, vbUnicode)
    result = TabbedTextOut(hDcDrawing, 0, pxHeight - 20, sW, Len(s), 1, TabStops(1), 0)
    
    result = BitBlt(hDcDisplaySurface, GlobalRect.topleft.x, GlobalRect.topleft.y, pxWidth, pxHeight, hDcDrawing, 0, 0, SRCCOPY)
    
    SelectObject hDcDrawing, bmpDrawingOrig
    SelectObject hDcBackground, bmpBackgroundOrig
End Sub


Private Sub DefineDimensions()
Dim xPixPrPt As Double
Dim yPixPrPt As Double

    
    'Set Scope rectangle for use when invalidating paint area
    xPixPrPt = GetDeviceCaps(hDcDrawing, LOGPIXELSX) / 72
    yPixPrPt = GetDeviceCaps(hDcDrawing, LOGPIXELSY) / 72
    GlobalRect.topleft.x = pDisplaySurface.Left * xPixPrPt
    GlobalRect.topleft.y = pDisplaySurface.Top * yPixPrPt
    GlobalRect.btmRight.x = (pDisplaySurface.Left + pDisplaySurface.Width) * xPixPrPt
    GlobalRect.btmRight.y = (pDisplaySurface.Top + pDisplaySurface.Height) * yPixPrPt
    
    pxWidth = pDisplaySurface.Width * xPixPrPt
    pxHeight = pDisplaySurface.Height * yPixPrPt
    CenterPixelX = pxWidth / 2
    CenterPixelY = pxHeight / 2
    
    LocalRect.topleft.x = 0
    LocalRect.topleft.y = 0
    LocalRect.btmRight.x = pxWidth
    LocalRect.btmRight.y = pxHeight
    
    
    pReticleSize = 20
    ReticleSizeHalf = 10
                    
End Sub

Sub SetColors(TgtLabL As Double, TgtLabA As Double, TgtLabB As Double, HitLabL As Double)
    pTgtLabL = TgtLabL
    pTgtLabA = TgtLabA
    pTgtLabB = TgtLabB
    pHitLabL = HitLabL
    
    CalculateLabSpace
    Draw_Background
    RedrawControl
End Sub

Private Sub Find_Window_handle()
Dim s As String
Dim pS As LongPtr
Dim strLength As Long
    pS = HeapAlloc(hHeap, 0, 255)

    hWndForm = FindWindow("ThunderDFrame", pParent.Caption)
    strLength = GetWindowText(hWndForm, pS, 255)
    
    s = Mem_ReadString(pS, strLength)
    
    HeapFree hHeap, 0, pS
End Sub


Private Sub Draw_Background()
Dim result As Long
Dim i As Integer
    Dim BrushBackgroundOrig As LongPtr
    Dim PenBackgroundOrig As LongPtr
    Dim backgroundGradient As LongPtr
    Dim r As Long
    Dim c As Long
                    

   
    
    'Draw the gradient background
    Dim BytesPrScanline As Long
    Dim RGBtuple(0 To 3) As Byte
    bi.bmiHeader.biSize = Len(bi.bmiHeader)

    
    result = GetDIBits(hDcLabSurface, bmpLabSurface, 0, 0, 0, bi, DIB_RGB_COLORS)
    BytesPrScanline = Ceiling(bi.bmiHeader.biWidth * bi.bmiHeader.biBitCount / 8, 8) 'Number of Double Words to each line.
    
    backgroundGradient = HeapAlloc(hHeap, 0, BytesPrScanline * bi.bmiHeader.biHeight)
    
    result = GetDIBits(hDcLabSurface, bmpLabSurface, 0, bi.bmiHeader.biHeight, backgroundGradient, bi, DIB_RGB_COLORS)
    
    Dim yFract As Double
    Dim tgtLabLRange As Double
    Dim LabL As Double
    Dim sR As Double
    Dim sG As Double
    Dim sB As Double
    
   
    tgtLabLRange = TgtLmax - TgtLmin
    For r = 0 To 99
        yFract = r / 99
        LabL = TgtLabL + pLabExaggeration * (TgtLmin + yFract * tgtLabLRange - TgtLabL)

        LAB2sRGB LabL, pTgtLabA, pTgtLabB, sR, sG, sB
        RGBtuple(0) = sB 'Blue
        RGBtuple(1) = sG 'Green
        RGBtuple(2) = sR 'Red
        RGBtuple(3) = &H0  '***Reserved***
        Mem_Copy ByVal backgroundGradient + r * 4, RGBtuple(0), 4
    Next r
    


    result = SetDIBits(hDcLabSurface, bmpLabSurface, 0, bi.bmiHeader.biHeight, backgroundGradient, bi, DIB_RGB_COLORS)
    
    
    bmpBackgroundOrig = SelectObject(hDcBackground, bmpBackground)
    bmpLabSurfaceOrig = SelectObject(hDcLabSurface, bmpLabSurface)
    
    
    result = StretchBlt(hDcBackground, 0, 0, pxWidth, pxHeight, hDcLabSurface, 0, 0, 1, 100, SRCCOPY)

    HeapFree hHeap, 0, backgroundGradient
    
    
    Dim TransparentBrush As LongPtr
    TransparentBrush = GetStockObject(NULL_BRUSH And &HFFFFFFF)
    BrushBackgroundOrig = SelectObject(hDcBackground, TransparentBrush)
    
    If pTgtLabL >= 30 Then
        PenBackgroundOrig = SelectObject(hDcBackground, ForegroundPen)
        result = SetTextColor(hDcBackground, pForeColor)
    Else
        PenBackgroundOrig = SelectObject(hDcBackground, LightPen)
        result = SetTextColor(hDcBackground, &HFFFFFF)
    End If
    
    If pTgtLabL >= 45 Then
        result = SetTextColor(hDcDrawing, pForeColor)
    Else
        result = SetTextColor(hDcDrawing, &HFFFFFF)
    End If
    
    
    Dim tgtPixelY As Long
    tgtPixelY = r2r(TgtLmin, TgtLmax, pTgtLabL, pxHeight - Padding, Padding)
    'Draw the target

    result = Ellipse(hDcBackground, CenterPixelX - ReticleSizeHalf, _
                                    tgtPixelY - ReticleSizeHalf, _
                                    CenterPixelX + ReticleSizeHalf, _
                                    tgtPixelY + ReticleSizeHalf)
        'Target V line
    MoveToEx hDcBackground, CenterPixelX, tgtPixelY - 2 * ReticleSizeHalf, 0
    LineTo hDcBackground, CenterPixelX, tgtPixelY + 2 * ReticleSizeHalf
    
        'Target H line
    MoveToEx hDcBackground, CenterPixelX - 2 * ReticleSizeHalf, tgtPixelY, 0
    LineTo hDcBackground, CenterPixelX + 2 * ReticleSizeHalf, tgtPixelY
    
    
    'Draw vBar with Divisions
    MoveToEx hDcBackground, pPadding, pPadding, 0
    LineTo hDcBackground, pPadding, pxHeight - pPadding
    
    Dim minTickY As Double
    Dim y As Double
    Dim x As Double
    Dim L As Double
    
    minTickY = pTgtLabL - pUnitsPrDivision * Int((pTgtLabL - TgtLmin) / pUnitsPrDivision)
    For i = 0 To pDivisions
        L = i * pUnitsPrDivision + minTickY
        y = r2r(TgtLmin, TgtLmax, L, pxHeight - pPadding, pPadding)
        x = r2r(0, pUnitsPrDivision * pDivisions, Abs(pTgtLabL - L), pPadding + 10, pxWidth)
        
        MoveToEx hDcBackground, pPadding, y, 0
        LineTo hDcBackground, x, y
    Next i
    
    
    
    
    'Draw text
    Dim TabStops(1 To 1) As Long
    TabStops(1) = 60
    Dim s As String
    Dim sW As String
    
    s = ChrW(&H394) & "E/div" & vbTab & Format(UnitsPrDivision, "0.00")
    sW = StrConv(s, vbUnicode)
    result = TabbedTextOut(hDcBackground, 0, 0, sW, Len(s), 1, TabStops(1), 0)

    s = "Clr Xag" & vbTab & Format(pLabExaggeration, "0.00")
    sW = StrConv(s, vbUnicode)
    result = TabbedTextOut(hDcBackground, 0, 20, sW, Len(s), 1, TabStops(1), 0)

    s = "Tgt L*" & vbTab & Format(pTgtLabL, "0.00")
    sW = StrConv(s, vbUnicode)
    result = TabbedTextOut(hDcBackground, 0, 40, sW, Len(s), 1, TabStops(1), 0)

    
 
    
    
    'Draw border
    If pDisplaySurface.BorderStyle = fmBorderStyleSingle Then
        Rectangle hDcBackground, 0, 0, pxWidth, pxHeight
    End If
    
    SelectObject hDcBackground, bmpBackgroundOrig
    SelectObject hDcLabSurface, bmpLabSurfaceOrig
    
    SelectObject hDcBackground, BrushBackgroundOrig
    SelectObject hDcBackground, PenBackgroundOrig

End Sub

Sub CalculateLabSpace()
    Dim tgtLrange As Double
  
    tgtLrange = pDivisions * pUnitsPrDivision
    
    If (Not pScrollBeyondLimit) And ((pTgtLabL - tgtLrange / 2) < 0) Then
        'Offset due to target beeing close to lower end
        TgtLmin = 0
    
    ElseIf (Not pScrollBeyondLimit) And ((pTgtLabL + tgtLrange / 2) > 100) Then
        'Offset due to target beeing close to upper end
        TgtLmin = 100 - tgtLrange

    Else
        'No offset
        TgtLmin = pTgtLabL - tgtLrange / 2
    End If
    
    TgtLmax = TgtLmin + tgtLrange
End Sub

Function r2r(sourceMin As Double, sourceMax As Double, sourceValue As Double, ByVal targetMin As Double, ByVal targetMax As Double) As Double
    'Range to Range - Returns a value a value from a source range to a target range
    r2r = (targetMax - targetMin) * (sourceValue - sourceMin) / (sourceMax - sourceMin) + targetMin
End Function




''------------------------------------------------------
' Procedure : HandleToPicture
' Purpose   : Creates a StdPicture object to wrap a GDI
'             image handle
' Credit    : Eduardo A. Morcillo @ https://www.mvps.org/emorcillo/en/code/vb6/loadimagegdip.shtml
'------------------------------------------------------
'
Private Function HandleToPicture( _
   ByVal hGDIHandle As LongPtr, _
   ByVal ObjectType As PictureTypeConstants, _
   Optional ByVal hPal As LongPtr = 0) As StdPicture
Dim tPictDesc As PICTDESC
Dim IID_IPicture As GUID
Dim oPicture As IPicture
    
   ' Initialize the PICTDESC structure
   With tPictDesc
      .cbSizeOfStruct = Len(tPictDesc)
      .picType = ObjectType
      .hgdiObj = hGDIHandle
      .hPalOrXYExt = hPal
   End With
    
   ' Initialize the IPicture interface ID
   With IID_IPicture
      .Data1 = &H7BF80981
      .Data2 = &HBF32
      .Data3 = &H101A
      .Data4(0) = &H8B
      .Data4(1) = &HBB
      .Data4(3) = &HAA
      .Data4(5) = &H30
      .Data4(6) = &HC
      .Data4(7) = &HAB
   End With
    
   ' Create the object
   OleCreatePictureIndirect tPictDesc, IID_IPicture, _
                            True, oPicture
    
   ' Return the picture object
   Set HandleToPicture = oPicture
        
End Function

Private Function Ceiling(ByVal x As Double, Optional ByVal Factor As Double = 1) As Double
    ' X is the value you want to round
    ' is the multiple to which you want to round
    Ceiling = (Int(x / Factor) - (x / Factor - Int(x / Factor) > 0)) * Factor
End Function

Private Function Min(ParamArray values() As Variant) As Variant
   Dim minValue, value As Variant
   minValue = values(0)
   For Each value In values
       If value < minValue Then minValue = value
   Next
   Min = minValue
End Function

Private Function Max(ParamArray values() As Variant) As Variant
   Dim maxValue, value As Variant
   maxValue = values(0)
   For Each value In values
       If value > maxValue Then maxValue = value
   Next
   Max = maxValue
End Function
