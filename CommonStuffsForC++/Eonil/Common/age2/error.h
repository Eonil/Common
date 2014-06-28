//
//  error.h
//  CommonUtility
//
//  Created by Hoon H. on 2014/06/28.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#pragma once
#include "common.h"
EONIL_COMMONUTILITY_AGE2_NAMESPACE_BEGIN








/*!
 @internal
 This file contains internal-only features.
 
 
 @header
 In my experience type of error isn't that much important.
 Only these stuffs are important;
 
 -	Is it RECOVERABLE?
 -	Is it because of current state or paramaters?
 
 Then, I categorized errors into three groups.
 
 1.	Recoverable, and because of the bad input parameter (new future state).
 2.	Recoverable, and because of improper current state.
 3.	Unrecoverable. Program state is already corrupted. Reason doesn't matter,
	and program must quit immediately to prevent further damage on data.
 
 @warning
 These functions doesn't handle any conditional compilation or release build
 elimination. You're responsible to do that.
 */











[[noreturn]]
inline auto
fail() -> void
{
	/*
	 Throw properly typed error when you getting need it.
	 */
	throw	std::logic_error("Eonil::CommonUtility::age2/fail");
//	std::terminate();
}

inline auto
fail_if(bool cond) -> void
{
	if (cond)
	{
		fail();
	}
}











/*
 errors in lower number should be preferred and considered first.
 */

inline auto
err1_recoverable_bad_input_parameter_if(bool cond) -> void
{
	fail_if(cond);
}
[[noreturn]]
inline auto
err1_recoverable_bad_input_parameter_always() -> void
{
	fail();
}

inline auto
err2_recoverable_program_state_is_not_proper_for_this_command_if(bool cond) -> void
{
	fail_if(cond);
}
[[noreturn]]
inline auto
err2_recoverable_program_state_is_not_proper_for_this_command_always() -> void
{
	fail();
}





/*!
 @warning	this is very rare case! consider using of err2. most errors are recoverable in most cases.
 */
inline auto
err3_UNRECOVERABLE_unexpected_inconsistent_program_state_DISCOVERED_and_seems_to_be_an_internal_logic_bug_if(bool cond) -> void
{
	fail_if(cond);
}
[[noreturn]]
inline auto
err3_UNRECOVERABLE_unexpected_inconsistent_program_state_DISCOVERED_and_seems_to_be_an_internal_logic_bug_always() -> void
{
	fail();
}






































EONIL_COMMONUTILITY_AGE2_NAMESPACE_END
