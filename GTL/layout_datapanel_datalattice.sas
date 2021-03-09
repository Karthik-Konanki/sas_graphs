proc template;
	define statgraph onerow;
		begingraph;
		entrytitle "Yearly Profit for Sports Products";
			layout datapanel classvars=(product_group) / rows=1;
				layout prototype;
					barchart category=year response=profit / stat=sum;
				endlayout;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.orsales template=onerow;
where product_group in ("Golf" "Tennis" "Soccer");
run;

/*ASPECT RATIO*/

proc template;
	define statgraph onerow;
		begingraph /designwidth=640px designheight=320px;;
		entrytitle "Yearly Profit for Sports Products";
			layout datapanel classvars=(product_group) / rows=1;
				layout prototype;
					barchart category=year response=profit / stat=sum;
				endlayout;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.orsales template=onerow;
where product_group in ("Golf" "Tennis" "Soccer");
run;


proc template;
	define statgraph onerow;
		begingraph / designwidth=360px designheight=180px;
		entrytitle "Yearly Profit for Sports Products";
			layout datapanel classvars=(product_group) / rows=1
							headerlabeldisplay=value
							cellwidthmin=70 cellheightmin=70;
				layout prototype;
					barchart category=year response=profit / stat=sum;
				endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.orsales template=onerow;
	where product_group in ("Golf" "Tennis" "Soccer");
run;


proc template;
	define statgraph onecol;
		begingraph / designwidth=280px designheight=380px;
		entrytitle "Yearly Profit for Sports Products";
			layout datapanel classvars=(product_group) / columns=1
								headerlabeldisplay=value
								cellwidthmin=85 cellheightmin=85;
				layout prototype;
					barchart category=year response=profit / stat=sum
									orient=horizontal;
				endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.orsales template=onecol;
	where product_group in ("Golf" "Tennis" "Soccer");
run;



/*Controlling Data Ranges of Rows or Columns*/

proc template;
	define statgraph unionall;
		begingraph / designwidth=350px designheight=400px;
					entrytitle "Yearly Profit for Sports Products";
			layout datapanel classvars=(product_group) /
							rowdatarange=unionall;
				layout prototype;
					barchart category=year response=profit /
											stat=sum;
				endlayout;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.orsales template=unionall;
	where product_group in
		("Golf" "Darts" "Baseball");
run;


proc template;
	define statgraph unionall;
		begingraph / designwidth=350px designheight=400px;
					entrytitle "Yearly Profit for Sports Products";
			layout datapanel classvars=(product_group) /
							rowdatarange=union;
				layout prototype;
					barchart category=year response=profit /
											stat=sum;
				endlayout;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.orsales template=unionall;
	where product_group in
		("Golf" "Darts" "Baseball");
run;


/*Setting Axis Options*/

proc template;
	define statgraph unionall;
		begingraph / designwidth=350px designheight=400px;
					entrytitle "Yearly Profit for Sports Products";
			layout datapanel classvars=(product_group) /
								rowdatarange=union
								columnaxisopts=(display=(tickvalues))
								rowaxisopts=(display=(tickvalues)
								linearopts=(tickvalueformat=dollar12.)
								griddisplay=on offsetmin=0);
				layout prototype;
					barchart category=year response=profit /
											stat=sum;
				endlayout;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.orsales template=unionall;
	where product_group in
		("Golf" "Darts" "Baseball");
run;




proc template;
	define statgraph unionall;
		begingraph / designwidth=350px designheight=400px;
					entrytitle "Yearly Profit for Sports Products";
			layout datalattice rowvar=product_group /
								rowdatarange=union
								rowgutter=5px
								columnaxisopts=(display=(tickvalues))
								rowaxisopts=(display=(tickvalues)
								linearopts= (tickvalueformat=dollar12.)
								griddisplay=on offsetmin=0);
				layout prototype;
					barchart category=year response=profit /
											stat=sum;
				endlayout;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.orsales template=unionall;
	where product_group in
		("Golf" "Darts" "Baseball");
run;


/*Controlling the Classification Headers*/

proc template;
	define statgraph unionall;
		begingraph / designwidth=350px designheight=400px;
		entrytitle "Yearly Profit for Sports Products";
			layout datalattice rowvar=product_group /
								rowdatarange=union rowgutter=5px rowheaders=left
								headerlabeldisplay=value
								columnaxisopts=(display=(tickvalues))
								rowaxisopts= (display=none displaysecondary=(tickvalues)
								linearopts=(tickvalueformat=dollar12.)
								griddisplay=on offsetmin=0 );
				layout prototype;
					barchart category=year response=profit / stat=sum;
				endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.orsales template=unionall;
	where product_group in
		("Golf" "Darts" "Baseball");
run;



proc template;
	define statgraph unionall;
		begingraph / designwidth=350px designheight=400px;
		entrytitle "Yearly Profit for Sports Products";
			layout datalattice rowvar=product_group /
								rowdatarange=union
								rowgutter=5px
								rowheaders=left
								headerlabeldisplay=value
								headerlabelattrs=(weight=bold)
								headeropaque=true
								headerbackgroundcolor=GraphAltBlock:color
								columnaxisopts=(display=(tickvalues) )
								rowaxisopts=(display=none displaysecondary=(tickvalues)
								linearopts=(tickvalueformat=dollar12.)
								griddisplay=on offsetmin=0);
				layout prototype;
					barchart category=year response=profit / stat=sum;
				endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.orsales template=unionall;
	where product_group in
		("Golf" "Darts" "Baseball");
run;



proc template;
	define statgraph layoutdatapanel;
		begingraph / drawspace=layoutpercent;
			layout datapanel classvars=(country prodtype product) /
							columns=4 rowdatarange=unionall
							headerlabeldisplay=value
							headerbackgroundcolor=GraphAltBlock:color;
				layout prototype;
					barchart x=year y=TotalActual;
				endlayout;
			endlayout;
		endgraph;
	end;
run;
/* Summarize the data in SASHELP.PRDSAL2 */
proc summary data=sashelp.prdsal2 nway;
	class country year product prodtype;
		var actual predict;
	output out=prdsal2 sum=TotalActual TotalPredict;
run;
/* Generate the panel using the summarized data */
proc sgrender data=prdsal2 template=layoutdatapanel;
	where country in ("Canada" "Mexico");
run;


proc template;
	define statgraph layoutdatapanel;
		begingraph / drawspace=layoutpercent;
			layout datapanel classvars=(country prodtype product) /
						columns=4 rowdatarange=unionall
						headerlabeldisplay=value
						headerpack=true headersplitcount=2
						headerbackgroundcolor=GraphAltBlock:color;
				layout prototype;
					barchart x=year y=TotalActual;
				endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=prdsal2 template=layoutdatapanel;
	where country in ("Canada" "Mexico");
run;


/*Controlling the Interactions of Classifiers*/

/*Appearance of the Last Panel*/

proc template;
	define statgraph multipanel;
		begingraph / designwidth=340px designheight=340px;
			layout datapanel classvars=(product_category) /
								rows=2 columns=2
								headerlabeldisplay=value
								rowaxisopts=(griddisplay=on offsetmin=0
								display=(tickvalues) linearopts=(tickvalueformat=dollar12.));
				layout prototype;
					barchart x=year y=profit / fillattrs=GraphData1;
				endlayout;
					sidebar / align=top;
						entry "Profit for Selected Sports Items" /
									textattrs=GraphTitleText;
					endsidebar;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.orsales template=multipanel;
	where product_line in ("Sports") and
	product_category ne "Assorted Sports Articles";
run;

/*Skip Appearance of the Last empty Panel*/

proc template;
	define statgraph multipanel;
		begingraph / designwidth=340px designheight=340px;
			layout datapanel classvars=(product_category) /
						rows=2 columns=2
						skipemptycells=true
						headerlabeldisplay=value
						rowaxisopts=(griddisplay=on offsetmin=0
						display=(tickvalues) linearopts=(tickvalueformat=dollar12.));
				layout prototype;
					barchart x=year y=profit / fillattrs=GraphData1;
				endlayout;
					sidebar / align=top;
						entry "Profit for Selected Sports Items" /
									textattrs=GraphTitleText;
					endsidebar;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.orsales template=multipanel;
	where product_line in ("Sports") and
	product_category ne "Assorted Sports Articles";
run;

/*User Control of Panel Generation*/

proc template;
	define statgraph panelgen;
		nmvar PANELNUM TOTPANELS ROWS COLS YEAR;
		begingraph;
			entrytitle halign=right "Panel " PANELNUM " of " TOTPANELS /
						textattrs=GraphFootnoteText;
		layout datapanel classvars=(product division) /
						rows=ROWS columns=COLS
						cellheightmin=50 cellwidthmin=50
						skipemptycells=true
						columnaxisopts=(type=time timeopts=(tickvalueformat=month.))
						rowaxisopts=(griddisplay=on)
						panelnumber=PANELNUM;
			layout prototype;
				seriesplot x=month y=actual / lineattrs=GraphData1;
			endlayout;
				sidebar / align=top;
					entry "Office Furniture Sales for " YEAR /
					textattrs=GraphTitleText;
				endsidebar;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.orsales template=multipanel;
	where product_line in ("Sports") and
	product_category ne "Assorted Sports Articles";
run;


%macro panels(rows=1,cols=1,colwidth=200,year=1994,style=htmlblue);
	%local div_vals prod_vals panels totpanels panelnumber;
/* find the number of unique values for the classifiers */
		proc sql noprint;
			select n(distinct division) into: div_vals from sashelp.prdsale;
			select n(distinct product) into: prod_vals from sashelp.prdsale;
		quit;
/* compute the number of panels based on input rows and cols */
	%let panels=%sysevalf(&div_vals * &prod_vals / (&rows * &cols));
	%let totpanels=%sysfunc(ceil(&panels)); /* round up to next integer */
/* generate the panels */
		ods graphics / reset;
		ods _all_ close;
		ods listing style=&style gpath="D:\SAS\SAS Graphs\SAS";
	%do panelnum=1 %to &totpanels;
		ods graphics / imagename="Panel&panelnum"
					width=%sysevalf(&colwidth*&cols)px
					height=%sysevalf(&colwidth*&rows)px;
		proc sgrender data=sashelp.prdsale template=panelgen;
			where country="U.S.A." and region="EAST" and year=&year;
		run;
	%end;
	ods listing close;
	ods html; /* Not necessary in SAS Studio */
%mend;

%panels(rows=2,cols=2);
%panels(rows=2,cols=3);


/*Sparsing data*/
proc template;
	define statgraph sparse;
		begingraph / designwidth=490px designheight=450px;
		entrytitle "Heart Rates for Subjects";
			layout datapanel classvars=(subject treatment) /
							columns=4 rows=3
							cellheightmin=50 cellwidthmin=50
							skipemptycells=true
							sparse=true
							columnaxisopts=(display=(tickvalues))
							rowaxisopts=(display=(label) offsetmin=0);
				layout prototype;
					barchart category=task response=heartrate / barlabel=true;
				endlayout;
			endlayout;
		endgraph;
	end;
run;


proc template;
	define statgraph datalattice;
		begingraph / designwidth=490px designheight=400px;
		entrytitle "Heart Rates for Subjects";
			layout datalattice rowvar=subject columnvar=treatment /
									rows=3 rowgutter=5px
									cellheightmin=50 cellwidthmin=50
									rowheaders=left
									skipemptycells=true
									columnaxisopts=(display=(tickvalues))
									rowaxisopts=(display=none displaysecondary=(label) offsetmin=0);
				layout prototype;
					barchart category=task response=heartrate / barlabel=true;
				endlayout;
			endlayout;
		endgraph;
	end;
run;


/*Using Non-computed Plots in Classification Panels*/

proc template;
	define statgraph dosepanel;
		begingraph / designwidth=490px designheight=350px;
			layout datapanel classvars=(dose) / rows=1;
				layout prototype;
					bandplot x=days limitupper=uclm limitlower=lclm / name="clm"
											display=(fill) fillattrs=GraphConfidence
											legendlabel="95% Confidence Limits";
					bandplot x=days limitupper=ucl limitlower=lcl / name="cli"
											display=(outline) outlineattrs=GraphPredictionLimits
											legendlabel="95% Prediction Limits";
					seriesplot x=days y=predicted / name="reg"
											lineattrs=graphFit legendlabel="Fit";
					scatterplot x=days y=response / primary=true
											markerattrs=(size=5px) datatransparency=.5;
				endlayout;
					sidebar / align=top;
						entry "Predicted Response to Dosage (mg) over Time" /
										textattrs=GraphTitleText pad=(bottom=10px);
						endsidebar;
					sidebar / align=bottom;
						discretelegend "reg" "clm" "cli" / across=3;
					endsidebar;
			endlayout;
		endgraph;
	end;
run;


data trial;
	do Dose = 100 to 300 by 100;
		do Days=1 to 30;
			do Subject=1 to 10;
				Response=log(days)*(400-dose)* .01*ranuni(1) + 50;
				output;
			end;
end;
end;
run;

proc glm data=trial alpha=.05 noprint;
by dose;
model response=days / p cli clm;
output out=stats
lclm=lclm uclm=uclm
lcl=lcl ucl=ucl
predicted=predicted;
run;
quit;

proc sgrender data=stats template=dosepanel;
run;


/*Using PROC SGPANEL to Create Classification Panels*/

title "Predicted Response to Dosage (mg) over Time";
proc sgpanel data=trial;
panelby dose / rows=1;
reg x=days y=response / cli clm;
run;
title '';



title "Cholesterol Distribution by Gender and Weight";
proc sgpanel data=sashelp.heart;
panelby sex weight_status / layout=lattice onepanel novarname;
histogram cholesterol;
density cholesterol / name="density";
refline 227 / axis=x name="ref" legendlabel="Overall Mean = 227";
rowaxis offsetmin=0 offsetmax=.1 max=30;
keylegend "density" "ref";
run;


/*Example 1: A Basic Data Lattice*/

proc template;
	define statgraph datalattice_intro;
		begingraph;
		entrytitle "Office Furniture Sales";
			layout datalattice rowvar=product columnvar=division;
				layout prototype;
					seriesplot x=month y=actual;
				endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.prdsale template=datalattice_intro;
	where country="U.S.A." and region="EAST" and
			product in ("CHAIR" "DESK" "TABLE");
	format actual dollar.;
run;


/*Example 2: A Basic Data Panel*/

proc template;
	define statgraph datapanel_intro;
		begingraph;
		entrytitle "Office Furniture Sales";
			layout datapanel classvars=(product division) / columns=2;
				layout prototype;
					seriesplot x=month y=actual;
				endlayout;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.prdsale template=datapanel_intro;
	where country="U.S.A." and region="EAST" and
		product in ("CHAIR" "DESK" "TABLE");
	format actual dollar.;
run;


/*Example 3: A Data Panel with Sidebars*/

proc template;
	define statgraph sidebar;
		begingraph / designwidth=490px designheight=800px border=false;
			layout datapanel classvars=(product division) / columns=2
									columngutter=10 rowgutter=5
									headerlabelattrs=GraphLabelText(weight=bold)
									rowaxisopts=(display=(tickvalues))
									columnaxisopts=(display=(ticks tickvalues)
									offsetmin=0
									linearopts=(tickvalueformat=dollar6. viewmax=2000
									tickvaluelist=(500 1000 1500 2000)));
				sidebar / align=top;
					entry "Office Furniture Sales" /
									textattrs=GraphTitleText(size=14pt) pad=(bottom=5px);
				endsidebar;
				sidebar / align=bottom;
					discretelegend "actual" "predict";
				endsidebar;
				layout prototype;
						barchart category=month response=actual /
										orient=horizontal fillattrs=GraphData1
										barwidth=.6 name="actual";
						barchart category=month response=predict /
										orient=horizontal fillattrs=GraphData2
										barwidth=.3 name="predict";
				endlayout;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.prdsale template=sidebar;
where country="U.S.A." and region="EAST" and
product in ("CHAIR" "DESK" "TABLE");
run;



/*Example 4: A Data Panel with an Inset in Each Cell*/

proc template;
	define statgraph panelinset;
		begingraph / designwidth=495px designheight=350px;
			layout datapanel classvars=(dose) / rows=1
								inset=(F PROB)
								insetopts=(textattrs=(size=7pt) halign=right valign=bottom);
				layout prototype;
					bandplot x=days limitupper=uclm limitlower=lclm / name="clm"
										display=(fill) fillattrs=GraphConfidence
										legendlabel="95% Confidence Limits";
					bandplot x=days limitupper=ucl limitlower=lcl / name="cli"
										display=(outline) outlineattrs=GraphPredictionLimits
										legendlabel="95% Prediction Limits";
					seriesplot x=days y=predicted / name="reg"
										lineattrs=graphFit legendlabel="Fit";
					scatterplot x=days y=response / primary=true
										markerattrs=(size=5px) datatransparency=.5;
				endlayout;
					sidebar / align=top;
						entry "Predicted Response to Dosage (mg) over Time" /
						textattrs=GraphTitleText pad=(bottom=10px);
					endsidebar;
					sidebar / align=bottom;
						discretelegend "reg" "clm" "cli" / across=3;
					endsidebar;
			endlayout;
		endgraph;
	end;
run;

data trial;
	do Dose = 100 to 300 by 100;
		do Days=1 to 30;
			do Subject=1 to 10;
				Response=log(days)*(400-dose)* .01*ranuni(1) + 50;
				output;
			end;
		end;
	end;
run;

proc glm data=trial alpha=.05 noprint outstat=outstat;
	by dose;
	model response=days / p cli clm;
	output out=stats
	lclm=lclm uclm=uclm lcl=lcl ucl=ucl predicted=predicted;
	run;
quit;

data inset;
	set outstat (keep=F PROB _TYPE_ where=(_TYPE_="SS1"));
	label F="F Value " PROB="Pr > F ";
	format F best6. PROB pvalue6.4;
run;
data stats2;
	merge stats inset;
run;
proc sgrender data=stats2 template=panelinset;
run;
