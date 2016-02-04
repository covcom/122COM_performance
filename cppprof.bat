@echo off
setlocal

set PYTHON=C:/Python34/python
set CPP=g++ --std=c++11
set GPROF=C:/Python34/Scripts/gprof2dot
set GRAPHVIZ=C:/Program Files (x86)/Streamed Applications/Graphviz2.38/bin/dot
set OUTFILE=out.pdf

REM check that a filename has been supplied
if "%1"=="" (
	echo You have to supply a filenmae
	exit /b
)
set FILENAME=%1

REM see if an output filename has been supplied then use that
if not "%2"=="" set OUTFILE=%2

echo == Compile the C++ program ======
echo   %CPP% -pg "%FILENAME%" -o test
%CPP% -pg "%FILENAME%" -o test
echo _

echo == Run the C++ program ======
echo   test
test
echo _

echo === Format the profiling results ======
echo "  gprof test | "%PYTHON%" "%GPROF%" -f pstats cpp.prof -o gprof.dot"
gprof test | "%PYTHON%" "%GPROF%" -n0 -e0 -o gprof.dot
echo _

echo === Create profiling graph ======
echo   "%GRAPHVIZ%" -T pdf gprof.dot -o "%OUTFILE%"
"%GRAPHVIZ%" -T pdf gprof.dot -o "%OUTFILE%"