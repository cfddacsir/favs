###############################################################################
# Codefile: profile.ps1
$pwsh_profile='~/.config/powershell/Microsoft.PowerShell_profile.ps1'
###############################################################################
#  $eon=1;
$_Usage=" 

# ========================================================================== #
# File:  profile.ps1
# dir:   ~/.config/powershell/
# Type:  PowerShell.exe
# Auth:  DANIEL.COLLINS@
# Vers:  2025-03-19-T1510 
# ========================================================================== #
# ========================================================================== #
";
 $WINDOWS_POWERSHELL_CONF="C:\Users\daniel.collins\Documents\WindowsPowerShell\"
 $POWERSHELL_CONF_MAC="$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1"

 if ($eon -eq 1 ){ Write-Output $_Usage;}
 Function _use() {a
    Write-Output $_Usage 
 }
 Function getnow() {
    $NOW=(Get-Date -Format "yyyy-MM-dd-HH-mm");
    return $NOW;
 }
 $NOW=(Get-Date -Format "yyyy-MM-dd-HH-mm");

 Function profup(){
  #Copy-Item -Path $HOME/sh/PS_PROFILE.ps1 ~/.config/powershell/profile.ps1 -Force
  Copy-Item -Path $HOME/sh/PS_PROFILE.ps1 -Destination $pwsh_profile -Force
 }


###############################################################################

#==============================================================================
 # LIBPATH
  #============================================================================
  $LIBPATH=(
  '/Users/dac/qlab/', #
  '/Users/dac/qlab/metash/' #.
  # '/Users/dac/qlab/lib/', 
  );
# $env:PYTHONPATH=$LIBPATH[0]:$LIBPATH[1]:$LIBPATH[2]
  $qlab=$LIBPATH[0] ;
  $meta=$LIBPATH[1] ;
  $meta_testing=$LIBPATH[0] + "testing" ;
#-----------------------------------------------------------------------------#

###############################################################################
 Function getlib( ) {
  $LIB = @{} ;
  $pystar=$LIBPATH[2]   + "pystar.py"
  $postjava=$LIBPATH[2] + "post_batch.java" ;
  $LIB = @{};
  $LIB.add( 'lab',      $LIBPATH[0]    );
  $LIB.add( 'lib',      $LIBPATH[1]    );
  $LIB.add( 'star',     $LIBPATH[2]    );
  $LIB.add( 'pystar',   $LIBPATH[2]+ "pystar.py");
  # $LIB.add( 'postjava', $postjava      );
  $LIB.add( 'postjava', $LIBPATH[2]+ "post_batch.java");
  return $LIB ;
  ##< 2024-02-16-0106z >##

 }
#-----------------------------------------------------------------------------#

###############################################################################
##<<   PATHS  >>
#-----------------------------------------------------------------------------#
  
  $MYPATHS="$HOME/paths.rcps"; ## Env Variable for Mypaths 

  Function fnow( ){
  # $tage=(Get-Date -Format "yyyy-MM-dd-HH-mm" $f );
  # return $tage;
    $NOW=(Get-Date -Format "yyyy-MM-dd-HH-mm");
    return $NOW
  }
#-----------------------------------------------------------------------------#
 Function npp( ) {
   notepad++.exe  ;
 }
 Function nppnew($d) {
   $twd=$(pwd);
   if( $d.Length -eq 0 ){$d=$twd};
   $f="$d\new.txt";
   notepad++.exe $f ;
 }
##===========================================================================##
 Function lstr($d){ 
   gci $d `
   | Sort-Object -property LastWriteTime # -Descending   
      #return $lastfile 
 }
##===========================================================================##
 Function sci ( $s ) {
   Get-Command -ShowCommandInfo -All -Name $s
 }
##===========================================================================##
#-----------------------------------------------------------------------------#
 Function addpath($d){ 
    $p=($(pwd).Path)
      # echo "`'$p;`'" | Tee-Object -Append -FilePath  $HOME\paths ;
    # "`n{0};`n" -f "$p"  | Tee-Object -Append -FilePath  $HOME\paths ;
    "`n{0};" -f "$p"  | Tee-Object -Append -FilePath $MYPATHS ;
 }
#-----------------------------------------------------------------------------#
 Function askpath( $pdir ){ 
    $here=$( pwd );  if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ;
    Write-Output "
    current directory is ... $pdir ";

    $loadpaths = ( ( (cat $MYPATHS) -Split "`n", 1) -Split ";",1 ).Trim(";");
    #$loadpaths =(( cat $HOME\paths) -Split ";", 1);
     $i=0; Foreach ($d in $loadpaths ){
     Write-Output "$i $d "; $i=$i+1;
    }
    $sel = (Read-Host "enter integer for corresponding sim file to load.") ;    
    
    $pickdir=((  $loadpaths[$sel] ).Trim(";") ) ; 
    $pickdir=($pickdir -replace "'" , '');
    
    Write-Output ('you chose "{0}"' -f "$pickdir" ) ;
    Set-Location -Path ( '{0}' -f "$pickdir" ) ;
    return $pickdir ;
 }
 Function echobr($n, $p) {
   $pad = $p*'`n';
   $_= "~"*$n ; '{1}{0:s}{1}' -f $_, $pad;
   ##< 2025-03-19-1635 >##
 }
#-----------------------------------------------------------------------------#
 Function swd {
    addpath;
 }
 Function awd {
    askpath;
 }
  Function vwd {
    cat $MYPATHS;
 }
  Function ewd {
    notepad++.exe $MYPATHS;
 }
#-----------------------------------------------------------------------------#
Function dirt($d) {
  (gci $d).LastWriteTime | Get-Date -Format "yyyy-MM-dd-HH-mm-ss" ;
  #(gci *) | Sort -Property LastWriteTime  
}
##===========================================================================##
 Function lastfile($kw){ 
   $lastfile=(gci *$kw `
   | Sort-Object -property LastWriteTime -Descending `
   | select -first 1 ).Name ;
   return $lastfile 
 };
#-----------------------------------------------------------------------------#
  Function watchlog{
    Get-Content $(lastfile log) -Wait -Tail 30 ;
 } 
#-----------------------------------------------------------------------------#
 Function lastlog(){
   $lastlog=(gci *log `
   | Sort-Object -property LastWriteTime -Descending | select -first 1 ).Name;
   return $lastlog;
}
#-----------------------------------------------------------------------------#
Function lastsim(){
   $lastsim=(gci *sim `
   | Sort-Object -property LastWriteTime -Descending | select -first 1 ).Name;
    return $lastsim ;
}
###############################################################################

###############################################################################
Function init_lib(){ 
  $LIB=(getlib) ;
  $postjava=$LIB['postjava']
  $pystar=$LIB['pystar']
  " {0:s} = {1:s} " -f "pystar"   , $pystar  ;
  " {0:s} = {1:s} " -f "postjava" , $postjava  ;
  ##< 2024-02-16-0106z >##
}
#-----------------------------------------------------------------------------#
###############################################################################

###############################################################################
#=============================================================================#
$IP_GCS=10.200.3.199
$MACHFAV=@{};
$MACHFAV.add( 'mylap' ,     'PC2BDQQJ' );
#$MACHFAV.add( 'gcsccm',     'GCS-CCM-WCT01'  );
#$MACHFAV.add( 'gcsccmip',   '10.200.3.199'   );
#$MACHFAV.add( 'vpn' ,       'vpn.wisk.aero'  );
$MACHFAV.add( 'thismach' ,  '$env:COMPUTERNAME');

#-----------------------------------------------------------------------------#
Function pingser( ) {
ping -n 3 -l 32 -w 30 -4 10.200.2.222
ping -n 2 -l 32 -w 30 -4 $env:COMPUTERNAME 
}
#-----------------------------------------------------------------------------#
Function pingthis( $mach ) {
" » » ping this-machine " -f "$env:COMPUTERNAME";
ping -n 2 -l 32 -w 30 -4 $env:COMPUTERNAME ;
" » » ping argu-machine " -f "$mach" ;
ping -n 3 -l 32 -w 30 -4 $mach ;
}
###############################################################################


###############################################################################


###############################################################################
## Calculating netduration BEG - END
#-----------------------------------------------------------------------------#

Function netdur( $eon ) {
  #---------------------------------------------------------------------------
 $B=(((gci BEG).LastWriteTime | Get-Date -Format "yyyy-MM-dd-HH-mm-ss") -Split,'-',0);
 $E=(((gci END).LastWriteTime | Get-Date -Format "yyyy-MM-dd-HH-mm-ss") -Split,'-',0);
 $netSec = (
   (( $E[5] - $B[5] ) * (1   )) + 
   (( $E[4] - $B[4] ) * (60  )) +
   (( $E[3] - $B[3] ) * (60*60  )) +
   (( $E[2] - $B[2] ) * (60*60*24  )) + 0
 );
 $netMin= $netSec /60 ;
 $pform="net duration ({0:3s}) = {1:f3}"; 
 $pform2="net duration: {0}h {1}m {2}s"; 
 if($eon -gt 0 ){ 
      $pform -f "sec", "$netSec"    ; 
      $pform -f "min", ($netSec/60) ; 
      $pform -f "hr ", ($netSec/3600) ; 
      $pform2 -f `
        ([int][Math]::Floor(   $netSec/3600)/1 ),`
        ([int][Math]::Floor(  ($netSec%3600)/60) ),`
        ([int][Math]::Floor(( ($netSec%3600)%60)%60) ) ; 
 }
 return $netSec ;
}

###############################################################################


Function where( $pdir ) {
    $here=$( pwd );if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ;
    return $pdir ;
} ##=================================================================##

##===========================================================================## 
Function pickfile ($pdir, $fext ){
    $here=$( pwd );  if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ;
#   Write-Host "fext: $fext, path: $pdir " ;
#   cd $pdir ;
    dir "$pdir/*.${fext}" | Sort-Object -Property LastWriteTime ;
    $list_files=(dir "$pdir/*$fext" | Sort-Object -Property LastWriteTime).Name;
    echo " list of files: $list_files ";
    $i=0; Foreach ($thisone in $list_files ){
	    Write-Host "$i $thisone "; $i=$i+1;
    }
  $sel = (Read-Host "Select File.  Enter integer for corresponding file to load.");
  $pickfile = $list_files[$sel]; 
  # Write-Host "you chose $pickfile" ;		
  #	$selectfile = $pickfile.Trim(".fext");
	$selectfile = $pickfile ; # .Trim(".fext");
  cd $here ;
  return $pickfile ;
}
##===========================================================================## 
Function selected( $pickfile ){
  $selectedfile=($picksim -Split,' ',0 | select -last 1) ;
  return $selectedfile;
}
##===========================================================================##
Function selectfile($pdir, $fext ){
    $here=$( pwd );  if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ;
    $pickfile =$(pickfile $pdir $fext ) ;
    $selectfile=($pickfile -Split,' ',0 | select -last 1) ;
    return $selectfile;
}
##===========================================================================##

Function sce2png( $fs, $THIS_SCENE, $FOUT ){
  # Starview Examples:
    # Scan and list available scenes in scene file & exunt afterwards by default...
    #    starview.exe -scan
    # starview.exe my_scene.sce -hardcopy My\ Scene\ 0 640 480 1 true false s0.png
  $BEXT="
   starview.exe $is.sce -hardcopy $THIS_SCENE 0 960 720 1 true false $FOUT.png
    "; 
  Write-Output $BEXT ; sleep 0.5 ;
  Invoke-Expression -Command $BEXT 
  
} ##=================================================================##

##===========================================================================##
Function getcase($file, $fext){
  $case=$file.Trim(".$fext");
  return $case ;

} ##=================================================================##

Function lastfext1($pdir,$fext ){
  $here=$( pwd );  if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ; 
  if ( $fext.length -lt 1 ) { $fext=".sim" } ; 
  $lastfile =(gci "${pdir}/*${fext}" |Sort-Object -property LastWriteTime -Descending | select -first 1 ).Name;
  return $lastfile ;

} ##=================================================================##
Function lastfext( $pdir, $fext) {
     $here=$( pwd );  if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ; 
     if ( $fext.length -lt 1 ) { $fext=".sim" } ; 
     $lastfext=(gci -Path $pdir "*$fext" |`
     Sort-Object -property LastWriteTime -Descending | select -first 1 ).Name;
  return $lastfext ; ##2024-02-09-18z48##
}
##===========================================================================##
Function lastfull($pdir , $fext ){ 
    $lastcase="";
    $here=$( pwd );if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ;
    if ( $fext.length -lt 1 ) { $fext=".sim" } ; 
    $lastfext=(gci -Path $pdir "*$fext" -Recurse `
     |Sort-Object -property LastWriteTime -Descending | select -first 1 ).Fullname;
    if ($lastfext) {
    $lastcase=$lastfext.Trim( $fext );}
    else { 
    $lastcase="" ;}
  return $lastfext ; ##2024-02-09-18z48##
}
##===========================================================================##
Function lastcase($pdir , $fext ){ 
    $lastcase="";
    $here=$( pwd );if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ;
    if ( $fext.length -lt 1 ) { $fext=".sim" } ; # $fext=".sim" ;
    $lastfext=(gci -Path $pdir "*$fext" |Sort-Object -property LastWriteTime -Descending | select -first 1 ).Name;
    if ($lastfext) {
    $lastcase=$lastfext.Trim( $fext );}
    else { 
    $lastcase="" ;}
  return $lastcase ; 
  ##2024-02-09-18z48##
}
##===========================================================================##
Function laststar($pdir ){ 
    $here=$( pwd );  if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ; 
  $lastsim=(lastfext "$pdir" ".sim");
  $casesim=$lastsim.Trim(".sim");
  return $lastsim ;
  ##2024-02-09-18z48##
} ##=================================================================##
Function laststarfull($pdir ){ 
    $here=$( pwd );  if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ; 
  $lastsim=(lastfext "$pdir" ".sim");
  $casesim=$lastsim.Trim(".sim");
  return $lastsim ;
  ##2024-02-09-18z48##
} ##=================================================================##
Function laststarcase($pdir , $fext ){ 
    $casesim="";
    $lastsim="";
    $here=$( pwd );if ( $pdir.length -lt 1 ) { $pdir=$(pwd) } ;
    if ( $fext.length -lt 1 ) { $fext=".sim" } ; # $fext=".sim" ;
    $lastsim=(lastfext "$pdir" ".sim" ) ;
    if ($lastsim) {
    $casesim=$lastsim.Trim(".sim");
    }
  return $casesim ; 
  ##2024-02-09-18z48##
} ##=================================================================##

Function caselog($case ){ 
	$thislog="$case" + ".log";
  return $thislog ;

} ##=================================================================##

Function starlog($thisstar ){ 
  $thislog=$thisstar.Trim(".sim") + ".log";
  $thislog=$thisstar.Trim(".sim") + "_sim" + ".log";
  return $thislog ;

} ##=================================================================##

#######################################################################

#---------------------------------------------------------------------#
Function netdur( $eon ) {
 
 $B=(((gci BEG).LastWriteTime | Get-Date -Format "yyyy-MM-dd-HH-mm-ss") -Split,'-',0);
 $E=(((gci END).LastWriteTime | Get-Date -Format "yyyy-MM-dd-HH-mm-ss") -Split,'-',0);
 $netSec = (
   (( $E[5] - $B[5] ) * (1   )) + 
   (( $E[4] - $B[4] ) * (60  )) +
   (( $E[3] - $B[3] ) * (60*60  )) +
   (( $E[2] - $B[2] ) * (60*60*24  )) + 0
 );
 $netMin= $netSec /60 ;
 $pform="net duration ({0:3s}) = {1:f3}"; 
 $pform2="net duration: {0}h {1}m {2}s"; 
 if($eon -gt 0 ){ 
      $pform -f "sec", "$netSec"    ; 
      $pform -f "min", ($netSec/60) ; 
      $pform -f "hr ", ($netSec/3600) ; 
      $pform2 -f `
        ([int][Math]::Floor(   $netSec/3600)/1 ),`
        ([int][Math]::Floor(  ($netSec%3600)/60) ),`
        ([int][Math]::Floor(( ($netSec%3600)%60)%60) ) ; 
 }
 return $netSec ;
}
##===================================================================##

#######################################################################



###############################################################################
### EPROFILE
###############################################################################

Function eprofile(  ){
  $get_profile="C:\Users\daniel.collins\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1";
  notepad++ $get_profile ;
}
Function xprofile(  ){
    $prof="profile.ps1";
    $pwsh_profile='~/.config/powershell/profile.ps1'
    $pwsh_profile='~/.config/powershell/Microsoft.PowerShell_profile.ps1'
    $safedir="$HOME/sh"
    #$gpro="G:\My Drive\mylab\PS_Profile.ps1";
    $gpro="$safedir/$prof"
    $apro=$gpro ; # 
    $WINDOWS_POWERSHELL_CONF="C:\Users\daniel.collins\Documents\WindowsPowerShell\"
    $WINDOWS_POWERSHELL_CONF="$HOME/.config/powershell"
    #$psix="${WINDOWS_POWERSHELL_CONF}Microsoft.PowerShellISE_profile.ps1";
    $psex=$PROFILE
     #"${WINDOWS_POWERSHELL_CONF}Microsoft.PowerShell_profile.ps1";
    ## $psib="${WINDOWS_POWERSHELL_CONF}Microsoft.PowerShellISE_profile.ps1.bak";
    $pseb="${PROFILE}.bak" 
    ## "${WINDOWS_POWERSHELL_CONF}Microsoft.PowerShell_profile.ps1.bak";
    Copy-Item -Path "$psex" -Destination $pseb -Force ; 
    Copy-Item -Path "$apro" -Destination $psex -Force ;
    #Copy-Item -Path "$psix" -Destination $psib -Force ; 
    #Copy-Item -Path "$apro" -Destination $psix -Force ;
    Copy-Item -Path "$apro" -Destination $gpro -Force ;
    Get-Date ;
#   gc $psi  | Select-String "#Vers" ;
#   gc $psx  | Select-String "#Vers" ;
    gci $apro ;
    # gci $psix ;
    gci $psex ;
}
Function xpro() { 
    xprofile;
}

###############################################################################

# Notes ====================================================================
##   powershell: %windir%\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe
##   !/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -File
##   !C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File
##   powershell: %windir%\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe
### $profile= (User)
### C:\Users\daniel.collins\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1

###############################################################################
<#
$help="
#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~

PowerShell Profile = 
`How to Create a PowerShell Profile - Step-by-Step — LazyAdmin.html`
[ https://lazyadmin.nl/powershell/powershell-profile/ ]

1. open powershell
2. $profile
Current user – Current host
  : $Home\[My ]Documents\PowerShell\Microsoft.PowerShell_profile.ps1	
  : $profile

3. test-path $profile
4. New-Item -Path $profile -Type File -Force

5. Set-ExecutionPolicy RemoteSigned
6. configure your profile -- styling

# Style default PowerShell Console
$shell = $Host.UI.RawUI
$shell.WindowTitle= "PS"
$shell.BackgroundColor = "Black"
$shell.ForegroundColor = "White"

# Load custom theme for Windows Terminal
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme LazyAdmin

7. relocate to "home"
# Set Default location
Set-Location D:\SysAdmin\scripts

8. # Load scripts from the following locations
$env:Path += ";D:\SysAdmin\scripts\PowerShellBasics"
$env:Path += ";D:\SysAdmin\scripts\Connectors"
$env:Path += ";D:\SysAdmin\scripts\Office365"


#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~#~~~~~
Start-Sleep
     [-Seconds] <Double>
     [<CommonParameters>]
Start-Sleep -Seconds 5

10.200.3.199



#>
###############################################################################
#=============================================================================#
#-----------------------------------------------------------------------------#
###############################################################################
<#
$here = $PROJECTROOT ; 
echo $PROJECTROOT    ;
gci $PROJECTROOT     ;
postcases $PROJECTROOT $FEXT_CASES_COBALT $LIST_CASES_COBALT ;
#>
##===========================================================================## 
<#
    dir "$pdir/*.${fext}" | Sort-Object -Property LastWriteTime 
    $list_files=(dir "$pdir/*$fext" | Sort-Object -Property LastWriteTime).Name;   
    $list_files=(gci -Path $here -Filter *2559.sim -Recurse -Depth 2).fullname
#>
##===========================================================================##

$__Versioning__="
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
# Vers:  2025-03-19-T1531-0700 : FRESH!
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
"
