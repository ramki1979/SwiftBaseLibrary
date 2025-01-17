﻿
@Conditional("DEBUG") public func assert(condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = default, file: String = __FILE__, line: UWord = __LINE__) {
	if (!condition()) {
		fatalError(message, file, line)
	}
}

@Conditional("DEBUG") @noreturn public func assertionFailure(_ message: @autoclosure () -> String = default, file: String = __FILE__, line: UWord = __LINE__) {
	fatalError(message, file, line)
}

public __inline func debugPrint<T>(x: T) {
	print(toDebugString(x))
}

public __inline func debugPrintln<T>(x: T) {
	println(toDebugString(x))
}

@noreturn public func fatalError(_ message: @autoclosure () -> String = default, file: String = __FILE__, line: UInt32 = __LINE__) {
	if let message = message {
		__throw Exception(message()+", file "+file+", line "+line)
	} else {
		__throw Exception("Fatal Error, file "+file+", line "+line)
	}
}

@Conditional("DEBUG") public func precondition(condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = default, file: String = __FILE__, line: UWord = __LINE__) {
	if (!condition()) {
		fatalError(message, file, line)
	}
}

@Conditional("DEBUG") @noreturn public func preconditionFailure(_ message: @autoclosure () -> String = default, file: String = __FILE__, line: UWord = __LINE__) {
	fatalError(message, file, line)
}

public func println(object: Any? = nil) {
	if let unwrappedObject = object {
		writeLn(unwrappedObject)
	} else {
		writeLn()
	}
}

public func print(object: Any? = nil) {
	if let unwrappedObject = object {
		write(unwrappedObject)
	} 
}

public func swap<T>(inout a: T, inout b: T) {
	let temp = a
	a = b
	b = temp
}

public __inline func toDebugString<T>(x: T) -> String {
	#if COOPER
	return x.toString()
	#elseif ECHOES
	return x.ToString()
	#elseif NOUGAT
	if (debugDescription.respondsToSelector("debugDescription")) {
		return x.debugDescription
	}
	return x.description
	#endif
}

//@inline(never) func toString<T>(x: T) -> String
public __inline func toString<T>(x: T) -> String {
	#if COOPER
	return x.toString()
	#elseif ECHOES
	return x.ToString()
	#elseif NOUGAT
	return x.description
	#endif
}
