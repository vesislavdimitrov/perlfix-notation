package PrefixNotation::PnConsole;

use strict;
use warnings;

use PrefixNotation::Prompt;
use PrefixNotation::PrefixConverter;

my $HEADER = 'Prefix Notation Converter       | powered by Perl';
my $REQUEST_INPUT_PROMPT = 'Enter a valid infix expression to convert: ';
my $REQUEST_ANSWER_PROMPT = 'Would you like to convert another expression?';
my $INVALID_INPUT_ERR = 'Invalid input!';
my $CONVERTED_MSG = 'Converted expression';

sub new {
    my ($class) = @_;
    bless {}, $class;
}

sub init {
    my ($self) = @_;
    $self->printHeader();
    $self->requestInput();
    return 1;
}

sub printHeader {
    my $headerMessageLength = length($HEADER);
    my $headerDelimiter = '~';

    say STDOUT "\n" . $headerDelimiter x $headerMessageLength;
    say STDOUT $HEADER;
    print $headerDelimiter x $headerMessageLength . "\n\n";
}

sub requestInput {
    my ($self) = @_;

    while(1) {
        $self->handleInput(PrefixNotation::Prompt->requestExpression($REQUEST_INPUT_PROMPT));
        last if !PrefixNotation::Prompt->requestAnswer($REQUEST_ANSWER_PROMPT);
    }
    return 1;
}

sub handleInput {
    my ($self, $input) = @_;

    $self->_removeWhitespaces(\$input);
    if(!$self->_isValidInput($input)) {
        say STDOUT $INVALID_INPUT_ERR;
        return 0;
    }

    my $reversedInput = reverse $input;
    my $prefixExpression = PrefixNotation::PrefixConverter
        ->new($reversedInput)
        ->convertToPrefix();
    say STDOUT "$CONVERTED_MSG: $prefixExpression";
    return 1;
}

sub _removeWhitespaces {
    my ($self, $inputRef) = @_;
    ${$inputRef} =~ s/\s*//g;
    return 1;
}

sub _isValidInput {
    my ($self, $input) = @_;
    return 0 if($input !~ /^[a-zA-Z0-9\^\+\/\*\-\%\(\)]+$/);
    return 1;
}

1;