package test

import (
	"github.com/byxor/qbd/code"
	. "github.com/byxor/qbd/tokens"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestSyntax(t *testing.T) {
	entries := []struct {
		tokens   []Token
		expected string
	}{
		{[]Token{}, ""},

		{[]Token{
			Token{EndOfFile, nil},
		}, ""},

		// Ends of lines
		{[]Token{
			Token{EndOfLine, nil},
		}, ";"},

		{[]Token{
			Token{EndOfLine, nil},
			Token{EndOfLine, nil},
		}, ";"},

		{[]Token{
			Token{EndOfLine, nil},
			Token{EndOfLine, nil},
			Token{EndOfLine, nil},
		}, ";"},

		// Integers
		{[]Token{
			Token{Integer, []byte{0x17, 0x00, 0x00, 0x00, 0x00}},
		}, "0"},

		{[]Token{
			Token{Integer, []byte{0x17, 0x01, 0x00, 0x00, 0x00}},
		}, "1"},

		{[]Token{
			Token{Integer, []byte{0x17, 0xFF, 0xFF, 0xFF, 0xFF}},
		}, "-1"},
	}
	for _, entry := range entries {
		code := code.GenerateUsing(entry.tokens)
		assert.Equal(t, entry.expected, code)
	}
}