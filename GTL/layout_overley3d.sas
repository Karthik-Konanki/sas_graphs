/*LAYOUT OVERLAY3D*/

proc kde data=sashelp.heart;
bivar height(ngrid=8) weight(ngrid=10) /
out=kde(keep=value1 value2 count) noprint plots=none;
run;

proc template;
	define statgraph bihistogram1a;
		begingraph;
		entrytitle "Distribution of Height and Weight";
		entryfootnote halign=right "SASHELP.HEART";
			layout overlay3d / cube=false zaxisopts=(griddisplay=on)
								xaxisopts=(linearopts=(tickvalueformat=5.))
								yaxisopts=(linearopts=(tickvalueformat=5.));
				bihistogram3dparm x=value1 y=value2 z=count /
									display=all;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data= kde template=bihistogram1a;
	label value1="Height" value2="Weight";
run;

proc sgrender data=kde template=bihistogram1a;
where count > 0;
label value1="Height" value2="Weight";
run;


/*Displaying Percentages on Z Axis.*/

proc kde data=sashelp.heart;
	bivar height(ngrid=8) weight(ngrid=10) /
	out=kde(keep=value1 value2 count) noprint plots=none;
run;
data kde;
	if _n_ = 1 then do i=1 to rows;
	set kde(keep=count) point=i nobs=rows;
	TotalObs+count;
	end;
	set kde;
	Count=100*(Count/TotalObs);
	label Count="Percent";
run;
proc sgrender data=kde template=bihistogram1a;
	label value1="Height" value2="Weight";
run;

/*Setting Bin Width*/
data heart;
set sashelp.heart(keep=height weight);
if height ne . and weight ne .;
height=round(height,5);
weight=round(weight,25);
run;

proc summary data=heart nway completetypes;
	class height weight;
	var height;
	output out=stats(keep=height weight count) N=Count;
run;

proc template;
	define statgraph bihistogram2a;
		begingraph;
		entrytitle "Distribution of Height and Weight";
		entryfootnote halign=right "SASHELP.HEART";
			layout overlay3d / cube=false zaxisopts=(griddisplay=on);
				bihistogram3dparm x=height y=weight z=count /
							display=all;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=stats template=bihistogram2a;
run;


proc template;
	define statgraph bihistogram2a;
		begingraph;
		entrytitle "Distribution of Height and Weight";
		entryfootnote halign=right "SASHELP.HEART";
			layout overlay3d / cube=false zaxisopts=(griddisplay=on);
				bihistogram3dparm x=height y=weight z=count /
								binaxis=true endlabels=true display=all;
			endlayout;
		endgraph;
	end;
run;
data heart;
set sashelp.heart(keep=height weight);
height=round(height,10);
weight=round(weight,50);
run;
proc summary data=heart nway completetypes;
	class height weight;
	var height;
	output out=stats(keep=height weight count) N=Count;
run;
proc sgrender data=stats template=bihistogram2a;
run;


data cars;
	set sashelp.cars(keep=weight horsepower mpg_highway);
	if horsepower ne . and weight ne .;
	horsepower=round(horsepower,75);
	weight=round(weight,1000);
run;
proc summary data=cars nway completetypes;
	class weight horsepower;
	var mpg_highway;
	output out=stats mean=Mean;
run;
proc template;
	define statgraph bihistogram2b;
		begingraph;
		entrytitle
				"Distribution of Gas Mileage by Vehicle Weight and Horsepower";
		entryfootnote halign=right "SASHELP.CARS";
			layout overlay3d / cube=false zaxisopts=(griddisplay=on) rotate=130;
				bihistogram3dparm y=weight x=horsepower z=mean / binaxis=true
						display=all;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=stats template=bihistogram2b;
run;


proc template;
	define statgraph surfaceplotparm;
		begingraph;
		entrytitle "Surface Plot of Lake Bed";
			layout overlay3d / cube=false;
				surfaceplotparm x=length y=width z=depth;
			endlayout;
		endgraph;
	end;
run;
ods graphics / antialiasmax=5700;
proc sgrender data=sashelp.lake template=surfaceplotparm;
run;


proc g3grid data=sashelp.lake out=spline;
grid width*length = depth / naxis1=75 naxis2=75 spline;
run;
proc sgrender data=spline template=surfaceplotparm;
run;



proc template;
	define statgraph surfaceplotparm;
		begingraph;
		entrytitle "SURFACECOLORGRADIENT=DEPTH";
			layout overlay3d / cube=false;
				surfaceplotparm x=length y=width z=depth /
						surfacetype=fill
						surfacecolorgradient=depth
						colormodel=twocolorramp
						reversecolormodel=true;
			endlayout;
		endgraph;
	end;
run;
/* create gridded data for surface */
proc g3grid data=sashelp.lake out=spline;
grid width*length = depth / naxis1=75 naxis2=75 spline;
run;
proc sgrender data=spline template=surfaceplotparm;
run;


proc template;
	define statgraph surfaceplot;
		begingraph;
			entrytitle "SURFACECOLORGRADIENT=TEMPERATURE";
				layout overlay3d / cube=false;
					surfaceplotparm x=length y=width z=depth / name="surf"
									surfacetype=fill
									surfacecolorgradient=temperature
									reversecolormodel=true
									colormodel=twocoloraltramp;
					continuouslegend "surf" /
			title="Temperature (^{unicode '00B0'x}F)";
				endlayout;
		endgraph;
	end;
run;
data lake;
set sashelp.lake;
if depth = 0 then Temperature=46;
else Temperature=46+depth;
run;
/* create gridded data for surface */
proc g3grid data=lake out=spline;
grid width*length = depth temperature / naxis1=75 naxis2=75 spline;
run;
proc sgrender data=spline template=surfaceplot;
run;
