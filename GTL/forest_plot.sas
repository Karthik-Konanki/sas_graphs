%let mygpath=/folders/myfolders/sas_graph/GTL;
%let macroLoc=/folders/myfolders/sas_graph/GTL;

/*--Set up data set--*/
data forest;
   input StudyName $1-16 GroupId or lcl ucl wt N Var ZeroWt;
   label or='OR' lcl='LCL' ucl='UCL' wt='WT';
   format wt percent6.1;
   datalines;
Modano  (1967)    1  0.590 0.096 3.634  1    100  0.1  .
Borodan (1981)    1  0.464 0.201 1.074  3.5  300  0.1  0
Leighton (1972)   1  0.394 0.076 2.055  2    200  0.1  0
Novak   (1992)    1  0.490 0.088 2.737  2    200  0.1  .
Stawer  (1998)    1  1.250 0.479 3.261  3    300  0.1  .
Truark   (2002)   1  0.129 0.027 0.605  2.5  250  0.1  .
Fayney   (2005)   1  0.313 0.054 1.805  2    200  0.1  .
Intermediate      2  0.328 0.233 0.462  .    .    .    .
Modano  (1969)    1  0.429 0.070 2.620  2    200  0.1  .
Soloway (2000)    1  0.718 0.237 2.179  3    300  0.1  .
Adams   (1999)    1  0.143 0.082 0.250  4    400  0.1  .
Truark2  (2002)   1  0.129 0.027 0.605  2.5  250  0.1  .
Fayney2  (2005)   1  0.313 0.054 1.805  2    200  0.1  .
Modano2 (1969)    1  0.429 0.070 2.620  2    200  0.1  .
Soloway2(2000)    1  0.718 0.237 2.179  3    300  0.1  .
Adams2   (1999)   1  0.143 0.082 0.250  4    400  0.1  .
Overall           3  0.328 0.233 0.462  .    .    .    .
;
run;

options sasautos=("&macroLoc", sasautos);
options mautosource mprint mlogic;

ods listing close;
ods html image_dpi=100 style=listing path="&mygpath" file='forestplots.html';
ods graphics / reset width=600px height=400px;

/*--Forest Plot with common options--*/
%ForestMacro(data=forest, Study=StudyName, Group=GroupId, OddsRatio=or, LCL=lcl, UCL=ucl, 
         width=6.5in, Weight=wt, Bands=YES, GraphWalls=YES, DisplayCols=yes);
         
/*--Forest Plot with minimum options--*/
%ForestMacro(data=forest, Study=StudyName, Group=GroupId, OddsRatio=or, LCL=lcl, UCL=ucl);

/*--Forest Plot with additional statistics columns--*/
%ForestMacro(data=forest, Study=StudyName, Group=GroupId, OddsRatio=OR, LCL=lcl, UCL=ucl, 
        StatCol1=N, StatCol2=Var, Bands=NO, GraphWalls=NO, StatWalls=NO, Borders=NO);

/*--Forest Plot with ONLY additional statistics columns--*/
%ForestMacro(data=forest, Study=StudyName, Group=GroupId, OddsRatio=OR, LCL=lcl, UCL=ucl, 
        Weight=wt, DisplayCols=N, StatCol1=N, StatCol2=Var, StatCol3=OR, StatCol4=wt, GraphWalls=Yep, Borders=);

data ForestNoGroups;
   set Forest (where=(GroupId=1));
   drop GroupId;
run;

/*--Forest Plot with no statistics columns--*/
%ForestMacro(data=ForestNoGroups, Study=StudyName, OddsRatio=OR, LCL=lcl, UCL=ucl, 
        DisplayCols=YES, Weight=wt, GraphWalls=YES, StatWalls=yes, Borders=NO);

/*--Forest Plot with no statistics columns--*/
%ForestMacro(data=ForestNoGroups, Study=StudyName, OddsRatio=OR, LCL=lcl, UCL=ucl, 
        DisplayCols=YES, GraphWalls=YES, StatWalls=yes, Borders=NO);

/*--Set up data set--*/
data forest2;
   input StudyName $1-16 GroupId or lcl ucl wt N Var ZeroWt;
   label or='OR' lcl='LCL' ucl='UCL' wt='WT';
   format wt percent6.1;
   datalines;
Modano  (1967)    1  0.590 0.096 3.634  1    100  0.1  .
Borodan (1981)    1  0.464 0.201 1.074  3.5  300  0.1  0
Fayney   (2005)   1  0.313 0.054 1.805  2    200  0.1  .
Intermediate      2  0.328 0.233 0.462  .    .    .    .
Modano  (1969)    1  0.429 0.070 2.620  2    200  0.1  .
Soloway (2000)    1  0.718 0.237 2.179  3    300  0.1  .
Adams   (1999)    1  0.143 0.082 0.250  4    400  0.1  .
Truark2  (2002)   1  0.129 0.027 0.605  2.5  250  0.1  .
Overall           3  0.328 0.233 0.462  .    .    .    .
;
run;

/*--Forest Plot with common options--*/
%ForestMacro(data=forest2, Study=StudyName, Group=GroupId, OddsRatio=or, LCL=lcl, UCL=ucl, 
         Weight=wt, Bands=YES, GraphWalls=YES, DisplayCols=YES);

ods html close;
ods listing;
