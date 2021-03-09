%macro AdverseEventRelativeRiskMacro(
       Data=,              /*--Data Set Name (Required)--*/
       Events=,            /*--Variable name for the adverse event (Required)--*/ 
       Drug1=,             /*--Variable name for Drug # 1 (Required)--*/
       Drug2=,             /*--Variable name for Drug # 2 (Required)--*/ 
       Drug3=,             /*--Variable name for Drug # 3 (Required)--*/ 
       Drug4=,             /*--Variable name for Drug # 4 (Required)--*/ 
       Risk=,              /*--Relative Risk value--*/ 
       UCL=,               /*--Upper Confidence Level--*/ 
       LCL=,               /*--Lower Confidence Level--*/
	   Title=,             /*--Graph Title--*/ 
       Title2=,            /*--Graph Sub Title--*/ 
       Footnote=,          /*--Graph Footnote--*/ 
       Footnote2=,         /*--Graph Footnote # 2--*/
	   CL=,                /*--Confidence value for Relateve Risk Label--*/ 
	   Width=6.4in,		   /*--Graph Width--*/
	   Height=,		       /*--Graph Height--*/
	   Bands=YES,          /*--Alternating Reference bands--*/
	   Grid=NO             /*--Gridlines on X axis--*/
);

%local dsid rc drug1label drug2label drug3label drug4label;
%local analysis1 analysis2 analysis3 analysis4 idx RelativeRisk Columns;
%local th1 th2 fh1 fh2 dsid count;
%local GraphWidth GraphHeight Ratio RowHeight HeaderHeight Nobs PlotHeight MaxObs ShowGrid;
%let idx=1;
%let MaxObs=100;

/*--Data, Events parameters are required--*/
%if %length(&Data) eq 0 %then %do;
  %put The parameter 'Data' is required - AdverseEventRelativeRisk Macro Terminated.;
  %goto finished;
%end;
%else %if %length(&Events) eq 0 %then %do;
  %put The parameter 'Events' is required - AdverseEventRelativeRisk Macro Terminated.;
  %goto finished;
%end;

/*--Upcase Bands option--*/
%if  %length(&Bands) ne 0 %then %do;
  %let Bands=%upcase(&Bands);
%end;

/*--Upcase Grid option--*/
%let ShowGrid=OFF;
%if  %length(&Grid) ne 0 %then %do;
  %let Grid=%upcase(&Grid);

  /*--Set ShowGrid macro variable--*/
  %if &Grid eq YES %then %do;
    %let ShowGrid=ON;
  %end;
%end;

/*--Initialize heights (font + gap) for title, title2, footnote, footnote2--*/
%let th1=0;
%if %length(&title) ne 0 %then %do;
  %let th1=16;
%end;

%let th2=0;
%if %length(&title2) ne 0 %then %do;
  %let th2=12;
%end;

%let fh1=0;
%if %length(&footnote) ne 0 %then %do;
  %let fh1=14;
%end;

%let fh2=0;
%if %length(&footnote2) ne 0 %then %do;
  %let fh2=14;
%end;

/*--Initialize GraphWidth RowHeight and HeaderHeight--*/
%let RowHeight=20;
%let HeaderHeight=%eval(120 + &th1+&th2+&fh1+&fh2);
%let GraphWidth=&Width;

/*--Count the number of drugs provided--*/
%if &drug1 ne %then %do;
%let analysis&idx = &drug1;
%let idx = %eval(&idx + 1); 
%end;
%if &drug2 ne %then %do;
%let analysis&idx = &drug2;
%let idx = %eval(&idx + 1); 
%end;
%if &drug3 ne %then %do;
%let analysis&idx = &drug3;
%let idx = %eval(&idx + 1); 
%end;
%if &drug4 ne %then %do;
%let analysis&idx = &drug4;
%let idx = %eval(&idx + 1); 
%end;

/*--Terminate if at least one treatment is not provided--*/
%if &idx eq 1 %then %do;
  %put The Macro needs at least one Treatment - AdverseEventRelativeRisk Macro Terminated.;
  %goto finished;
%end;

/*--If Risk data is not provided, disable second cell--*/
%let RelativeRisk=YES;
%let Columns=2;
%if  %length(&Risk) eq 0 %then %do;
  %let RelativeRisk=NO;
  %let Columns=1;
%end;

/*--Create Relative Risk Label--*/
%if  %length(&CL) eq 0 %then %do;
  %let RelativeRiskLabel=Relative Risk;
%end;
%else %do;
  %let RelativeRiskLabel=Relative Risk with &CL.% CL;
%end;

/*--Open data set to get Obs count--*/
%let dsid=%sysfunc(open(&Data));

%if &dsid %then %do;
  %let Nobs=%sysfunc(attrn(&dsid, nlobs));
  %if &Nobs eq 0 %then %do;
      %put The Data Set &Data has no observations - Adverse Event Macro Terminated.;
      %let rc=%sysfunc(close(&dsid)); 
      %goto finished;
  %end;

  %if &Nobs gt &MaxObs %then %do;
      %put The Data Set &Data has over &MaxObs observations - Adverse Event Macro Terminated.;
      %let rc=%sysfunc(close(&dsid)); 
      %goto finished;
  %end;

  /*--Create LegendLabels from drug variable labels--*/

  %if &analysis1 ne %then %do;
     %let drug1label=%sysfunc(varlabel(&dsid, %sysfunc(varnum(&dsid,&analysis1))));
  	 %if &drug1label eq %then %let drug1label=&analysis1;
  %end;
  %if &analysis2 ne %then %do;
     %let drug2label=%sysfunc(varlabel(&dsid, %sysfunc(varnum(&dsid,&analysis2))));
  	 %if &drug2label eq %then %let drug2label=&analysis2;
  %end;
  %if &analysis3 ne %then %do;
     %let drug3label=%sysfunc(varlabel(&dsid, %sysfunc(varnum(&dsid,&analysis3))));
  	 %if &drug3label eq %then %let drug3label=&analysis3;
  %end;
  %if &analysis4 ne %then %do;
     %let drug4label=%sysfunc(varlabel(&dsid, %sysfunc(varnum(&dsid,&analysis4))));
  	 %if &drug4label eq %then %let drug4label=&analysis4;
  %end;

  %let rc=%sysfunc(close(&dsid));
%end;
%else %do;
    %put The data set &Data does not exist - Adverse Event Macro Terminated.;
    %goto finished;
%end;

/*--Estimate Height of graph--*/
%let PlotHeight=%eval(&Nobs * &RowHeight);
%if %length(&Height) ne 0 %then %do;
  %let GraphHeight=&Height;
%end;
%else %do;
  %let GraphHeight=%eval(&PlotHeight + &HeaderHeight);
  %let GraphHeight=&GraphHeight.px;
%end;

/*--Create GTL Template--*/
proc template;
  define statgraph TherapyAdverseEvents;
    begingraph / designwidth=&GraphWidth designheight=&GraphHeight;
	  %if &footnote ne %then %str(entryfootnote halign=left "&footnote";);
	  %if &footnote2 ne %then %str(entryfootnote halign=left "&footnote2";);

      layout lattice / columns=&Columns rowdatarange=union;
	    sidebar / align=top;
		  layout gridded / rows=2;
		    %if &title ne %then %str(entry "&title" / textattrs=GraphTitleText;);
	        %if &title2 ne %then %str(entry "&title2" / textattrs=GraphTitleText(size=GraphValueText:fontsize););
		  endlayout;
		endsidebar;

	    rowaxes;
		  rowaxis / display=(ticks tickvalues line) tickvalueattrs=(size=7);
		endrowaxes;

	    layout overlay / xaxisopts=(griddisplay=&ShowGrid label="Percent" tickvalueattrs=(size=7)
                         linearopts=(thresholdmax=0));
		  %if &Bands eq YES or &Bands eq Y %then %do;
            referenceline y=_EventRef / lineattrs=(thickness=&RowHeight) datatransparency=0.8;
		  %end;

		  %if &analysis1 ne %then
 	        %str(scatterplot x=&analysis1 y=&events / markerattrs=graphdata1(symbol=circlefilled size=11) name='a' legendlabel="&drug1label";);
		  %if &analysis2 ne %then
 	        %str(scatterplot x=&analysis2 y=&events / markerattrs=graphdata2(symbol=trianglefilled size=11) name='b' legendlabel="&drug2label";);
		  %if &analysis3 ne %then
 	        %str(scatterplot x=&analysis3 y=&events / markerattrs=graphdata3(symbol=squarefilled size=11) name='c' legendlabel="&drug3label";);
		  %if &analysis4 ne %then
 	        %str(scatterplot x=&analysis4 y=&events / markerattrs=graphdata4(symbol=diamondfilled size=11) name='d' legendlabel="&drug4label";);
        endlayout;
		%if &RelativeRisk eq YES %then %do;
	      layout overlay / xaxisopts=(label="&RelativeRiskLabel"
                                    griddisplay=&ShowGrid tickvalueattrs=(size=7)
                                    type=log logopts=(base=2 viewmin=0.125 viewmax=64 
                                    tickintervalstyle=logexpand));
		    %if &Bands eq YES or &Bands eq Y %then %do;
              referenceline y=_EventRef / lineattrs=(thickness=&RowHeight) datatransparency=0.8;
		    %end;

            scatterplot x=&risk y=&events / xerrorlower=&LCL xerrorupper=&UCL;
		    referenceline x=1 / lineattrs=graphdatadefault(pattern=shortdash);
		  endlayout;
	    %end;

      	sidebar / align=bottom spacefill=false;
		  discretelegend 'a' 'b' 'c' 'd' / border=true;
		endsidebar;

      endlayout;
    endgraph;
  end;
  run;

  /*--Sort data by Mean--*/
  %if &RelativeRisk eq YES %then %do;
    proc sort data=&data out=_ae1;
      by mean;
    run;
  %end;
  %else %do;
    data _ae1;
	  set &data;
	run;
  %end;

  /*--Duplicate alternate event for bands--*/
  data _ae2;
    set _ae1;
	if mod(_N_, 2) = 0 then _EventRef=&Events;
  run;

  proc sgrender data=_ae2 template=TherapyAdverseEvents;
  run;

  %finished:
%mend;

