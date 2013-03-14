Type TStackTests Extends TTest

	Const INITIAL_STACK_SIZE:Int = 10
	Const INITIAL_GROW_SIZE:Int  = 5

	Field _stack:TStack


	Method Setup() {before}
		_stack = TStack.Create (INITIAL_STACK_SIZE, INITIAL_GROW_SIZE)
	EndMethod



	Method CanInstantiateStack() {test}
		assertNotNull (New TStack)
	EndMethod



	Method CanCreateStackWithPositiveSize() {test}
		assertNotNull (TStack.Create (1))
	EndMethod



	Method StackIsCreatedWithCorrectSize() {test}
		assertEqualsI (_stack.GetSize(), INITIAL_STACK_SIZE)
	EndMethod



	Method StackIsCreatedWithCorrectGrowSize() {test}
		assertEqualsI (_stack._growSize, 5)
	EndMethod



	Method CannotCreateStackWithNegativeSize() {test}
		assertNull (TStack.Create (-10))
	EndMethod



	Method CannotCreateStackWithNegativeGrowSize() {test}
		assertNull (TStack.Create (INITIAL_STACK_SIZE, -5))
	EndMethod



	Method CanPushObject() {test}
		_stack.Push (New TStack)
	EndMethod



	Method CanPopObject() {test}
		_stack.Push (New TStack)
		assertNotNull (_stack.Pop())
	EndMethod



	Method CannotPopEmptyStack() {test}
		assertNull (_stack.Pop())
	EndMethod



	Method CorrectObjectIsPopped() {test}
		Local o:Object
		For Local i:Int = 0 Until INITIAL_STACK_SIZE
			o = New TStack
			_stack.Push (o)
		Next
		assertEquals (o, _stack.Pop())
	EndMethod



	Method CannotOverfillStack() {test}
		Local o:Object
		For Local i:Int = 0 To _stack.GetSize() + 10
			o = New TStack
			_stack.Push (o)
		Next
		assertEquals (o, _stack.Pop())
	EndMethod



	Method StackGrowsWhenNeeded() {test}
		Local o:Object
		For Local i:Int = 0 To _stack.GetSize()
			o = New TStack
			_stack.Push (o)
		Next
		assertTrue (INITIAL_STACK_SIZE < _stack.GetSize())
	EndMethod



	Method StackGrowsByTheCorrectAmount() {test}
		Local o:Object
		For Local i:Int = 0 To _stack.GetSize() + 1
			o = New TStack
			_stack.Push (o)
		Next
		assertEqualsI (INITIAL_STACK_SIZE + INITIAL_GROW_SIZE, _stack.GetSize())
	EndMethod



	Method CanPeekFromStack() {test}
		Local o:Object = New TStack
		_stack.Push (o)
		assertEquals (o, _stack.Peek())
	EndMethod



	Method CannotPeekFromEmptyStack() {test}
		assertNull (_stack.Peek())
	EndMethod



	Method ObjectsAreCorrectlyPopped() {test}
		Local objects:TStack[] = New TStack[INITIAL_STACK_SIZE]

		For Local i:Int = 0 Until INITIAL_STACK_SIZE
			objects[i] = New TStack
			_stack.Push (objects[i])
		Next

		For Local i:Int = INITIAL_STACK_SIZE - 1 To 0 Step - 1
			assertEquals (objects[i], _stack.Pop())
		Next
	EndMethod



	Method CanPushToStackCreatedWithNew() {test}
		Local myStack:TStack = New TStack
		Local o:Object = New TStack
		myStack.Push (o)
		assertEquals (o, myStack.Pop())
	EndMethod



	Method CanClearStack() {test}
		For Local i:Int = 0 Until INITIAL_STACK_SIZE
			_stack.Push (New TStack)
		Next
		_stack.Clear()
		For Local i:Int = 0 Until INITIAL_STACK_SIZE
			assertNull (_stack._stackArray[i])
		Next
	EndMethod



	Method CanShrinkStack() {test}
		For Local i:Int = 0 To INITIAL_STACK_SIZE + 10
			_stack.Push (New TStack)
		Next

		_stack.Clear()

		_stack.Shrink()

		assertEqualsI (INITIAL_STACK_SIZE, _stack.GetSize())
	EndMethod



	Method CanShrinkEmptyStack() {test}
		Local stack:TStack = New TStack
		stack.Shrink()
	EndMethod



	Method CanPushObjectsToAnEmptyStackThatHasBeenShrunk() {test}
		Local stack:TStack = New TStack
		stack.Shrink()
		stack.Push (New TStack)
		assertNotNull (stack.Pop())
	EndMethod



	Method CanCountEntriesOnStack() {test}
		_stack.GetCount()
	EndMethod



	Method CorrectEntriesCountOnStack() {test}
		For Local i:Int = 1 To 23
			_stack.Push (New TStack)
		Next
		For Local i:Int = 1 To 6
			_stack.Pop()
		Next
		assertEqualsI (17, _stack.GetCount())
	EndMethod

EndType
