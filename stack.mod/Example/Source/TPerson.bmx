Rem
	bbdoc: A simple example Type
EndRem
Type TPerson
	Field _age:Int
	Field _name:String


	Method ToString:String()
		Return _name + " (" + _age + ")"
	End Method

EndType
