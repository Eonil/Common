CHANGELOG
=========






2014/08/27
----------

-	Now `UNIVERSE_DEBUG_RUN_FOR_EACH` macro accepts `id` parameter without requiring `NSFastEnumeration`.
	And checks conformance at runtime. Non-conforming object will cause an exception in debug mode.