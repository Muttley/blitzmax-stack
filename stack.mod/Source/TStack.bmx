Rem
'
' Copyright (c) 2009-2015 Paul Maskelyne <muttley@muttleyville.org>.
'
' All rights reserved. Use of this code is allowed under the
' Artistic License 2.0 terms, as specified in the LICENSE file
' distributed with this code, or available from
' http://www.opensource.org/licenses/artistic-license-2.0.php
'
EndRem

Rem
	bbdoc: Array based Stack implementation
End Rem
Type TStack

	' How much the stack should grow by if it needs to expand
	' to accomodate more objects
	Field _growSize:Int

	' The initial size when the stack was created
	Field _initialSize:Int

	' The objects in the stack
	Field _stackArray:Object[]

	' The index of the top entry on the stack
	Field _top:Int

	Rem
		bbdoc: Clears the stack
		about: The stack will remain the same size after it has been cleared, use
		the Shrink() method to reduce its size
	EndRem
	Method Clear()
		For Local i:Int = 0 Until _stackArray.Length
			_stackArray[i] = Null
		Next
		_top = -1
	EndMethod

	Rem
		bbdoc: Create a Stack with the specified initial and grow sizes
		about: If more objects are pushed to the stack than it can hold, it will
		automatically grow by the size you specify
	EndRem
	Function Create:TStack (size:Int, growSize:Int = 1)
		If size < 0
			Throw "Initial Stack size must be >= 0"
		EndIf

		If growSize < 1
			Throw "Stack grow size must be >= 1"
		EndIf

		Local stack:TStack = New TStack

		stack._initialSize = size
		stack._stackArray  = New Object[size]
		stack._growSize    = growSize

		Return stack
	EndFunction

	Rem
		bbdoc: Returns the number of objects on the stack
	EndRem
	Method GetCount:Int()
		Return _top + 1
	EndMethod

	Rem
		bbdoc: Returns the current size of the stack
	EndRem
	Method GetSize:Int()
		Return _stackArray.Length
	EndMethod

	Rem
		bbdoc: Grows the stack by the amount specified when the stack was created
	EndRem
	Method Grow()
		_stackArray = _stackArray[.. _stackArray.Length + _growSize]
	EndMethod

	Rem
		bbdoc: Default constructor
	EndRem
	Method New()
		_top = -1
		_growSize = 1
		_initialSize = 0
	EndMethod

	Rem
		bbdoc: Get the top object from the stack without removing it
	EndRem
	Method Peek:Object()
		Local o:Object = Null

		If _top >= 0
			o = _stackArray[_top]
		End If

		Return o
	EndMethod

	Rem
		bbdoc: Remove the top object from the stack and return it
	EndRem
	Method Pop:Object()
		Local o:Object = Null

		If _top >= 0
			o = _stackArray[_top]
			_stackArray[_top] = Null
			_top :- 1
		EndIf

		Return o
	EndMethod

	Rem
		bbdoc: Add the specified object to the top of the stack
	EndRem
	Method Push (o:Object)
		_top :+ 1

		If _top + 1 > _stackArray.Length
			Grow()
		EndIf

		_stackArray[_top] = o
	EndMethod

	Rem
		bbdoc: Shrinks the stack
		about: The stack is shrunk to the size of the amount of currently stored
		objects or it's initial size on construction, whichever is largest
	EndRem
	Method Shrink()
		Local shrinkSize:Int = 0

		If _top + 1 > _initialSize
			shrinkSize = _top + 1
		Else
			shrinkSize = _initialSize
		EndIf

		_stackArray = _stackArray[..shrinkSize]
	EndMethod

EndType
