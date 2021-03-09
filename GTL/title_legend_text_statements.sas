/*Using Titles and Footnotes*/

proc template;
	define statgraph textstatements;
		begingraph;
		entrytitle "Title One";
		entrytitle "Title Two";
			layout overlay;
				scatterplot x=height y=weight;
			endlayout;
		entryfootnote "Footnote One";
		entryfootnote "Footnote Two";
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=textstatements;
run;



proc template;
	define statgraph textstatements;
		begingraph;
		entryfootnote "Footnote One";
		entrytitle "Title One";
			layout overlay;
				scatterplot x=height y=weight;
			endlayout;
		entryfootnote "Footnote Two";
		entrytitle "Title Two";
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=textstatements;
run;


/*Using Text Entries in the Graphical Area*/

proc template;
	define statgraph textentry;
		begingraph;
			layout overlay;
				scatterplot x=height y=weight;
				entry halign=left "NOBS = 19" /
				valign=top border=true;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=textentry;
run;


/*Using Rich Text*/
proc template;
	define statgraph textentry;
		begingraph;
		entrytitle textattrs=(size=12pt color=red) "Student's "
					textattrs=(size=10pt color=blue style=italic) "Data";
			layout overlay;
				scatterplot x=height y=weight;
				entry halign=left "NOBS = 19" /
				valign=top border=true;
			endlayout;
		entryfootnote halign=left textattrs=(weight=bold) "XYZ Corp."
					  halign=right textattrs=(weight=normal) "30JUN08";
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=textentry;
run;


/*Generating Text Items with Dynamic Variables, Macro Variables, and Expressions*/

proc template;
	define statgraph textentry;
		begingraph;
		entrytitle textattrs=(size=12pt color=red) "Student's "
					textattrs=(size=10pt color=blue style=italic) "Data";
			layout overlay;
				scatterplot x=height y=weight;
				entry halign=left "NOBS = 19" /
				valign=top border=true;
			endlayout;
		entryfootnote halign=left textattrs=(weight=bold) "XYZ Corp."
					  halign=right textattrs=(weight=normal) SYSDATE;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=textentry;
run;




proc template;
	define statgraph textentry;
		begingraph;
		entrytitle textattrs=(size=12pt color=red) "Student's "
					textattrs=(size=10pt color=blue style=italic) "Data";
			layout overlay;
				scatterplot x=height y=weight;
				entry halign=left "NOBS = 19" /
				valign=top border=true;
			endlayout;
/*		entryfootnote halign=left textattrs=(weight=bold) "XYZ Corp."
					  halign=right textattrs=(weight=normal) SYSDATE;*/
		entryfootnote "Summary for " eval(put(today(),mmddyyd.));
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=textentry;
run;

/*Adding Subscripts, Superscripts, and Unicode Rendering*/

proc template;
	define statgraph textentry;
		begingraph;
		entrytitle textattrs=(size=12pt color=red) "Student's "
					textattrs=(size=10pt color=blue style=italic) "Data";
			layout overlay;
				scatterplot x=height y=weight;
				entry halign=left "NOBS = 19" /
				valign=top border=true;
			endlayout;
/*		entryfootnote halign=left textattrs=(weight=bold) "XYZ Corp."
					  halign=right textattrs=(weight=normal) SYSDATE;*/
		entryfootnote "Summary for " eval(put(today(),mmddyyd.));
		endgraph;
	end;
run;

/*Using Unicode Values in Labels*/

ods escapechar="^"; /* Define an escape character */
proc template;
	define statgraph fit;
		begingraph;
		entrytitle "Regression Fit Plot with CLM Band";
			layout overlay;
				modelband "clm" / display=(fill) name="band"
								legendlabel="^{unicode alpha}=.05";
				scatterplot x=height y=weight / primary=true;
				regressionplot x=height y=weight / alpha=.05 clm="clm"
				legendlabel="Linear Regression" name="fit";
				discretelegend "fit" "band";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=fit;
run;

/*Setting Text Background, Borders, and Padding*/

proc template;
	define statgraph tmpl1;
		begingraph;
		entrytitle "Regression Plot";
			layout overlay;
				modelband "clm";
				scatterplot x=height y=weight;
				regressionplot x=height y=weight / clm="clm" alpha=.05;
					entry {unicode alpha} " = .05" / autoalign=auto border=true
							opaque=true backgroundcolor=GraphConfidence:color;
			endlayout;
		endgraph;
	end;
proc sgrender data=sashelp.class template=tmpl1;
run;



proc template;
	define statgraph tmpl1;
		begingraph;
		entrytitle "Regression Plot";
			layout overlay;
				modelband "clm";
				scatterplot x=height y=weight;
				regressionplot x=height y=weight / clm="clm" alpha=.05;
					entry {unicode alpha} " = .05" / 
					pad=(left=3px right=3px top=0 bottom=0) border=true;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=tmpl1;
run;


proc template;
	define statgraph tmpl1;
		begingraph;
		entrytitle "Regression Plot";
			layout overlay;
				modelband "clm";
				scatterplot x=height y=weight;
				regressionplot x=height y=weight / clm="clm" alpha=.05;
					entry {unicode alpha} " = .05" / 
					pad=5px border=true;;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.class template=tmpl1;
run;



proc template;
	define statgraph padding;
		begingraph;
		entrytitle "Regression Plot" / pad=(bottom=10px);
		entryfootnote halign=right
						"Prepared with SAS" {unicode "00AE"x} " Software" /
						textattrs=(size=9pt) pad=(top=10px);
			layout overlay;
				modelband "clm";
				scatterplot x=height y=weight;
				regressionplot x=height y=weight / clm="clm" alpha=.05;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=padding;
run;


/*ENTRY Statements: Additional Control*/

/*Positioning ENTRY Text*/

proc template;
	define statgraph textentry;
		begingraph;
			layout overlay / pad=0;
				scatterplot x=height y=weight;
				entry halign=left "NOBS = 19" /
						valign=top border=true;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=textentry;
run;

proc template;
	define statgraph textentry;
		begingraph;
			layout overlay;
				histogram weight;
				entry "NOBS = 19" /
						autoalign=(topright topleft)
							border=true;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=textentry;
run;



proc template;
	define statgraph textentry;
		begingraph;
			layout overlay;
				scatterplot x=height y=weight;
				entry halign=left "NOBS = 19" /
							autoalign=auto border=true;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=textentry;
run;

/*Rotating ENTRY Text*/

data stock;
	set sashelp.stocks;
		where stock eq "Microsoft" and year(date) in (2004 2005);
		format Date2004 Date2005 date.
		Price2004 Price2005 dollar6.;
		label Date2004="2004" Date2005="2005";
		if year(date) = 2004 then do;
		Date2004=date;
		Vol2004=volume*10**-6;
		Price2004=adjclose;
		end;
		else if year(date)=2005 then do;
		Date2005=date;
		Vol2005=volume*10**-6;
		Price2005=adjclose;
		end;
		keep Date2004 Date2005 Vol2004
		Vol2005 Price2004 Price2005;
run;

/*Creating the Basic Lattice*/

proc template;
	define statgraph latticebasic;
		begingraph;
		entrytitle "Microsoft Stock Performance";
			layout lattice / columns=2 rows=2;
/* define row 1 */
				seriesplot y=price2004 x=date2004 / lineattrs=GraphData1;
				seriesplot y=price2005 x=date2005 / lineattrs=GraphData1;
/* define row 2 */
				needleplot y=vol2004 x=date2004 /
							lineattrs=GraphData2(thickness=2px pattern=solid);
				needleplot y=vol2005 x=date2005 /
							lineattrs= GraphData2(thickness=2px pattern=solid);
				rowheaders;
					layout gridded / columns=2;
						entry "Volume" / textattrs=GraphLabelText rotate=90;
						entry "(Millions of Shares)" / textattrs=GraphValueText rotate=90;
					endlayout;
					layout gridded / columns=2;
						entry "Price" / textattrs=GraphLabelText rotate=90;
						entry "(Adjusted Close)" / textattrs=GraphValueText rotate=90;
					endlayout;
				endrowheaders;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=stock template=latticebasic;
run;

/*ADDING LEGENDS TO YOUR GRAPH*/

/*Example Legend Coding for Common Situations*/


proc template;
	define statgraph order;
		begingraph;
			layout overlay;
				scatterplot x=height y=weight / group=sex name="scatter";
				discretelegend "scatter";
			endlayout;
		endgraph;
	end;
run;
proc sort data=sashelp.class out=class;
	by age;
run;
proc sgrender data=class template=order;
run;


/*Identify Overlaid Plots in a Legend*/

proc template;
	define statgraph series;
		begingraph;
			layout overlay / cycleattrs=true;
				seriesplot X=date Y=close / name="sp1" ;
				seriesplot X=date Y=low / name="sp2" ;
				seriesplot X=date Y=high / name="sp3" ;
				discretelegend "sp3" "sp2" "sp1";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=series;
	format high low close dollar.;
	where year(date)=2001 and stock="IBM";
run;

/*Show Group Values and Identify Plots in a Legend*/

proc template;
	define statgraph compoundLegend;
		begingraph;
			layout overlay;
				scatterplot x=height y=weight / group=sex name="scatter";
				loessplot x=height y=weight / name="Loess";
				discretelegend "Loess" "scatter";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=compoundlegend;
run;

/*Show a Legend for a Continuous Response Variable (Scatter Plot)*/

proc template;
	define statgraph order;
		begingraph;
			layout overlay;
				scatterplot x=age y=height / name="sc"
							markercolorgradient=weight
							markerattrs=(symbol=circlefilled);
				continuouslegend "sc" / title="Weight";
			endlayout;
		endgraph;
	end;
run;
proc sort data=sashelp.class out=class;
	by age;
run;
proc sgrender data=class template=order;
run;


/*Show a Legend for a Continuous Response Variable (contour plot)*/

proc template;
	define statgraph mygraphs.contour;
		begingraph;
			layout overlay;
				contourplotparm x=height y=weight z=density /
							contourtype=gradient name="con";
				continuouslegend "con" / title="Density";
			endlayout;
		endgraph;
	end;
run;
ods graphics / antialiasmax=3600;
proc sgrender data=sashelp.gridded template=mygraphs.contour;
	where height>=53 and weight<=225;
run;


/*Overview of the Legend Placement Options*/

/*Displaying Legends outside of the Plot Wall*/

proc template;
	define statgraph location1;
		begingraph;
		entrytitle "Default Legend Position:";
		entrytitle "LOCATION=OUTSIDE";
		entrytitle "HALIGN=CENTER VALIGN=BOTTOM";
			layout overlay;
				scatterplot X=Height Y=Weight / name="sp" group=sex;
				discretelegend "sp" /
								location=outside halign=center valign=bottom;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=location1;
run;


proc template;
	define statgraph location1;
		begingraph;
		entrytitle "Default Legend Position:";
		entrytitle "LOCATION=OUTSIDE";
		entrytitle "HALIGN=RIGHT VALIGN=CENTER";
			layout overlay;
				scatterplot X=Height Y=Weight / name="sp" group=sex;
				discretelegend "sp" /
								location=outside halign=right valign=center;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=location1;
run;


/*Displaying Legends inside the Plot Wall*/

proc template;
	define statgraph location1;
		begingraph;
		entrytitle "Default Legend Position:";
		entrytitle "LOCATION=OUTSIDE";
		entrytitle "HALIGN=RIGHT VALIGN=CENTER";
			layout overlay;
				scatterplot X=Height Y=Weight / name="sp" group=sex;
				discretelegend "sp" /
								location=inside halign=right valign=bottom;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=location1;
run;

/*Automatically Aligning an Inside Legend*/

proc template;
	define statgraph histoloc;
		begingraph;
		entrytitle "LOCATION=INSIDE";
		entrytitle "AUTOALIGN=(TOPRIGHT TOPLEFT)";
			layout overlay;
				histogram Weight / name="sp";
				densityplot Weight / kernel()
								legendlabel="Kernel Density"
								name="kde";
				discretelegend "kde" /
									location=inside
									autoalign=(topright topleft);
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=histoloc;
run;



proc template;
	define statgraph autoloc;
		begingraph;
		entrytitle "LOCATION=INSIDE";
		entrytitle "AUTOALIGN=AUTO";
			layout overlay;
				scatterplot X=Height Y=Weight / name="sp" group=sex;
				discretelegend "sp" / location=inside autoalign=auto;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=autoloc;
run;


/*Using a Legend Title and Title Border*/

proc template;
	define statgraph histoloc;
		begingraph;
			layout overlay;
				histogram Weight / name="sp";
				densityplot Weight / normal()
							legendlabel="Normal" name="norm"
							lineattrs=GraphData1;
				densityplot Weight / kernel()
							legendlabel="Kernel" name="kde"
							lineattrs=GraphData2;
				discretelegend "norm" "kde" /
							location=inside across=1
							autoalign=(topright topleft)
					title="Theoretical Distributions"
									titleborder=true;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=histoloc;
run;

/*Legend Border*/

proc template;
	define statgraph histoloc;
		begingraph;
			layout overlay;
				histogram Weight / name="sp";
				densityplot Weight / normal()
								legendlabel="Normal" name="norm"
								lineattrs=GraphData1;
				densityplot Weight / kernel()
								legendlabel="Kernel" name="kde"
								lineattrs=GraphData2;
				discretelegend "norm" "kde" /
								location=inside across=1
								autoalign=(topright topleft)
								title="Theoretical Distributions"
								titleborder=true
								borderattrs=(thickness=2);
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=histoloc;
run;


/*Legend Text Properties*/

proc template;
	define statgraph histoloc;
		begingraph;
			layout overlay;
				histogram Weight / name="sp";
						densityplot Weight / normal()
						legendlabel="Normal" name="norm"
						lineattrs=GraphData1;
				densityplot Weight / kernel()
						legendlabel="Kernel" name="kde"
						lineattrs=GraphData2;
				discretelegend "norm" "kde" /
						location=inside across=1
						autoalign=(topright topleft)
				title="Theoretical Distributions"
						border=false valueattrs=(color=gray)
						titleattrs=GraphValueText(color=gray);
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=histoloc;
run;


/*Ordering the Legend Entries for a Grouped Plot*/

proc template;
	define statgraph order;
		dynamic TITLE;
		begingraph;
		entrytitle TITLE;
			layout overlay;
				scatterplot x=height y=weight / name="sp"
									group=age;
				discretelegend "sp" / title="Age";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=order;
	dynamic title="Default Order of Legend Entries";
run;


proc template;
	define statgraph order;
		dynamic TITLE;
		begingraph;
		entrytitle TITLE;
			layout overlay;
				scatterplot x=height y=weight / name="sp" group=age;
				discretelegend "sp" / title="Age" sortorder=ascendingformatted;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=order;
	dynamic title="Default Order of Legend Entries";
run;

/*Formatting the Data*/

proc format;
	value teenfmt 
		low-12 = "Pre-Teen"
		13-19 = "Teen"
		20-high = "Adult";
run;

proc sort data=sashelp.class out=class;
	by age;
run;
proc sgrender data=class template=order;
	format age teenfmt.;
	dynamic
	title="Formatted Order of Legend Entries";
run;

/*Varying Visual Properties*/

proc template;
	define statgraph series;
		begingraph;
			layout overlay / xaxisopts=(timeopts=(tickvalueformat=data))
							yaxisopts=(display=(ticks tickvalues)) cycleattrs=true;
				seriesplot x=month y=actual / name="a";
				seriesplot x=month y=predict / name="p";
				discretelegend "a" "p" / valign=bottom;
				discretelegend "p" "a" / valign=top;
		endlayout;
	endgraph;
end;
run;
proc sgrender data=sashelp.prdsale template=series;
	format month Monname3. actual predict dollar.;
	where year=1994 and product="DESK" and division="EDUCATION"
	and country="CANADA" and region="WEST";
run;


/*Assigning Legend Entry Labels*/


proc template;
	define statgraph series;
		begingraph;
			layout overlay / yaxisopts=(label="Sales") cycleattrs=true;
				seriesplot x=month y=actual / name="a"
								legendlabel="Actual";
				seriesplot x=month y=predict / name="p"
								legendlabel="Predicted";
				discretelegend "a" "p"/ valign=bottom;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.prdsale template=series;
	format month Monname3. actual predict dollar.;
	where year=1994 and product="DESK" and division="EDUCATION"
	and country="CANADA" and region="WEST";
run;



/*Organizing Legend Entries in a Fixed Number of Columns*/
proc template;
	define statgraph order;
		begingraph;
		entrytitle "ORDER=ROWMAJOR ACROSS=1";
			layout overlay;
				scatterplot x=Height y=Weight / name="sp" group=age;
				discretelegend "sp" / title="Age"
						halign=right valign=center order=rowmajor across=1;
			endlayout;
		endgraph;
	end;
run;
proc sort data=sashelp.class out=class;
	by age;
run;
proc sgrender data=class template=order;
run;



proc template;
	define statgraph order;
		begingraph;
		entrytitle "ORDER=ROWMAJOR ACROSS=2";
			layout overlay;
				scatterplot x=Height y=Weight / name="sp"
							group=age;
				discretelegend "sp" / title="Age"
							halign=right valign=center
							order=rowmajor across=2;
			endlayout;
		endgraph;
	end;
run;
proc sort data=sashelp.class out=class;
	by age;
run;
proc sgrender data=class template=order;
run;

/*Organizing Legend Entries in a Fixed Number of Rows*/


proc template;
	define statgraph order;
		begingraph;
		entrytitle "ORDER=COLUMNMAJOR ACROSS=1";
			layout overlay;
				scatterplot x=Height y=Weight / name="sp"
									group=age;
				discretelegend "sp" / title="Age"
									order=columnmajor down=1;
			endlayout;
		endgraph;
	end;
run;
proc sort data=sashelp.class out=class;
	by age;
run;
proc sgrender data=class template=order;
run;



proc template;
	define statgraph order;
		begingraph;
		entrytitle "ORDER=COLUMNMAJOR ACROSS=2";
			layout overlay;
				scatterplot x=Height y=Weight / name="sp"
									group=age;
				discretelegend "sp" / title="Age"
									order=columnmajor down=2;
			endlayout;
		endgraph;
	end;
run;
proc sort data=sashelp.class out=class;
	by age;
run;
proc sgrender data=class template=order;
run;


/*Controlling the Label and Item Size*/

proc template;
	define statgraph order;
		begingraph;
		entrytitle "ORDER=COLUMNMAJOR ACROSS=2";
			layout overlay;
				scatterplot x=Height y=Weight / name="sp2" group=age;
				discretelegend "sp2" / title="Age"
							valueattrs=(size=12pt) autoitemsize=true;
			endlayout;
		endgraph;
	end;
run;
proc sort data=sashelp.class out=class;
	by age;
run;
proc sgrender data=class template=order;
run;

/*Adding Items to a Discrete Legend*/

proc template;
	define statgraph additem;
		dynamic legenditem;
		begingraph;
		entrytitle "Height vs. Weight By Age";
			legenditem type=marker name="newitem" / label="17"
								lineattrs=(color=red)
								markerattrs=(symbol=starfilled color=red);
			layout overlay;
				scatterplot x=height y=weight / group=age
										name="heightweight";
				discretelegend "heightweight" "newitem";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=additem;
run;


/*Removing Items from a Discrete Legend*/

proc template;
	define statgraph order;
		begingraph;
			layout overlay;
				scatterplot X=Height Y=Weight / name="sp" group=age
									datalabel=age;
				discretelegend "sp" / title="Age"
							sortorder=ascendingformatted
							exclude=("13" "15");
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=order;
run;


/*Filtering Items from Multiple Plots with the TYPE= Option*/

proc template;
	define statgraph plots;
		begingraph;
		entrytitle "Closing Price and Volume for 2002";
			Layout overlay;
				seriesplot x=date y=close / group=stock name="plot1" display=all;
				discretelegend "plot1" / title="Stock" type=marker;
			endLayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=plots;
	where date between '01JAN2002'd AND '31DEC2002'd;
run;


/*Merging Legend Items from Two Plots into One Legend*/


proc template;
	define statgraph plots;
		begingraph;
		entrytitle "Closing Price and Volume for 2002";
			Layout overlay /
							xaxisopts=(griddisplay=on gridattrs=(color=lightgray pattern=dot))
							yaxisopts=(griddisplay=on gridattrs=(color=lightgray pattern=dot));
				seriesplot x=date y=close / group=stock name="plot1";
				scatterplot x=date y=volume / group=stock name="plot2" yaxis=y2;
				discretelegend "plot1" "plot2" / title="Discrete Legend"
							across=2 down=3 valign=bottom order=columnmajor halign=left;
				mergedlegend "plot1" "plot2" / title="Merged Legend"
							sortorder=ascendingformatted across=1 valign=bottom halign=right;
			endLayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=plots;
	where date between '01JAN2002'd AND '31DEC2002'd;
run;

/*Creating a Global Legend*/

proc template;
	define statgraph foo;
		begingraph;
			layout lattice;
				entrytitle "Asian Makes - MSRP Under $15,000";
				Layout overlay / xaxisopts=(display=(ticks tickvalues line))
								yaxisopts=(griddisplay=on gridattrs=(color=lightgray
								pattern=dot));
					barchart category=type response=mpg_city / group=make name="bar"
												stat=mean groupdisplay=cluster barwidth=0.75;
				endLayout;
				Layout overlay / xaxisopts=(display=(ticks tickvalues line))
								yaxisopts=(griddisplay=on gridattrs=(color=lightgray pattern=dot));
					scatterplot x=make y=msrp / group=type name="scatter";
				endLayout;
			endlayout;
			layout globallegend / type=row weights=preferred
									legendtitleposition=top;
				discretelegend "bar" / across=3
								title="Make" titleattrs=(weight=bold);
				discretelegend "scatter" / sortorder=ascendingformatted
								title="Type" titleattrs=(weight=bold);
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.cars template=foo;
	where origin="Asia" && msrp <= 15000;
run;

/*When Discrete Legends Get Too Large*/

proc template;
	define statgraph legendsize;
		begingraph / designwidth=495px designheight=220px;
		entrytitle "Legend Drops out with GROUP=NAME";
			layout overlay;
				scatterplot x=Height y=Weight / name="sp" group=name;
				discretelegend "sp" / title="Name" across=2 halign=right;
			endlayout;
		endgraph;
	end;
run;
proc sort data=sashelp.class out=class; 
	by name; 
run;
proc sgrender data=class template=legendsize;
run;


ods graphics / maxlegendarea=100;
proc sgrender data=class template=legendsize;
run;


proc template;
	define statgraph legendsize;
		begingraph / designwidth=495px designheight=220px;
		entrytitle "Legend Drops out with GROUP=NAME";
			layout overlay;
				scatterplot x=Height y=Weight / name="sp" group=name;
				discretelegend "sp" / title="Name" across=2 halign=right displayclipped=true;
			endlayout;
		endgraph;
	end;
run;
proc sort data=sashelp.class out=class; 
	by name; 
run;
proc sgrender data=class template=legendsize;
run;



proc template;
	define statgraph legendsize;
		begingraph / designwidth=495px designheight=220px;
		entrytitle "Legend Drops out with GROUP=NAME";
			layout overlay;
				scatterplot x=Height y=Weight / name="sp" group=name;
				discretelegend "sp" / title="Name" across=2 halign=right autoitemsize=true
						valueattrs=(size=7pt) titleattrs=(size=8pt);
			endlayout;
		endgraph;
	end;
run;
proc sort data=sashelp.class out=class; 
	by name; 
run;
proc sgrender data=class template=legendsize;
run;



/*Plots That Can Use Continuous Legends*/

proc template;
	define statgraph contour;
		begingraph;
		entrytitle "CONTOURTYPE=FILL";
			layout overlay / xaxisopts=(offsetmin=0 offsetmax=0)
							yaxisopts=(offsetmin=0 offsetmax=0);
				contourplotparm x=Height y=Weight z=Density / name="cont"
								contourtype=fill;
				continuouslegend "cont" / title="Density";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.gridded template=contour;
	where height>=53 and weight<=225;
run;



proc template;
	define statgraph contour;
		begingraph;
		entrytitle "CONTOURTYPE=FILL";
			layout overlay / xaxisopts=(offsetmin=0 offsetmax=0)
							yaxisopts=(offsetmin=0 offsetmax=0);
				contourplotparm x=Height y=Weight
								z=Density / name="cont"
								contourtype=fill nhint=10;
				continuouslegend "cont" /
								title="Density";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.gridded template=contour;
	where height>=53 and weight<=225;
run;


proc template;
	define statgraph contour;
		begingraph;
		entrytitle "CONTOURTYPE=GRADIENT";
			layout overlay / xaxisopts=(offsetmin=0 offsetmax=0)
							yaxisopts=(offsetmin=0 offsetmax=0);
				contourplotparm x=Height y=Weight z=Density / name="cont"
							contourtype=gradient;
				continuouslegend "cont" / title="Density" valuecounthint=5;
			endlayout;
		endgraph;
	end;
run;
ods graphics / antialiasmax=3600;
proc sgrender data=sashelp.gridded template=contour;
where height>=53 and weight<=225;
run;


/*Using Color Gradients to Represent Response Values*/

ods escapechar="^"; /* Define an escape character */
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
								title="Temperature (^{unicode '00B0'x}F)"
								halign=right;
			endlayout;
		endgraph;
	end;
run;
data lake;
	set sashelp.lake;
	if depth = 0 then Temperature=46;
	else Temperature=46+depth;
run;
/* create smoothed interpolated spline data for surface */
proc g3grid data=lake out=spline;
	grid width*length = depth temperature / naxis1=75 naxis2=75 spline;
run;
proc sgrender data=spline template=surfaceplot;
run;




ods escapechar="^"; /* Define an escape character */
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
								title="Temperature (^{unicode '00B0'x}F)"
								valign=bottom;
			endlayout;
		endgraph;
	end;
run;
data lake;
	set sashelp.lake;
	if depth = 0 then Temperature=46;
	else Temperature=46+depth;
run;
/* create smoothed interpolated spline data for surface */
proc g3grid data=lake out=spline;
	grid width*length = depth temperature / naxis1=75 naxis2=75 spline;
run;
proc sgrender data=spline template=surfaceplot;
run;


/*Uses for Insets in a Graph*/

/*Creating a Simple Inset with an ENTRY Statement*/

proc template;
	define statgraph ginset;
		begingraph;
		entrytitle "Simple One Line Inset";
			layout overlay;
				ellipse x=height y=weight / alpha=.1 type=predicted display=all;
				scatterplot x=height y=weight;
				entry "Prediction Ellipse (" {unicode alpha} "=.1)" /
								autoalign=auto;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=ginset;
run;

/*

layout gridded / columns=1 border=true;
entry halign=left "N" halign=right "5203";
entry halign=left "Mean" halign=right "119.96";
entry halign=left "Std Dev" halign=right "19.98";
endlayout;

*/

/*
layout gridded / columns=2 order=rowmajor border=true;
-------row 1-------
entry halign=left "N";
entry halign=left "5203";
-------row 2-------
entry halign=left "Mean";
entry halign=left "119.96";
-------row 3-------
entry halign=left "Std Dev";
entry halign=left "19.98";
endlayout;

*/


/*

layout gridded / rows=3 order=columnmajor border=true;
-------column 1-------
entry halign=left "N";
entry halign=left "Mean";
entry halign=left "Std Dev";
-------column 2-------
entry halign=left "5203";
entry halign=left "119.96";
entry halign=left "19.98";
endlayout;

*/


/*

layout gridded / rows=3 order=columnmajor
columngutter=5px border=true;
-------column 1-------
entry halign=left "N" / border=true;
entry halign=left "Mean" / border=true;
entry halign=left "Std Dev" / border=true;
-------column 2-------
entry halign=right "5203" / border=true;
entry halign=right "119.96" / border=true;
entry halign=right "19.98" / border=true;
endlayout;

*/

/*
layout gridded / columns=1;
entry textattrs=(weight=bold) "Stat Table";
layout gridded / rows=3 order=columnmajor border=true;
-------column 1-------
entry halign=left "N";
entry halign=left "Mean";
entry halign=left "Std Dev";
-------column 2-------
entry halign=left "5203";
entry halign=left "119.96";
entry halign=left "19.98";
endlayout;
endlayout;

*/

/*Positioning an Inset*/

proc template;
	define statgraph ginset3a;
		begingraph;
		entrytitle "Auto-positioning the Inset Within the Plot Wall";
			layout overlay;
				histogram mrw;
				layout gridded / columns=1 border=true;
					entry halign=left "N" halign=right "5203";
					entry halign=left "Mean" halign=right "119.96";
					entry halign=left "Std Dev" halign=right "19.98";
				endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.heart template=ginset3a;
run;


proc template;
	define statgraph ginset3a;
		begingraph;
		entrytitle "Auto-positioning the Inset Within the Plot Wall";
			layout overlay;
				histogram mrw;
				layout gridded / columns=2 order=rowmajor border=true;
					/*-------row 1-------*/
					entry halign=left "N";
					entry halign=left "5203";
					/*-------row 2-------*/
					entry halign=left "Mean";
					entry halign=left "119.96";
					/*-------row 3-------*/
					entry halign=left "Std Dev";
					entry halign=left "19.98";
				endlayout;

			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.heart template=ginset3a;
run;


proc template;
	define statgraph ginset3a;
		begingraph;
		entrytitle "Auto-positioning the Inset Within the Plot Wall";
			layout overlay;
				histogram mrw;
				layout gridded / rows=3 order=columnmajor border=true;
					/*-------column 1-------*/
					entry halign=left "N";
					entry halign=left "Mean";
					entry halign=left "Std Dev";
					/*-------column 2-------*/
					entry halign=left "5203";
					entry halign=left "119.96";
					entry halign=left "19.98";
				endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.heart template=ginset3a;
run;

proc template;
	define statgraph ginset3a;
		begingraph;
		entrytitle "Auto-positioning the Inset Within the Plot Wall";
			layout overlay;
				histogram mrw;
				layout gridded / columns=1;
					entry textattrs=(weight=bold) "Stat Table";
					layout gridded / rows=3 order=columnmajor border=true;
						/*-------column 1-------*/
						entry halign=left "N";
						entry halign=left "Mean";
						entry halign=left "Std Dev";
						/*-------column 2-------*/
						entry halign=left "5203";
						entry halign=left "119.96";
						entry halign=left "19.98";
					endlayout;
				endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.heart template=ginset3a;
run;


proc template;
	define statgraph ginset3a;
		begingraph;
		entrytitle "Auto-positioning the Inset Within the Plot Wall";
			layout overlay;
				histogram mrw;
				layout gridded / columns=1 border=true
					autoalign=(topright topleft);
					entry halign=left "N" halign=right "5203";
					entry halign=left "Mean" halign=right "119.96";
					entry halign=left "Std Dev" halign=right "19.98";
				endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.heart template=ginset3a;
run;


/*Outside Insets*/

proc template;
	define statgraph ginset3b;
		begingraph / pad=2px;
		entrytitle "Positioning the Inset Outside the Plot Wall";
			layout lattice;
				layout overlay;
					histogram mrw;
				endlayout;
				sidebar / align=right;
				layout overlay / pad=(left=2px);
				layout gridded / columns=1 border=true;
					entry halign=left "N" halign=right "5203";
					entry halign=left "Mean" halign=right "119.96";
					entry halign=left "Std Dev" halign=right "19.98";
				endlayout;
				endlayout;
				endsidebar;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.heart template=ginset3b;
run;


proc template;
	define statgraph ginset3b;
		begingraph / pad=2px;
		entrytitle "Positioning the Inset Outside the Plot Wall";
			layout lattice;
				layout overlay;
					histogram mrw;
				endlayout;
				sidebar / align=right;
				layout overlay / pad=(left=2px);
				layout gridded / columns=1 border=true
								opaque=true backgroundcolor=lightyellow border=true;
					entry halign=left "N" halign=right "5203";
					entry halign=left "Mean" halign=right "119.96";
					entry halign=left "Std Dev" halign=right "19.98";
				endlayout;
				endlayout;
				endsidebar;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.heart template=ginset3b;
run;

/*Creating an Inset with Values That Are Computed in the Template*/

proc template;
	define statgraph ginset4a;
		dynamic VAR;
		begingraph;
		entrytitle "Two Column Inset with Computed Values";
			layout overlay;
				histogram VAR;
				layout gridded / rows=3 order=columnmajor border=true
								autoalign=(topright topleft);
				/* column 1 */
					entry halign=left "N";
					entry halign=left "Mean";
					entry halign=left "Std Dev";
				/* column 2 */
					entry halign=left eval(strip(put(n(VAR),12.0)));
					entry halign=left eval(strip(put(mean(VAR),12.2)));
					entry halign=left eval(strip(put(stddev(VAR),12.2)));
				endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.heart template=ginset4a;
dynamic VAR="mrw";
run;

/*Creating a Template That Uses Macro Variables*/

proc template;
	define statgraph ginset;
		MVAR VAR NOBS MEAN STD TEST TESTLABEL STAT PTYPE PVALUE;
		begingraph;
		entrytitle "Histogram of " eval(colname(VAR));
		entrytitle "with Fitted Normal Distribution";
			layout overlay;
				histogram VAR;
				densityplot VAR / normal();
			/* inset for normality test */
				layout gridded / columns=1 opaque=true
									autoalign=(topright topleft);
					entry TEST / textattrs=(weight=bold);
					entry "Test for Normality " TESTLABEL /
					textattrs=(weight=bold);
					layout gridded / columns=2 border=true;
					entry "Value"; entry PTYPE;
					entry STAT; entry PVALUE;
				endlayout;
			endlayout;
			/* inset for descriptive statistics */
				layout gridded / columns=2 border=true
										opaque=true autoalign=(right left);
					entry halign=left "Nobs"; entry halign=left NOBS;
					entry halign=left "Mean"; entry halign=left MEAN;
					entry halign=left "Std Dev"; entry halign=left STD;
				endlayout;
			endlayout;
		endgraph;
	end;
run;

%macro histogram(dsn,var);
/* compute tests for normality */
	ods output TestsForNormality=norm;
		proc univariate data=&dsn normaltest;
			var &var;
			output out=stats n=n mean=mean std=std;
		run;
	%local nobs mean std test testlabel stat ptype pvalue;
data _null_;
	set stats(keep=n mean std);
	call symputx("nobs",n);
	call symput("mean",strip(put(mean,12.3)));
	call symput("std",strip(put(std,12.4)));
	if n > 2000 then /* use Shapiro-Wilk */
	set norm(where=(TestLab="D"));
	else /* use Kolmogorov-Smirnov */
	set norm(where=(TestLab="W"));
	call symput("testlabel","("||trim(testlab)||")");
	call symput("test",strip(test));
	call symput("ptype",strip(ptype));
	call symput("stat",strip(put(stat,best8.)));
	call symput("pvalue",psign||put(pvalue,pvalue6.4));
run;
proc sgrender data=&dsn template=ginset;
run;
%mend;

%histogram(sashelp.heart, mrw);
%histogram(sashelp.cars,invoice);

/*Adding Insets to a SCATTERPLOTMATRIX Graph*/

proc template;
	define statgraph spminset;
		begingraph;
		entrytitle "Scatter Plot Matrix with Insets Showing";
		entrytitle "Correlation Coefficients and P Values";
			layout gridded;
				scatterplotmatrix sepalwidth sepallength /
									rowvars=(petalwidth petallength)
									inset=(nobs pearson pearsonpval)
									insetopts=(autoalign=auto border=true opaque=true)
									corropts=(nomiss=true vardef=df)
									markerattrs=(size=5px);
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.iris template=spminset;
run;


/*Adding Insets By Using the Match-Merging Data Scheme*/

/* Generate the inset information and write it to data
set MILEAGE.
*/
proc summary data=sashelp.cars completetypes;
	where type in ("Sedan" "Truck" "SUV")
	and cylinders in (4 6 8);
	class cylinders origin;
	var mpg_city;
	output out=mileage mean=mean n=nobs / noinherit;
	types cylinders*origin;
run;

/* Sort the analysis data by the variables that are
used for the inset information: CYLINDERS, ORIGIN,
and TYPE.
*/
proc sort data=sashelp.cars out=cars;
	by cylinders origin type;
run;

/* Match-merge the analysis data with inset data by
CYLINDERS and ORIGIN.
*/
data avgmileage;
	merge cars mileage;
	by cylinders origin;
	format mean mpg_city 4.1;
run;

/* Create the graph template for the classification panel. */
proc template;
	define statgraph panel;
		begingraph;
		entrytitle "Average City MPG for Vehicles";
		entrytitle "by Origin, Cylinders and VehicleType";
			layout datalattice columnvar=origin rowvar=cylinders /
									columndatarange=unionall rowdatarange=unionall
									headerlabeldisplay=value
									headerbackgroundcolor=GraphAltBlock:color
									inset=(nobs mean)
									insetopts=(border=true datascheme=matched
									opaque=true backgroundcolor=GraphAltBlock:color)
									rowaxisopts=(offsetmax=.4 offsetmin=.1
									display=(tickvalues))
									columnaxisopts=(display=(label tickvalues)
									linearopts=(tickvaluepriority=true
									tickvaluesequence=(start=5 end=30 increment=5))
									griddisplay=on offsetmin=0 offsetmax=.1);
				layout prototype;
					barchart x=type Y=MPG_CITY / orient=horizontal
										stat=mean barwidth=.5 barlabel=true;
				endlayout;
			endlayout;
		endgraph;
	end;
run;

/* Generate the graph using the AVGMILEAGE data. */
proc sgrender data=avgmileage template=panel;
	where type in ("Sedan" "Truck" "SUV")
	and cylinders in (4 6 8);
run;


/*Adding Insets By Using the One-To-One-Merging Data Scheme*/

/* Compute the BARCHART data and inset information */
proc summary data=sashelp.cars completetypes;
	where type in ("Sedan" "Truck" "SUV") and
	cylinders in (4 6 8);
	class cylinders origin type;
	var mpg_city;
	output out=mileage(drop=_freq_) mean=Mean n=Nobs / noinherit;
	types cylinders*origin cylinders*origin*type;
run;

/* Extract the inset information, rename the columns,
and write it to data set Overall.
*/
data mileage (drop=_type_)
			overall(keep=origin cylinders mean nobs
	rename=(origin=cellOrigin cylinders=cellCyl mean=cellMean
	nobs=cellNobs ));
	set mileage; by _type_;
	if _type_ eq 6 then output overall;
	else output mileage;
run;


/* Merge MILEAGE and OVERALL and write to SUMMARY. */
data summary;
	merge mileage overall;
	label Mean="MPG (City)" CellNOBS="Nobs" CellMean="Mean";
	format mean cellMean 4.1;
run;

proc template;
	define statgraph panel;
		begingraph;
		entrytitle "Average City MPG for Vehicles";
		entrytitle "by Origin, Cylinders and VehicleType";
			layout datalattice columnvar=origin rowvar=cylinders /
									columndatarange=unionall rowdatarange=unionall
									headerlabeldisplay=value
									headerbackgroundcolor=GraphAltBlock:color
									inset=(cellNobs cellMean)
									insetopts=(border=true datascheme=list
									opaque=true backgroundcolor=GraphAltBlock:color)
									rowaxisopts=(offsetmax=.4 offsetmin=.1 display=(tickvalues))
									columnaxisopts=(display=(label tickvalues)
									linearopts=(tickvaluepriority=true
									tickvaluesequence=(start=5 end=30 increment=5))
									griddisplay=on offsetmin=0 offsetmax=.1);
				layout prototype;
					barchart category=type response=mean / orient=horizontal
											barwidth=.5 barlabel=true;
				endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=summary template=panel;
run;

/*Creating an Axis-Aligned Inset with a Block Plot*/

/* Create a data set of the release dates. */
data MSevents;
input Date date9. Release $7.;
datalines;
09dec1987 2.0
22may1990 3.0
01aug1993 NT 3.1
24aug1995 95
25jun1998 98
17feb2000 2000
25oct2001 XP
;
run;
/* Sort the Microsoft stock data by date. */
proc sort data=sashelp.stocks(keep=date stock adjclose)
	out=MSstock;
	where stock="Microsoft";
	by date;
run;
/* Match-merge the release data and the stock data. */
data events;
	merge msstock msevents;
	by date;
run;

/* Create the template for the graph. */
proc template;
	define statgraph blockplot1;
		begingraph;
		entrytitle "Microsoft Share Prices";
		entrytitle "and Significant OS Releases";
			layout overlay / yaxisopts=(offsetmax=0.075);
				blockplot x=date block=release /
					display=(outline values label)
					valuevalign=top valuehalign=left
					labelposition=top
					extendblockonmissing=true
					valueattrs=GraphDataText(weight=bold
					color=GraphData2:contrastcolor)
					labelattrs=GraphValueText(weight=bold
					color=GraphData2:contrastcolor)
					outlineattrs=(color=GraphGridLines:color);
				seriesplot x=date y=adjclose / lineattrs=GraphData1;
			endlayout;
		endgraph;
	end;
run;
/* Render the graph. */
proc sgrender data=events template=blockplot1;
	format date year4.;
run;

/* Create the template for the graph. */
proc template;
	define statgraph blockplot1a;
		begingraph;
		entrytitle "Microsoft Share Prices";
		entrytitle "and Significant OS Releases";
			layout overlay / yaxisopts=(offsetmax=0.075);
				blockplot x=date block=release / display=(fill values)
									valuevalign=top valuehalign=left
									labelposition=top
									extendblockonmissing=true
									valueattrs=GraphDataText(weight=bold)
									filltype=multicolor
									datatransparency=.5;
				seriesplot x=date y=adjClose / lineattrs=GraphData1;
			endlayout;
		endgraph;
	end;
run;
/* Render the graph. */
proc sgrender data=events template=blockplot1a;
	format date year4.;
run;

/*Creating an Axis-Aligned Table of Values with a Block Plot*/

/* Create summarized data with desired statistics */
proc summary data=sashelp.cars nway alpha=.05;
	class type;
	var mpg_highway;
	output out=stats(drop=_freq_ _type_)
	n=n mean=mean uclm=uclm lclm=lclm / noinherit;
run;

/* Transpose data for use with BLOCKPLOT */
proc transpose data=stats
	out=blockstats(rename=(type=type2 _name_=statname col1=stat));
	by type;
	attrib statname label=''; /* Remove the old label from statname */
	var n mean uclm lclm;
run;

/* Combine summary data for BARCHARTPARM with tabular data for BLOCKPLOT */
data all;
	merge stats blockstats;
run;

/*Create the template for the graph. */

proc template;
	define statgraph blockplot2;
		begingraph;
		entrytitle "Highway Mileage for Vehicle Types";
		entryfootnote halign=left {unicode alpha} " = .05";
			layout overlay / xaxisopts=(label="Type");
				innermargin / align=top;
				blockplot x=type2 block=stat / class=statname
									includemissingclass=false
									display=(values label outline) valuehalign=center
									labelattrs=GraphDataText valueattrs=GraphDataText
									outlineattrs=(color=graphaxislines:color);
				endinnermargin;
				barchartparm x=type y=mean /
											errorlower=lclm errorupper=uclm;
			endlayout;
		endgraph;
	end;
run;
/* Render the graph. */
proc sgrender data=all template=blockplot2;
run;


/*Creating an Axis-Aligned Inset with an Axis Table*/

/* Create the template for the graph. */
proc template;
	define statgraph axistable1;
		begingraph;
		entrytitle "Microsoft Share Prices";
		entrytitle "and Significant OS Releases";
			layout overlay;
				seriesplot x=date y=adjClose / lineattrs=GraphData1;
				referenceline x=eval(ifn(release ne " ",date,.)) /
										lineattrs=(color=lightgray);
				innermargin / align=top opaque=true;
					axistable x=date value=release /
										display=(label)
										valueattrs=(color=GraphData2:contrastcolor weight=bold)
										labelattrs=(color=GraphData2:contrastcolor weight=bold);
				endinnermargin;
			endlayout;
		endgraph;
	end;
run;
/* Render the graph. */
proc sgrender data=events template=axistable1;
run;

/*Creating an Axis-Aligned Table of Values with an Axis Table*/

/* Create the template for the graph. */
proc template;
	define statgraph axistable2;
		begingraph;
		entrytitle "Highway Mileage for Vehicle Types";
			layout overlay /
							xaxisopts=(discreteopts=(colorbands=even
							colorbandsattrs=(transparency=0.8)))
							yaxisopts=(offsetmax=0.25);
				barchartparm category=type response=mean /
				errorlower=lclm errorupper=uclm;
					axistable x=type value=n / position=0.95
					display=(label) labelattrs=GraphDataText;
					axistable x=type value=mean / position=0.90
					display=(label) labelattrs=GraphDataText;
					axistable x=type value=uclm / position=0.85
					display=(label) labelattrs=GraphDataText;
					axistable x=type value=lclm / position=0.80
					display=(label) labelattrs=GraphDataText;
			endlayout;
		endgraph;
	end;
run;
/* Render the graph. */
proc sgrender data=stats template=axistable2;
run;


/*Creating an Axis-Aligned Inset in a Classification Panel*/

/* Generate the data for the panel */
proc summary data=sashelp.cars completetypes;
	where type in ("Sedan" "Truck" "SUV") and
	cylinders in (4 6 8);
	class cylinders origin type;
	var mpg_city;
	output out=mileage(drop=_freq_) mean=Mean n=N / noinherit;
	types cylinders*origin cylinders*origin*type;
run;

/* Define the template for the panel */
proc template;
	define statgraph panel;
		begingraph;
		entrytitle "Average City MPG for Vehicles";
		entrytitle "by Origin, Cylinders and VehicleType";
			layout datalattice columnvar=origin rowvar=cylinders /
									columndatarange=unionall rowdatarange=unionall
									headerlabeldisplay=value
									headerbackgroundcolor=GraphAltBlock:color
									inset=(mean) insetopts=(autoalign=(top))
									insetopts=(border=true datascheme=matched
									opaque=true backgroundcolor=GraphAltBlock:color)
									rowaxisopts=(offsetmax=0.35 offsetmin=0.1
									display=(tickvalues))
									columnaxisopts=(label="MPG (City)"
									display=(label tickvalues)
									griddisplay=on offsetmin=0 offsetmax=.15
									linearopts=(tickvaluepriority=true
									tickvaluesequence=(start=5 end=30 increment=5)));
				layout prototype;
					barchart x=type y=mean / name="bar" barwidth=.5
										barlabel=true orient=horizontal;
						innermargin / backgroundcolor=GraphAltBlock:color
										opaque=true align=left;
							axistable y=type value=N / display=(label)
										valueattrs=GraphDataDefault
										labelattrs=GraphDataDefault;
						endinnermargin;
				endlayout;
			endlayout;
		endgraph;
	end;
run;
/* Generate the graph */
proc sgrender data=mileage template=panel;
	format Mean 4.1;
run;

/*Adding Graphics Elements to Your Graph*/

/*
DRAWTEXT <TEXTATTRS=(text-options)> "text" / X=x Y=y <options>
*/
/*
drawtext "A text string that contains more than one line of text" /
			x=100 y=70 drawspace=graphpixel
			width=120 widthunit=pixel
			anchor=left
			border=true borderattrs=(color=gray pattern=1);
*/

/* Adding Arrows and Lines

DRAWARROW X1=x1 Y1=y1 X2=x2 Y2=y2 / <options>

drawarrow x1=60 y1=70 x2=190 y2=70 / drawspace=graphpixel
			lineattrs=(color=black thickness=2px)
			arrowheadshape=barbed arrowheadscale=2 arrowheaddirection=both;


drawline x1=60 y1=70 x2=190 y2=70 / drawspace=graphpixel
				lineattrs=(pattern=3 thickness=1px);
*/


/*Adding Geometric Shapes

DRAWOVAL X=x Y=y WIDTH=width HEIGHT=height / <options>

drawoval x=115 y=110 width=90 height=110 / drawspace=graphpixel
				widthunit=pixel heightunit=pixel
				anchor=center
				display=all
				fillattrs=(color=lightgray)
				outlineattrs=(color=black thickness=2px);
*/

/*Rectangles

DRAWRECTANGLE X=x Y=y WIDTH=width HEIGHT=height / <options>

drawrectangle x=80 y=80 width=60 height=40 / drawspace=graphpixel
							widthunit=percent heightunit=percent
							anchor=bottomleft
							display=all
							fillattrs=(color=lightgray)
							outlineattrs=(color=black thickness=2px);
*/

/*Polylines

BEGINPOLYLINE X=origin-x Y=origin-y / <options>;
	DRAW X=x1 Y=y1;
	DRAW X=x2 Y=y2;
	...more DRAW statements...
	DRAW X=Xn Y=Yn;
ENDPOLYLINE;

beginpolyline x=30 y=150 / xspace=graphpixel yspace=graphpixel
lineattrs=(color=black thickness=2px);
draw x=110 y=150; --- Draw S1 ---
draw x=145 y=250; --- Draw S2 ---
draw x=170 y=50; --- Draw S3 ---
draw x=205 y=150; --- Draw S4 ---
draw x=285 y=150; --- Draw S5 ---
endpolyline;
*/

/*Polygons
BEGINPOLYGON X=origin-x Y=origin-y / <options>;
	DRAW X=x1 Y=y1;
	DRAW X=x2 Y=y2;
	...more DRAW statements...
	DRAW X=origin-x Y=origin-y;
ENDPOLYGON;

beginpolygon x=40 y=100 / xspace=graphpixel yspace=graphpixel
display=all fillattrs=(color=lightgray)
outlineattrs=(thickness=2px color=black);
draw x=30 y=220; --- Draw S1 ---
draw x=160 y=200; --- Draw S2 ---
draw x=180 y=80; --- Draw S3 ---
draw x=40 y=100; --- Draw S4 ---
endpolygon;

*/

/*Adding Images

DRAWIMAGE "image-file.ext" / X=x Y=x <options>

drawimage ".\images\saslogo.png" / x=70 y=60 drawspace=graphpixel
			anchor=bottomleft
			border=true borderattrs=(thickness=1px);

*/

/*ADDING DATA-DRIVEN ANNOTATIONS TO YOUR GRAPH*/

/*Creating an SG Annotation Data Set*/

data textdata;
	length function $9 label $60;
	function="text";
	drawspace="graphpixel"; x1=100; y1=70;
	width=190; widthunit="pixel"; anchor="left";
	border="true"; linecolor="gray"; linepattern="solid";
	label="A text string that contains normal text and";
	output; /* Write normal-text observation. */
	function="textcont";
	textcolor="blue";
	label=" rich text with Unicode and superscript characters:";
	output; /* Write blue-text observation. */
	label=" A = (*ESC*){unicode pi}R(*ESC*){sup '2'}";
	output; /* Write Unicode and superscript observation. */
run;

/*Adding Observations for Arrows and Lines*/

data arrowdata;
	function="arrow";
	drawspace="graphpixel";
	x1=60; y1=70; x2=190; y2=70;
	shape="barbed"; scale=1.5; direction="both";
	linepattern="solid"; linecolor="black"; linethickness=2;
run;

data linedata;
	function="line";
	drawspace="graphpixel";
	x1=60; y1=70; x2=190; y2=70;
	linepattern="shortdash"; linecolor="black"; linethickness=2;
run;

/*Adding Observations for Polylines and Polygons*/

data polylinedata;
	function="polyline";
	drawspace="graphpixel";
	linecolor="black"; linethickness=2;
	x1=30; y1=150; /* Begin polyline */
	output;
	function="polycont";
	x1=110; y1=150; /* Draw Segment 1 */
	output;
	x1=145; y1=250; /* Draw Segment 2 */
	output;
	x1=170; y1=50; /* Draw Segment 3 */
	output;
	x1=205; y1=150; /* Draw Segment 4 */
	output;
	x1=285; y1=150; /* Draw Segment 5 */
	output;
run;

data polygondata;
	length function $8;
	function="polygon";
	drawspace="graphpixel";
	x1=40; y1=100; /* Begin polygon */
	display="all"; fillcolor="lightgray";
	linecolor="black"; linethickness=2;
	output;
	function="polycont";
	x1=30; y1=220; /* Draw Segment 1 */
	output;
	x1=160; y1=200; /* Draw Segment 2 */
	output;
	x1=180; y1=80; /* Draw Segment 3 */
	output;
	x1=40; y1=100; /* Draw Segment 4 */
	output;
run;

/*Adding Observations for Ovals*/

data ovaldata;
	function="oval";
	drawspace="graphpixel";
	x1=115; y1=110;
	width=90; widthunit="pixel"; height=110; heightunit="pixel";
	display="all"; fillcolor="lightgray";
	linecolor="blue"; linepattern="shortdash";
run;


/*Adding Observations for Rectangles*/

data rectangledata;
	function="rectangle";
	drawspace="graphpixel";
	x1=80; y1=80; width=60; height=40; anchor="bottomleft";
	fillcolor="lightgray"; display="all";
	linecolor="black"; linethickness=2;
run;

/*Adding Observations for Images*/

data imagedata;
	function="image";
	drawspace="graphpixel";
	x1=70; y1=60;
	anchor="bottomleft";
	border="true";
	image=".\images\saslogo.png";
run;


/*Example 1: Creating Custom Labels*/

/* Summarize the highway mileage data in SASHELP.CARS. */
proc summary data=sashelp.cars nway;
	class type;
	var mpg_highway;
	output out=mileage mean(mpg_highway) = mpg_highway;
run;
/* Create the annotation data set. */
data anno;
	retain function "text" drawspace "datavalue"
	textfont "Arial" textweight "bold"
	textcolor "GraphData1:contrastColor"
	width 100 widthunit "pixel"
	anchor "left" x1 2
	discreteoffset 0.1;
	set mileage(keep=type);
	rename type=yc1;
	length label $12;
	label=type;
run;
/* Create the template. */
proc template;
	define statgraph barchart;
		begingraph;
		entrytitle "Average Highway Mileage by Vehicle Type";
			layout overlay /
							yaxisopts=(display=(label))
							xaxisopts=(label="Average Highway MPG" offsetmax=0.05);
				barchartparm category=type response=mpg_highway /
										orient=horizontal dataskin=sheen;
				annotate;
			endlayout;
		endgraph;
	end;
run;
/* Render the graph with the Anno annotation data set */
proc sgrender data=mileage template=barchart sganno=anno;
run;

/*Using the %SGTEXT Macro in the DATA Step*/

/* Sort Sashelp.Cars by Origin and summarize the mileage data */
proc sort data=sashelp.cars out=cars;
	by origin;
run;

proc summary data=cars nway mean;
	class type;
	by origin;
	var mpg_city mpg_highway;
	output out=mileage(drop=_type_ _freq_)
	mean(mpg_city mpg_highway) = mpg_city mpg_highway;
run;

/* Create variables for the inset positions. */

%let toprowpos=80; /* Y position of the insets (GRAPHPERCENT). */
%let labelpos=16; /* X position of the inset label (GRAPHPERCENT) */

/* Compile the annotation macros */

%sganno;

/* Create the annotation data set. */

data anno;
	set mileage end=_LAST; /* Base on Mileage data. */
	%sgtext(id=origin,
	label=put(round(mpg_city), F2.0) || " / " ||
	put(round(mpg_highway), F2.0),
	xc1=type,x1space="datavalue",
	y1=&toprowpos,y1space="graphpercent",
	border="true",anchor="center",justify="center",width=90);
	/* Add observations for the inset label to the end of the data. */
	if (_LAST) then do;
	%sgtext(reset=all,id="INSETLABEL",label="Avg. MPG",
	x1=&labelpos,x1space="graphpercent",
	y1=%eval(&toprowpos+1),y1space="graphpercent",
	border="false",anchor="right",width=90,justify="left");
	%sgtext(label="(City/Hwy)",y1=%eval(&toprowpos-3));
	end;
run;

/* Create the graph template and include the ANNOTATE statements. */

proc template;
	define statgraph barchart;
		dynamic _BYVAL_ _BYLINE_;
		begingraph / designwidth=450 designheight=360;
			entrytitle "Average Curb Weight by Vehicle Type";
			entrytitle "(" _BYLINE_ ")";
			layout overlay;
				layout overlay / pad=(top=40)
						yaxisopts=(label="Average Curb Weight (LBS)" offsetmax=0.2)
						xaxisopts=(label="Vehicle Type"
						discreteopts=(colorbands=even
						colorbandsattrs=(transparency=0.6)));
/* Generate the mileage bar chart */
					barchart x=type y=weight / stat=mean dataskin=gloss;
/* Draw the mileage annotations for this origin */
					annotate / ID="INSETLABEL"; /* Draw the inset label. */
					annotate / ID=_BYVAL_; /* Draw the bar insets. */
				endlayout;
			endlayout;
		endgraph;
	end;
run;
/* Render the graph by Origin with the Anno annotation data set */
options nobyline; /* Suppress the default BY line. */
proc sgrender data=cars template=barchart sganno=anno;
	by origin;
run;
options byline; /* Restore the default BY Line. */


