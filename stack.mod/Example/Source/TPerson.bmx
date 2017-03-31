Rem
'
' Copyright (c) 2009-2017 Paul Maskelyne <muttley@muttleyville.org>.
'
' All rights reserved. Use of this code is allowed under the
' Artistic License 2.0 terms, as specified in the LICENSE file
' distributed with this code, or available from
' http://www.opensource.org/licenses/artistic-license-2.0.php
'
EndRem

Rem
	bbdoc: A simple example Type
EndRem
Type TPerson

	Field _age:Int
	Field _name:String

	Method ToString:String()
		Return _name + " (" + _age + ")"
	EndMethod

EndType
