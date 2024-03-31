package PrefixNotation::OperatorPriorities;

use Exporter qw(import);

our @EXPORT = qw($OPERATOR_PRIORITIES);

our $OPERATOR_PRIORITIES = {
    '(' => {
        onPushPrio => 2,
    },
    ')' => {
        onPushPrio => 99,
        stackPrio => 2,
    },
    '+' => {
        onPushPrio => 3,
        stackPrio => 3,
    },
    '-' => {
        onPushPrio => 3,
        stackPrio => 3,
    },
    '/' => {
        onPushPrio => 4,
        stackPrio => 4,
    },
    '*' => {
        onPushPrio => 4,
        stackPrio => 4,
    },
    '%' => {
        onPushPrio => 4,
        stackPrio => 4,
    },
    '^' => {
        onPushPrio => 6,
        stackPrio => 5,
    },
};

1;