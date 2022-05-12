import ballerina/test;

@test:Config {
    groups: ["lexer"]
}
function testFullLineComment() returns error? {
    LexerState state = setLexerString("# someComment");
    check assertToken(state, EOL);
}

@test:Config {
    groups: ["lexer"]
}
function testEOLComment() returns error? {
    LexerState state = setLexerString("someKey = \"someValue\" # someComment");
    check assertToken(state, EOL, 4);
}

@test:Config {
    groups: ["lexer"]
}
function testMultipleWhiteSpaces() returns error? {
    LexerState state = setLexerString("  ");
    check assertToken(state, EOL);
}

@test:Config {
    groups: ["lexer"]
}
function testscanUnquotedKey() returns error? {
    LexerState state = setLexerString("somekey = \"Some Value\"");
    check assertToken(state, UNQUOTED_KEY, lexeme = "somekey");
}

@test:Config {
    groups: ["lexer"]
}
function testscanUnquotedKeyWithInvalidChar() {
    assertLexicalError("some$value = 1");
}

@test:Config {
    groups: ["lexer"]
}
function testKeyValueSeparator() returns error? {
    LexerState state = setLexerString("somekey = 1");
    check assertToken(state, KEY_VALUE_SEPARATOR, 2);
}

@test:Config {
    groups: ["lexer"]
}
function testDot() returns error? {
    LexerState state = setLexerString("outer.'inner' = 3");
    check assertToken(state, UNQUOTED_KEY, lexeme = "outer");
    check assertToken(state, DOT);
    check assertToken(state, LITERAL_STRING, lexeme = "inner");
}
