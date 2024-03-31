package PrefixNotation::PrefixConverter;

use PrefixNotation::OperatorPriorities qw($OPERATOR_PRIORITIES);

sub new {
    my ($class, $input) = @_;
    my $self = {
        input => $input
    };
    bless $self, $class;
}

sub convertToPrefix {
    my ($self) = @_;

    my @allCharsInInput = split '', $self->{input};
    my $operatorsStack = [];
    my $prefixOutput = '';

    foreach my $char (@allCharsInInput) {
        if(!$self->_isOperator($char)) {
            $prefixOutput .= $char;
            next;
        }

        $self->processOperator($char, $operatorsStack, \$prefixOutput);
    }
    $self->pullAllOperatorsFromStack($operatorsStack, \$prefixOutput);
    return reverse $prefixOutput;
}

sub pullAllOperatorsFromStack {
    my  ($self, $operatorsStack, $prefixOutputReference) = @_;

    ${$prefixOutputReference} .= reverse join '', @{$operatorsStack};
    ${$prefixOutputReference} =~ s/\(|\)//g;
    return 1;
}

sub processOperator {
    my ($self, $operator, $operatorsStack, $prefixOutputReference) = @_;

    $self->_popStack($operator, $operatorsStack, $prefixOutputReference);
    $self->_pushOperator($operator, $operatorsStack);
    return 1;
}

sub _popStack {
    my ($self, $operator, $operatorsStack, $prefixOutputReference) = @_;

    while($self->_shouldPopStack($operator, $operatorsStack)) {
        my $poppedOperator = pop @{$operatorsStack};
        ${$prefixOutputReference} .= $poppedOperator if $poppedOperator !~ /\(|\)/;
    }
    return 1;
}

sub _shouldPopStack {
    my ($self, $operator, $operatorsStack) = @_;

    my $operatorEntryPriority = $self->_getOperatorEntryPriority($operator);
    my $lastOperatorInStackPriority = $self->_getOperatorStackPriority($operatorsStack->[-1]);
    $lastOperatorInStackPriority = -1 if(!defined $lastOperatorInStackPriority);

    return ($lastOperatorInStackPriority > $operatorEntryPriority);
}

sub _pushOperator {
    my ($self, $operator, $operatorsStack)  = @_;

    my $operatorStackPriority = $self->_getOperatorStackPriority($operator);
    push @{$operatorsStack}, $operator if defined $operatorStackPriority;
    return 1;
}

sub _getOperatorEntryPriority {
    my ($self, $operator) = @_;
    return $OPERATOR_PRIORITIES->{$operator}->{onPushPrio};
}

sub _getOperatorStackPriority {
    my ($self, $operator) = @_;
    return $OPERATOR_PRIORITIES->{$operator}->{stackPrio};
}

sub _isOperator {
    my ($self, $char) = @_;

    my @operators = keys %{$OPERATOR_PRIORITIES};
    return 1 if grep(/\Q$char\E/, @operators);
    return 0;
}

1;