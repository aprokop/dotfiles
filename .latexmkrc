# vi:ft=perl

# http://tex.stackexchange.com/questions/11710/specify-output-directory-when-using-latexmk
$pdflatex="pdflatex -interaction errorstopmode -shell-escape %O %S";
$pdf_mode = 1;

@BIBINPUTS = ( ".", ".." );
$ENV{TEXINPUTS} .="${search_path_separator}media";

$clean_ext = "paux lox pdfsync out";

# Define all output directories to be "tmp"
# All build files will now be placed in this directory
$aux_dir = ".tmp";
$tmpdir  = ".tmp";
$out_dir = ".tmp";

if ($^O =~/darwin/) { # Mac
    $pdf_previewer = "open -a /Applications/Skim.app";
} elsif ($^O =~ /MSWin32/) { # Windows
    # Use the windows start comand to call default PDF viewer
    $pdf_previewer = 'start "" /max %0 %S';
} elsif ($^O =~ /linux/) { #Linux
    $pdf_previewer = "okular";
}
