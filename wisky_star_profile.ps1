
##===========================================================================##
Function stardm( $copt, $pdir) {
    if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } # else { $pdir = $pdir } ;
    # $lastlog=(gci ( ( gc *.log | Select-String $KW | select -last 1 )  ).Name ;
    $dmproj=(lastfext $pdir ".dmprj" ) ;
	if ( $copt -eq 'v' ) { $dmproj = ( selectfile $pdir ".dmprj" ) };
    $dmcase=$dmproj.Trim(".dmprj");
    $EXT="dmrun"; $OPTS="-dmnoshare -power -passtodesign `"-power`" -batch run $dmproj" ;
    Write-Host "`t will be running: `n`t   $OPTS";
    $NOW=(Get-Date -Format "yyyy-MM-dd-HH-mm");
    $SLOG="$dmcase" + "~" + $NOW + ".dmrun.log" ;

## ----------------------------------------------------------------
    $fsim = $dmproj;
    ( bextgo $OPTS $proj $fsim $SLOG );
    #Write-Output $BEXT ; sleep 1.0 ;
    #Invoke-Expression -Command $BEXT ;

} ##=================================================================##
##====================================================================##

#######################################################################

Function bextgo( $OPTS, $proj, $fsim, $SLOG ){	
   $here=$( pwd );  if ( -not $proj ) { $proj=$(pwd) } ; 
   $fm_dur='net duration sec = {0} ';
## ----------------------------------------------------------------##
$jet=$(getnow) ; 
$BEXT = "
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#   PROJ: $proj 
#   FSIM: $fsim  
#   LOG:  $SLOG
#   OPTS: $OPTS
#   TIME: $jet 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  	
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    starccm+ $OPTS $fsim | Tee-Object -Append -FilePath $SLOG 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
";
   $null >BEG ;
   " TIME: {0}" -f $(getnow) | Tee-Object -Append -FilePath $SLOG ;
   Write-Host                 $BEXT ;   sleep 2.0 ;
   Invoke-Expression -Command $BEXT ;

   $BEXT_DONE = "
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <  Done session  >
# Time : {0}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
   $null >END ;
   " TIME: {0}" -f $(getnow) | Tee-Object -Append -FilePath $SLOG ;
   "$BEXT_DONE" -f $(getnow) | Tee-Object -Append -FilePath $SLOG ;
   Invoke-Expression -Command (netdur) | Tee-Object -Append -FilePath $SLOG ;
   Start-Sleep -s 1 ;
   Write-Host  $BEXT_DONE ;
   #exit; 
} ##=================================================================##
 
##====================================================================##
Function ostar($mode, $NP, $copt, $java ){
  $pdir=$(pwd);
  $proj=$pdir ; 
  if ( $copt.length -lt 1 ) { $copt=0 ; } ;
  if ( $java.length -lt 1 ) { $java=$postjava ; } ;

  $BASEVALUES="==============================================
  BASEVALUES 
  mode:   $mode
  NP  :   $NP
  copt:   $copt
  java: `"$java`"
  ==============================================
  ";Write-Host $BASEVALUES;

## ---------------------------------------------------------------- }
 
  Switch( $mode ){   
    "br" { $bo=1;$EXT="run";  $OPTS=" -power -np $NP  -batch $EXT"  ;$bo=1};
    
    "bm" { $bo=1;$EXT="mesh";   
          $OPTS="                -batch mesh"   ; 
          if ($NP -gt 1 )
          {$OPTS=" -power -np $NP -batch $EXT"  } else
          {$OPTS="                -batch mesh"  }; 
        };
##  "ja" { $bo=1;$EXT="java"; $OPTS="-server -rgraphics mesa_swr -batch `"$java`"" ;};
    "ja" { $bo=1;$EXT="java"; $OPTS="-batch `"$java`"" ;};
    "gs" { $bo=1;$EXT="sess"; $OPTS="-server -rgraphics mesa_swr -collab" ;};
    "gm" { $bo=1;$EXT="sess"; $OPTS="-server -rgraphics mesa_swr -np $NP -collab -power" ;};
    "cl" {   $bo=0; 
              starclient; 
              #exit; 
        };
    "dr" {  $bo=0;$EXT="dmrun"; 
              stardm $copt $proj ;
        };
    "in" { $bo=1;$EXT="info"; $OPTS="-info " ;};
  }
	

## ---------------------------------------------------------------- }
<#
  Switch( $popt ) {
      "p" { $pdir=$(pwd) ; };
      "a" { $pdir=$(pwd) ; 
      ## $pdir=askpath( $pdir ) ;
      ## continue using newly chosen pdir      
      }; ## ask for the dir 
  } #>
## ----------------------------------------------------------------
   
  if( "$bo" -gt 0 )
  { 
         $lastsim=$( lastfext $proj ".sim" ) ;
        if ( $copt -gt 0   ) { 
        #if ( $copt -eq 'v' ) { 
         $lastsim=$( selectfile $proj ".sim" ) ;
        }   
    $casesim=$lastsim.Trim(".sim");
    echo " LASTSIM found = $lastsim ";
    echo " CASESIM found = $casesim ";
    gci  $lastsim ;
    $SLOG="$casesim" + "." + $EXT  + ".log" ;
    $fsim=$lastsim ;
    ## ---------------------------------------------------------------- 
    $WO_OPTIONS = "
 #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 # SELECTIONS :
 #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 #  mode       $mode
 #  NP         $NP
 #  bo         $bo
 #  copt       $copt 
 #  EXT        $EXT
 #  dir        $pdir
 #  lastsim    $lastsim
 #  casesim    $casesim
 #  logfile    $SLOG  
 #  OPTS       $OPTS 
 #  proj       $proj 
 #=================================================================
    "; 
    Write-Output $WO_OPTIONS ;  
    $PREVIEW="
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#   starccm+ $OPTS $fsim | Tee-Object -Append -FilePath $SLOG 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
";
      #Write-Output $PREVIEW  ;
    if ( $NP -gt 0 ) {
      "
      ........ INSIDE OSTAR ........
      {0} okay to run" -f "$NP" ;

    bextgo "$OPTS" "$proj" "$lastsim" "$SLOG" ;
    }
    else {
      "........ INSIDE OSTAR ........
      {0} SKIPPING " -f "$NP" ;
      Write-Output $PREVIEW  ;
    }
  }#EO# if( "$bo" -eq "1" ){ #Switch( $bo){
  #default { Write-Host "done " } ## Switch($bo)

  else  ## if NOT ($bo -gt 0 ) 
    { 
        Write-Host "OSTAR: skip" 
    };
  " bo = {0} "-f $bo  ;
  Start-Sleep -s 0.5 ;
  Write-Host "OSTAR: done" ; return 0;
  
# } ##Switch($bo)
  #### 2024-02-09-1928z ####
}##=================================================================##


##=================================================================##
Function mkdircases( $pdir, $fext ){
    $here=$( pwd );if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ;
    if ( $fext.length -lt 1 ) { $fext=".sim" } ;
    dir "$pdir/*.${fext}" | Sort-Object -Property LastWriteTime ;
    $list_files=(dir "$pdir/*$fext" | Sort-Object -Property LastWriteTime).Name;
    echo " list of files: $list_files ";
    $i=0; 
    Foreach ($thisone in $list_files ){
	    Write-Host "$i $thisone "; $i=$i+1;
        $case=$thisone.Trim(".$fext");
        $casedir="$pdir\$case" ;
        New-Item -Path "$pdir" -Name "$case" -Force -ItemType "directory" ;
        Move-Item -Path $thisone -Destination $casedir ;
    }##EO# Foreach..
  cd $here ;
  gci $here 

}

##===================================================================##
Function pystar( ) {
  python "$pystar" ;
}
##===================================================================##

Function namerunlog( $pdir  ) {
  ##$pdir=(where $pdir ) ; 
  if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ;
  New-Item -Path $pdir -ItemType "directory" -Force -Name "moni" ;
  $case=(lastcase $pdir ".sim" ) ;
  Move-Item "starccmp_output.txt" -Destination "moni\$case-hpccloud.run.log" ;
  ##2024-02-07-Z2240##
} ##=================================================================##

###############################################################################

Function makemoni ( $pdir  ) {
  ##$pdir=(where $pdir ) ; 
  if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ;
  New-Item -Path $pdir -ItemType "directory" -Force -Name "moni" ;
  $case=(lastcase $pdir ".sim" ) ;
  Copy-Item "$pdir\*output.txt" -Destination ".\moni\$case-hpccloud.run.log" ;
 ##< 2024-02-15-2200z >##

} ##=================================================================##


##==================================================================##
Function poststar($OPTRUN, $OPTLOG, $pdir, $case, $postjava){ 

#---------------------------------------------------------------- 
 ## define base and nulls
    $LIB=(getlib) ;
    $RUNLEN = $OPTRUN.length;
    " OPTRUN = {0}, and length of OPTRUN = {1} " -f "$OPTRUN", "$RUNLEN"
    if ( $OPTRUN.length -lt 1 ) { $OPTRUN="1" } ;
    if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ;$here=$( pwd );
    $down=(Split-Path $pdir -Leaf) ;
    if ( $case.length -lt 1 ) { 
       $case=(lastcase $pdir ".sim" ) ;
    #  $case=(Split-Path $pdir -Leaf) 
    };
    if ( $postjava.length -lt 1 ) { $postjava=$LIB['postjava']  } ;
    if ( $pystar.length -lt 1 ) { $pystar=$LIB['pystar'] } 
    " {0:s} = {1:s} " -f "pystar"   , $pystar  ;
    " {0:s} = {1:s} " -f "postjava" , $postjava  ;

#---------------------------------------------------------------- 
 ## create and move moni
    $PWDCASE=$pdir;
    $PYLOG="run.log"; ### default value for $PYLOG 
    $monidir="$PWDCASE\moni\";
    New-Item -Path $pdir -ItemType "directory" -Force -Name moni  ;

#---------------------------------------------------------------- 
 ## option for run.log and copy and run from monidir
  Switch( $OPTLOG ){   
    "hpc" {
       $PYLOG="run.log";
       if ( lastfext $pdir "output.txt" ) {
          makemoni $pdir ; 
       }
       else {
          Copy-Item $(lastfext $PWDCASE $PYLOG ) -Destination $monidir ;
       }
    }
    "dm" {
        $PYLOG=".log";
        Copy-Item $(lastfext $PWDCASE ".log" ) -Destination $monidir ;
     }
    "run" {
       $PYLOG="run.log";
       Copy-Item $(lastfext $PWDCASE $PYLOG ) -Destination $monidir ;
    }
    default
     {
       $PYLOG="run.log";
       if ( lastfext $pdir "output.txt" ) {
          makemoni $pdir ; 
       }
       else {
          Copy-Item $(lastfext $PWDCASE $PYLOG ) -Destination $monidir ;
       }
     }
  } ## Switch( $OPTLOG ) 
  cd $monidir ;
  gci -Path $monidir ;
  "`t BEG: ...`t {1:s} [{0:s}] in directory {2:s}" -f "pystar", $pystar, $monidir ;
  $simcase=(lastcase $pdir ".sim" )
  $pform="running postcase for CASE {0:s} DIR {1:s}"; ###Foreach ($thiscase in $LISTCASES ){
  #$thiscase=$simcase;
  #$casedir="$pdir\$thiscase" ;
  #$pform -f "$thiscase" ,"$casedir" 
  $pform -f "$simcase"   ,"$pdir"  
  "monidir = {0:s}" -f "$monidir" ;
  #<#
## -----------------------------------------------------------     
 ## execute for PYTHON PYSTAR
    $PREVIEW="
    pwd
    gci .
    python `"$pystar`" -log $PYLOG -nsa 30 -nsp 10 -sum -ppt -sim $simcase 
    ";
    if ( $OPTRUN -eq 1 -or $OPTRUN -eq 3 ) { "{0} okay to run" -f "$OPTRUN" ;
        " RUNNING PYSTAR....................";
        Write-Host                 $PREVIEW ;   sleep 2.0 ;
        Invoke-Expression -Command $PREVIEW ;
        gci *log *txt ;
        "`t  :END ...`t {1:s} [{0:s}] in directory {2:s}" -f "pystar", $pystar, $monidir ;
    }
    else {            "{0} SKIPPING PYSTAR " -f "$OPTRUN" ;
     #  Write-Host                 $PREVIEW ;   sleep 2.0 ;
    }   
    echobr 60 ;
## -----------------------------------------------------------        
 ## execute for star POSTJAVA
    cd $pdir ; 
    cd $PWDCASE ;
    "`t  BEG: ...`t {1:s} [{0:s}] in directory {2:s}" -f "postjava", $postjava, $pdir ;
    gci *sim ;
    
    #$PREVIEW="ostar ja $OPTRUN 0 $postjava " ;
    
    if ( $OPTRUN  -eq 2 -or $OPTRUN -eq 3 ) { 
        $PREVIEW="  ostar ja 1 0 `"$postjava`" " ;
        " RUNNING POSTJAVA ....................";
        "     {0} okay to run" -f "$OPTRUN" ;
        Write-Host                 $PREVIEW ;   sleep 2.0 ;
        Invoke-Expression -Command $PREVIEW ;
      ## also execute PYTHON PYSTAR -ppc which is for postcase 
      #<#
        " RUNNING PYSTAR POSTCASE ..............";
        python $pystar -ppc -sim "${case}_postmac" ;
      #>
    }
    else {            "{0} SKIPPING " -f "$OPTRUN" ;
        $PREVIEW=" ostar ja 0 0 `"$postjava`" " ;
        Write-Host                 $PREVIEW ;   sleep 2.0 ;
        Invoke-Expression -Command $PREVIEW ;
    }   
    "`t :END ...`t {1:s} [{0:s}] in directory {2:s}" -f "postjava", $postjava, $pdir ;
    echobr 60 ;

## -----------------------------------------------------------    
  ## wrap-up    
    $thislog = " END OF POSTSTAR "
    cd $PWDCASE ; 
    echo $PWDCASE ;
    gci  $PWDCASE ;
    gci  $monidir ;
    <#   #>
    cd $pdir ;
    cd $here ;

    return $thislog ;
    #}##< 2024-03-23-1723z >##

    ##< 2024-02-16-0124z >##
} ##=================================================================##

Function postcases(  $OPTRUN, $OPTLOG, $LISTCASES, $pdir){
    #$fext="_002559.sim" ;
    if ( $OPTRUN.length -lt 1 ) { $OPTRUN="1" } ;
    $here=$( pwd );
    if ( $pdir.length -lt 1 )   { $pdir=$(pwd) } ;
    if ( $fext.length -lt 1 )   { $fext=".sim" } ;
    if ( $OPTLOG.length -lt 1 ) { $OPTLOG="dm" } ;
    echo "fext = $fext " ; 
    if ( $LISTCASES.length -lt 1 ) { $LISTCASES=(lastcase $pdir "sim" ) } ;
    $PWDPROJ=$pdir; 
    echo " list of cases: $LISTCASES ";
    echobr 60 ;
    $i=0; 

    $pform="running postcase for CASE {0:s} DIR {1:s}"; 
    Foreach ($thiscase in $LISTCASES ){
     $casedir="$PWDPROJ\$thiscase" ;
     $pform -f  "$thiscase" ,"$casedir"  ;
     cd $casedir; gci *.*  

  ## poststar($OPTRUN, $OPTLOG, $pdir, $case, $postjava){ 
     poststar $OPTDEB $OPTLOG $casedir $thiscase ;     

     cd $casedir; gci *.*  
     cd $PWDPROJ
    }##EO# Foreach..
  cd $here ;
 # gci $here 
##< 2024-02-16-0106z >##

#
}##=================================================================##

##===================================================================##
Function starclient( $p) {
    $p=$(pwd) ;
    $KW="Server::start -host";
    #$lastlog=(gci ( ( gc *.log | Select-String $KW | select -last 1 )  ).Name ;
    $sess=( ( gc *.log | Select-String $KW | select -last 1 ) -Split "$KW ",-1  );
    $EXT="cles";  $OPTS="-graphics mesa_swr -host $sess"  ;
    echo $OPTS;
    $lastsim="";
    $NOW=(Get-Date -Format "yyyy-MM-dd-HH-mm");
    $SLOG=$NOW + ".cles.log" ;
    $fsim='';
## ----------------------------------------------------------------
    ( bextgo $OPTS $p ' ' $SLOG );
	#Invoke-Expression -Command $BEXT ;

} ##=================================================================##


###############################################################################