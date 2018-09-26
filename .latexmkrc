# Generate a pdf version of the document using pdflatex
$pdf_mode = 1;

$postscript_mode = 0;
$dvi_mode = 0;

if ($^O =~/darwin/) { # Mac
    $pdf_previewer = "open -a /Applications/Skim.app";
} elsif ($^O =~ /MSWin32/) { # Windows
    # Use the windows start comand to call default PDF viewer
    $pdf_previewer = 'start "" /max %0 %S';
} elsif ($^O =~ /linux/) { #Linux
    $pdf_previewer = "okular";
}

$clean_ext = "paux lox pdfsync out";
