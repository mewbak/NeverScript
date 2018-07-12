// Code generated by "stringer -type=TokenType"; DO NOT EDIT.

package tokens

import "strconv"

const _TokenType_name = "EndOfFileEndOfLineCommaDotAssignmentLocalReferenceAllLocalReferencesStringLocalStringPairVectorWhileRepeatBreakSubtractionAdditionDivisionMultiplicationNotOrAndEqualityCheckLessThanCheckLessThanOrEqualCheckGreaterThanCheckGreaterThanOrEqualCheckExecuteRandomBlockStartOfExpressionEndOfExpressionStartOfStructEndOfStructStartOfArrayEndOfArrayStartOfSwitchEndOfSwitchSwitchCaseDefaultSwitchCaseStartOfFunctionEndOfFunctionReturnStartOfIfElseElseIfEndOfIfOptimisedIfOptimisedElseIntegerFloatNameShortJumpLongJumpChecksumTableEntryNamespaceAccessInvalid"

var _TokenType_index = [...]uint16{0, 9, 18, 23, 26, 36, 50, 68, 74, 85, 89, 95, 100, 106, 111, 122, 130, 138, 152, 155, 157, 160, 173, 186, 206, 222, 245, 263, 280, 295, 308, 319, 331, 341, 354, 365, 375, 392, 407, 420, 426, 435, 439, 445, 452, 463, 476, 483, 488, 492, 501, 509, 527, 542, 549}

func (i TokenType) String() string {
	if i < 0 || i >= TokenType(len(_TokenType_index)-1) {
		return "TokenType(" + strconv.FormatInt(int64(i), 10) + ")"
	}
	return _TokenType_name[_TokenType_index[i]:_TokenType_index[i+1]]
}