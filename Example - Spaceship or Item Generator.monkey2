#Import "<std>"
#Import "<mojo>"

Using std..
Using mojo..

Class item
	Field can:Canvas
	Field image:Image
	Field rot:Double
	Field rotspd:Double
	Method New()
		rot=Rnd(TwoPi)
		rotspd=Rnd(-0.1,0.1)
		image = New Image(48,48)
		can = New Canvas(image)
		image.Handle=New Vec2f( .5,.5 )
		can.Color = Color.None
		can.BlendMode=BlendMode.Opaque
		can.DrawRect(0,0,48,48)			
		makeimage()
	End Method
	Method makeimage()		
		For Local i:=0 Until 10
			Local a:Float=Rnd()
			can.Color = New Color(a,a,a)
			can.DrawTriangle(   New Vec2f(24+Rnd(-16,16),24+Rnd(-16,16)),
								New Vec2f(24+Rnd(-16,16),24+Rnd(-16,16)),
								New Vec2f(24+Rnd(-16,16),24+Rnd(-16,16)))
		Next
		can.Flush()
	End Method 
End Class 

Global myitem:List<item> = New List<item>

Class MyWindow Extends Window

	Method New()
		Super.New("Graphics Generator - Spaceships or Items",800,600)
		For Local y:=0 To 10
		For Local x:=0 To 10
			myitem.AddLast(New item())
		Next
		Next
	End Method
	
	Method OnRender( canvas:Canvas ) Override
		App.RequestRender() ' Activate this method 
		' if key escape then quit
		Local x:Int=0
		Local y:Int=0
		For Local i:=Eachin myitem
			canvas.DrawImage(i.image,x*48+96,y*48+32,i.rot)
			i.rot+=i.rotspd
			If i.rot<0 Then i.rot=TwoPi
			If i.rot>TwoPi Then i.rot=0
			x+=1
			If x>10 Then y+=1;x=0
		Next
		If Keyboard.KeyReleased(Key.Escape) Then App.Terminate()		
	End Method	
	
End	Class

Function Main()
	New AppInstance		
	New MyWindow
	App.Run()
End Function
