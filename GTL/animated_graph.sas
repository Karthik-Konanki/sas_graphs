/*CREATE AN ANIMATED GRAPH*/

/* Sort data by origin */
proc sort data=sashelp.cars out=cars;
	by origin;
run;
/* Define the template for the graphs */
proc template;
	define statgraph mileage;
		dynamic _BYVAL_;
		begingraph;
		entrytitle "MPG By Vehicle Type for Cars Made In " _BYVAL_;
			layout overlay / cycleattrs=true
									xaxisopts=(label="Vehicle Type")
									yaxisopts=(label="MPG" griddisplay=on
									gridattrs=(color=lightgray pattern=dot)
									linearopts=(tickvaluesequence=(start=0 end=60
									increment=10) tickvaluepriority=true));
				barchart category=type response=mpg_city /
										name="City" legendlabel="City"
										discreteoffset=-0.1 barwidth=0.2 stat=mean;
				barchart category=type response=mpg_highway /
										name="Highway" legendlabel="Highway"
										discreteoffset=0.1 barwidth=0.2 stat=mean;
				discretelegend "City" "Highway";
			endlayout;
		endgraph;
	end;
run;
/* Create a file reference for the printer output */
filename prtout "D:\SAS\SAS Graphs\SAS\anim.svg"; /* Specify the output filename */
/* Set the system animation options */
options printerpath=svg /* Specify the SVG universal printer */
		nonumber nodate /* Suppress the page number and date */
		animduration=3 /* Wait 3 seconds between graphs */
		animloop=yes /* Play continuously */
		noanimoverlay /* Display graphs sequentially */
		svgfadein=1 /* One-second fade-in for each graph */
		svgfadeout=1 /* One-second fade-out for each graph */
		nobyline; /* Suppress the BY-line */
/* Close all currently open ODS destinations */
ods _all_ close;
/* Start the animation output */
options animate=start;
/* Clear the titles and footnotes */
title;
footnote;
/* Open the ODS PRINTER destination */
ods printer file=prtout style=htmlblue;
/* Generate the graphs */
proc sgrender data=cars template=mileage;
	by origin;
run;
/* Stop the animation output */
options animate=stop;
/* Close the ODS PRINTER destination */
ods printer close;
/* Open an ODS destination for subsequent programs */
ods html; /*Not required in SAS Studio */
