CHANGELOG
=========






2014/08/27
----------

-	Now `UNIVERSE_DEBUG_RUN_FOR_EACH` macro accepts `id` parameter without requiring `NSFastEnumeration`.
	And checks conformance at runtime. Non-conforming object will cause an exception in debug mode.
	
-	Now `UNIVERSE_DEBUG_ASSERT_PROTOCOL_CONFORMANCE` accepts any type object by casting them into `id`.
	This implies the object is a `NSObject` subclass.