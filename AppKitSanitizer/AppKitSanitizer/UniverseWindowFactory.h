//
//  UniverseWindowFactory.h
//  Spacetime
//
//  Created by Hoon H. on 14/5/26.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "BasicWindow.h"
#import "BasicPanel.h"

@interface UniverseWindowFactory : BasicObject
+ (BasicWindow*)typicalWindow;
+ (BasicPanel*)typicalToolPanel;
+ (id)alloc UNIVERSE_UNAVAILABLE_METHOD;
- (id)init UNIVERSE_UNAVAILABLE_METHOD;
+ (instancetype)instantiation UNIVERSE_UNAVAILABLE_METHOD;
@end
