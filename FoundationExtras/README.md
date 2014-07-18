README
======







`Basic~` series classes
-----------------------
`Basic~` series classes are provided for easier coding.
Cocoa does not provide proper debug-mode-assertions. 
It does not check program state, input type and state.
And then, it just let the program to be corrupted.

Basic classes provides a little modified behaviors.

-	This provides runtime type assertions. 
-	Also state assertions.
-	This reject any bad practices. 
-	This provides far more clear type safety. 
-	Many of `id` type properties will be redefined as proper types. 
-	This marks obsolete methods as deprecated. 
-	This marks impractical methods as deleted. 
-	Also checks calling of the methods.

The goal of Basic classes is providing best safety and debuggability
with least behavioral modification. You almost can use Basic classes
just like its superclass. Though I will keep behavioral modification
to minimum, but there should be some differences. If there's any 
noticeable difference, it will be noted on the class documentation.
Plesse refer the classes.

Also calling initializer is strictly **limited to only once** per an 
instance just right after allocating it. (debug mode asserted) This 
is providing a **guarantee**, then you can rely on this guarantee when
you subclassing/using `Basic~` series classes.



Designated initializer
----------------------
`Basic~` series classes mostly uses same method of original super class
as designated initializer to prevent confusion. If you need to provide
initialization, then override the designated initializer of the superclass.
There's some exceptions, and the exceptions are specifically documented.

Calling to alloc/init pattern is discouraged, and it's recommended to 
use `+instantiation~` factory method series where available.
Anyway `+instantiation~` series methods are always convenient factory method,
and not a designated constructor. Then you shouldn't override the
 `+instantiation` method to provide initialization.