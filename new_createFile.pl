#!/usr/bin/perl


@conditionStack = ();
@conditionValidationStack = ();
$lineNumber = 0;


while ($line = <STDIN>) {
    $lineNumber++;

    if ($line =~ /^#%\s*IF\s+(\S+)/i) {
        $condition = $1;
        if (grep(/^!$condition$/, @ARGV)) {
            $conditionRealized = 0;
        }
        else {
            $conditionRealized = 1;
        }
        if ($condition =~ /^!([a-z0-9_]+)\s*$/i) {
            push(@conditionStack, $1);
            push(@conditionValidationStack, 1-$conditionRealized);
        }
        else {
            push(@conditionStack, $condition);
            push(@conditionValidationStack, $conditionRealized);
        }
    }
    elsif ($line =~ /^#%\s*ENDIF/i) {
        if (scalar(@conditionStack) != 0) {
            pop(@conditionStack);
            pop(@conditionValidationStack);
        }
        else {
            die("Line $lineNumber: #%ENDIF without an #%IF");
        }
    }
    elsif ($line =~ /^#%\s*ELSE/i) {
        $conditionValidationStack[$#conditionValidationStack] = 1-$conditionValidationStack[$#conditionValidationStack];
    }
    elsif ($line =~ /^#%%/i) {
        # Do nothing
    }
    else {
        $shouldPrint = 1;
        while (($index, $validated) = each(@conditionValidationStack)) {
            #print "|$index||$validated|\n";
            if ($validated == 1) {
                $shouldPrint = 0;
            }
        }
        print $line if $shouldPrint == 1;
    }

}

if (scalar(@conditionStack) != 0) {
    die("Unexpected EOF\n");
}



