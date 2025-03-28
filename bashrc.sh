#!/bin/bash
################################################################################
_info="
#===============================================================================
 FILENAME: bashrc.sh
 AUTHOR:   Daniel Alan Collins (DAC) <Daniel.Collins@enervenue.com>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
_svn=( $(printf "%s" "${_info}")
 2022-0815-1150t 2022-1004-0920t 2022-1012-0816t 2022-1013-1123t 2022-1025-0855t
 2022-1103-0802t 2022-1104-1356t 2022-1115-1400u '</ENDOF2022/>' '<\BEGOF2023\>'
 2023-0106-1215u 2023-0106-1355u 2023-0113-0843u 2023-0126-0918u 2023-0201-1636u
 2023-0202-1115u
); _rev=$(printf ${_svn[$((${#_svn[*]}-1))]} ) ;
################################################################################
#==========================================================
	ME=${USER} ;
  MEH=${HOME};
  DEN="${HOME}/sh";
	HUB=$DEN; # '/home/common/sh' ;
  CLIB=$HUB/
  # '/home/common/clib' ;
  # CLIB=${CLIB}:/home/common/lib ;
	DASH=${HUB} ;
  
        bashrx="${HUB}/bashrx.sh" ;
           bax="${HUB}/bashrx.sh" ;
  alias bashrx="    . $bashrx" ;
  alias bax="       . $bax " ;
  alias baxge=" gedit $bax & ";

  bashit(){
    . ~/sh/bashrc.sh;
    cp -pvf ${HOME}/sh/bashrc.sh ${HOME}/.bashrc 
  }
###========================================================
# set paths
#	PATH=$(cat /home/common/pathset/pathset.rc) ;
	# export PATH=${PATH}:${HUB}:${CLIB}:/home/common/lic:/home/common/lib ;

##---------------------------------------------------------

  export BANK="${HOME}/BANK" ;
  mkdir -p $BANK ;
  alias atm=" mv -vi *__????????-???? $BANK " ;
  alias atm=" mv -v  *sv????????-???? $BANK " ;

##=========================================================


###########################################################

###	BLOCK_A
##---------------------------------------------------------
#    alias echo='echo -e ';
#    alias echoe='echo -e ';
#    alias eche='echo -e ';
	alias ta1='tail -n1';
		    ta1='tail -n1';
	alias he1='head -n1';
		    he1='head -n1';
	alias wee='whoami; hostname; pwd; date;ls -tr1Ah $PWD|tail -n10;df -ah .';

  alias age=' alias | grep '
	alias mv='mv -v';
	alias up="cd ..";
	alias vab='vi /home/$(whoami)/.bashrc';
	alias svf=" .	${HUB}/svf.sh" ;
	alias gator='  alias | grep ' ;
	alias alamo='  alias | more ';
  alias setag='  set   | grep ';
  alias gnot=" grep -i -e -v " ;
	alias seek='find $PWD | grep -i -e      ';
	alias le='less ';
	alias ge='gedit  ';
	alias mo='more  ';
	alias pg='ps -Af | grep ';
	alias taff='tail -n 1000  -F -f  '
	alias tagg="tail -n 10000 -F -f \$(ls -tr *.log ) "
	alias cpz=' cp -vu  --no-preserve=timestamps '
	alias cpt=' cp -vf     --preserve=timestamps '
	alias cpr=' cp -vfpr   --preserve=timestamps '
	alias openmod=' chmod -Rv 777 ';
	alias mkdiropen=' mkdir -p -v -m=777 $1 ';
	alias mkdirdef='  mkdir -p -z        $1 ';

	alias his='  history ';
	alias hissg='  history 10000 | grep ';
	alias hisse="mkdir -p -m=755 $USER/hist && history 400 > $USER/hist";

	#------#  SIZING ##------
	alias dfa='df -ah 	';
  alias dfas='df -ah . ' ;
	alias duc='du -ch 	';
	alias duc1='du -ch -d 1 ';
	alias gross='   du -ch      ';
	alias grosse1=' du -ch -d 1 ';
  alias dspace='df -ah . ; duc ./* ; duc -d 1 ../* ';

	#------#  FILE SEARCHING ##-----
	alias lt='   ls -1lh   ';
	alias lh="   ls -lA1trh ";
	alias lt='   ls -lAt   ';
	alias lr="   ls -lAtr  ";   ##  $ztsm           "
	alias la="   ls -lAtrh ";   ##  $ztsm | awk $PQ "
	alias lk='   ls -lASh  ';
	alias lg='   ls -laR | grep             ';
	alias lsg='  ls -latR . | grep          ';
  alias ll='ls -l --color=auto' ; ## default
  alias lj='  ls -lA1 -tr -h  --time-style=long-iso ';
  alias law=' ls -lA1     -h  --time-style=long-iso ';
  alias lamm=' ls -lA1     -h  --time-style=long-iso $PWD | more ';
  # alias lw=' ls -lA1 -tr -h  --time-style=long-iso $(find $PWD | grep sim) ';
  alias ldd=' ls -lA1 -d  -h  --time-style=long-iso ./* '  ;
	alias luch=" ls -latR  $ztsm . | grep   ";
	alias recent=' ls -trlA1th $( find $PWD | grep -i -e $1 ) ';
  latest(){
    latest=$(ls -tr $(find . | grep -i -e $1 ) | tail -n1 );
    printf "${latest}" ;
  }
  lathe(){
    ls -latrh --time-style=long-iso ${1} |\
     awk '{print "\t" $5"\t"$6"-"$7" \t "$8}' ; }
	### -- setting & retrieving favorites to/from ~/.pathrc
	alias savepwd='echo "saving $PWD as favorite in ~/.pathrc";pwd >>~/.pathrc;' ;
	alias swd='    echo "saving $PWD as favorite in ~/.pathrc";pwd >>~/.pathrc;tail -n1 ~/.pathrc;';
	alias askpath=" . ${HUB}/askpath.sh";
	alias asw=" 	 echo \" askpath \"; .  ${HUB}/askpath.sh";
	alias ask=' askpath ';
	alias asw=' askpath ';
	alias cwd='		 cat -n  ~/.pathrc | more';
	function fav(){
		FAVDIR=(`cat ~/.pathrc `) ;
		export $FAVDIR ;
		. /home/common/sh/setfav.sh ;
	}
	alias getfav='~/sh/setfav.sh' ;

	#------# FILE UTILITIES  ##----------------------------------------------------
	#alias pack='	 gzip -Nqv6 -S .gz ';
	#alias packmax='      gzip -Nqv9 -S .gz ';
  function pack() {
    ls -latr  $1;
    ls -latrh $1;
    gzip -Nqv6 -S .gz $1;
    ls -latr  $1.gz;
    ls -latrh $1.gz;
  }
  function packm() {
    # 1 = file
    # 2 = packing level 1-9
    ls -latr  $1;
    ls -latrh $1;
    printf "packing file ${1} with level ${2} ...." ;
    gzip -Nqv${2} -S .gz $1;
    ls -latr  $1.gz;
    ls -latrh $1.gz;
  };
	alias ark='		 echo \" archivng file $1 \" ; tar -cvf $1; gzip -Nqv9 -S .gz $1.tar';
	alias unpack=' 	 echo \"unpacking gzip file $1 \"; gzip -dv $1 ';
	alias untar='	 echo \"extracting tar file $1 \"; tar -xvf ';
	alias mach="cat ${HUB}/machines.sh ; . ${HUB}/machines.sh ";
	alias xkk=" .   ${HUB}/xkill.sh ";

	svf="$HUB/svf.sh"
	alias svf=". $HUB/svf.sh"

	#------# APP ADMIN      ##----------------------------------------------------
	alias yums='yum search $1 | more ';
	alias yuma='yum list ';
	alias yumi='yum info ';
	alias yumy='sudo yum install -y  ';

	#------# COMPUTER LOADS #------#
	alias rtop='.  ${MYSH}rtop.sh';
	alias pg='		 ps -Af | grep ';
	alias awat='   w -u -o -i  ';
	alias fret='	 free -h -w -l -t 					';
	alias atop=' 	 top -b -d 1 -i -n 10 -o %CPU | head -n 30 ';
	alias wtop='   w -u -o -i  	 && top -b -d 1 -i -n 10 -o %CPU | head -n 30 ';
	alias ftop='   free -h -w -l -t  && top -b -d 1 -i -n 5  -o %MEM | head -n 12 ';

  alias pgstar=' ps -Af | grep starccm+ '
  alias xkkstar=" . ${HUB}/xkill.sh starccm+ "
	###
  ##---------------------------------------------------------
###########################################################


#==========================================================
## functions
###========================================================

##---------------------------------------------------------
## special print args and print breaks
  function pfs() {  OUT=$(printf "%${2}s"|sed "s/ /${1}/g"); printf '%s' $OUT ; } ;
  function pp()  {  OUT=$(printf "%${2}s"|sed "s/ /${1}/g"); printf '%s' $OUT ; } ;
  function psq() {  printf "$1%.s"  $(seq  1 $2 ) ; } ;
  function pss() {  printf '# %s\n' $(pfs $1 $2 ) ; } ;
  function hdiv() {
			dx=${1}; dy=$(fdiv \# 2 $dx 60); printf '%s\n' "$dy" ;
  };
	function pbr() {
		printf '# %s \n ' $(pfs '=' 57) ;
	};
  function bb() {
		printf '# %s\n ' $(pfs '=' 57 ) >> $(ls -tr *log*|ta1);
		tail -n 3 $(ls -tr *log*|ta1);
	};
  PRBR=$(pp '=' 57 );

##---------------------------------------------------------
  DIVI=(
		$(pfs '##' 40)
		$(pfs '==' 40)
		$(pfs '..' 40)
		$(pfs '__' 40)
		$(pfs '~~' 40)
#		$(pp  '//' 40)
  );

##---------------------------------------------------------

  function baba(){
    printf '# %s\n' $(pfs \# 77 ) | tee -a ${1}
  }
  function daba(){
    printf '# %s\n' $(pfs \= 77 ) | tee -a ${1}
  }
  function tada(){
    printf '# %s\n' $(pfs \~ 77 ) | tee -a ${1}
  }


##---------------------------------------------------------
# logging
  function loo() {
     loo=$(ls -tr *.log*|ta1);
	   printf $loo;
	};
  function lalo() {
     lalo=$(ls -tr *.log*|ta1); printf $lalo;
	};
  function gg(){
    tail -n 1000 -F -f $(ls -tr *.log | tail -n 1)
  }
  function tt(){
    tail -n 100  $(ls -tr $1 | tail -n 1)
  }
  function trat(){
    tail -n 1000 -F -f $(ls -tr $1 	 | tail -n 1)
  }

###########################################################
##---------------------------------------------------------
##	TIMESTAMPING
##---------------------------------------------------------
  NOW=$(date +%Y%m%d%-H%M%S);
  TICK=$(date +%Y%m%d-%H:%M:%S); TIC=$(date +%s );
  function tic() { TIC=$(date +%s ); printf "%s" "${TIC}" ; }
  function heute() {
		JE=(
			$(date +%Y)
			$(date +%m) $(date +%b)
			$(date +%d)
			$(date +%j)
			$(date +%W)
			$(date +%u) $(date +%a)
			$(date +%H) $(date +%M) $(date +%S)
			$(date +%z) $(date +%Z)
			$(date -u +%T) ) ;
	  JELOC=`date --rfc-3339=seconds` ;
	  JEUTC=`date --rfc-3339=seconds -u ` ;
	  JESEC=`date +%s ` ;
    JESUC=`date +%s -u` ;
		printf "
		Today is
			Year:    %s
			Month:   %s %s
			dayMon:  %s
			dayYear: %s
			Week#:   %s
			dayWeek: %s  %s
		Locale Time:
			Hour:    %s
			Minute:  %s
			Second:  %s
			Zone:    %s, %s
			UTC/Zulu: %s
		" ${JE[@]} ;
		printf "\nLocale  : ${JELOC}";
		printf "\nZulu UTC: ${JEUTC}";
		printf "\nEpoch(s): ${JESEC}
		%10s<time since 1970-01-01 00:00:00 Z >" " ";
		printf "\n\n";
  } ##=========================================================

  function jnow()  { printf "%s" $(date +%Y%m%d_%H%M%S         ); };
  function unow()  { printf "%s" $(date +%Y%m%d_%H%M%S -u      ); };
  function eunow() { printf "%s" $(date +%s            -u      ); };
  function snow()  { printf "%s" $(date +%s                    ); };

  function jnowe() { NOW=$(date +%Y%m%d_%H%M%S);    printf $NOW;  };
  function unowe() { NOW=$(date +%Y%m%d_%H%M%S -u); printf $NOW;  };
  function eunowe(){ NOW=$(date +%s -u);            printf $NOW;  };
  function snowe() { NOW=$(date +%s   );            printf $NOW;  };


  function lazt(){ printf $(ls -la --time-style='+%Y%m%d-%H%M' ${1} |awk '{print $6}'); };
  function ruk(){
	  T=$(printf $(ls -la --time-style='+%Y%m%d-%H%M' ${1} |awk '{print $6}'));
    cp -vf --preserve=timestamps ${1} ${1}__${T} ;
  };
  function ruk(){
    cp -vf --preserve=timestamps ${1} ${1}__$(
    		printf  $(ls -la --time-style='+%Y%m%d-%H%M' ${1}|awk '{print $6}')) ;
  };
  function dup(){ f=$1;  now=$(fnow); cp -pv ${1} ${1}__${now}; };

###########################################################

##=========================================================
# # MARKME AND MARKDAS
  marklog="$HOME/Documents/mynotes.txt" ;
  TT="/home/dac/TAGE";
  function markme(){
    TT="/home/dac/TAGE";
    marklog="$HOME/Documents/mynotes.txt" ;
    printf " Markme files is $marklog \n ....." ;
    printf "\n$PRBR\n  $(date -u +%s) :: $(date +%g.%V) :: $(date) ::\n$PRBR\n" \
			| tee -a $marklog | tee -a $TT ;
    printf " Peeking at last 4 rows of $marklog ...." ;
    tail -n 4 $marklog ;
  }
  function marklos(){
    marklog=$(loo) ;
    printf " Markme files is $marklog \n ....." ;
    printf "\n$PRBR\n  $(date -u +%s) :: $(date +%g.%V) :: $(date) ::\n$PRBR\n" \
			| tee -a $marklog ;
    printf " Peeking at last 4 rows of $marklog ...." ;
    tail -n 4 $marklog ;
  }
  function markest(){
    marklog=${1} ;
    printf " Markme files is $marklog \n ....." ;
    printf "\n$PRBR\n  $(date -u +%s) :: $(date +%g.%V) :: $(date) ::\n$PRBR\n" \
			| tee -a $marklog ;
    printf " Peeking at last 4 rows of $marklog ...." ;
    tail -n 4 $marklog ;
  }
  function markwas(){
    read marklog - p 'enter file to mark: ' ;
    printf " Markme files is $marklog \n ....." ;
    printf "\n$PRBR\n  $(date -u +%s) :: $(date +%g.%V) :: $(date) ::\n$PRBR\n" \
			| tee -a $marklog ;
    printf " Peeking at last 4 rows of $marklog ...." ;
    tail -n 4 $marklog ;
  }
##=========================================================
 # lookup value in variable sets
  ### alias sef=' set | grep -A 20 -e "$1" '
  function sef(){
    lookaf=20;
    lookup=$1 ;
#   lookaf=$2 ;
#   [ -n "${2}"    ] && ( lookaf=20 );
    if [ -n "${2}" ] ; then ( lookaf=20 ); else (lookaf=$2);fi
#   [ -z "$lookaf" ] && ( lookaf=20 );
    set | grep -A $lookaf -e "$lookup" ;
    #unset lookup ; unset lookaf
  }

##=========================================================
  # alias tell=gettrail ;
  alias tell=" . $HUB/trail.sh" ;
  function gettrail(){
		export trail=$HOME/trail.txt ;
			ba=$(pp '==' 40);
			be=$(pp '==' 40);
			bc=$(pp '..' 40);
			bu=$(pp '__' 40);
			bn=$(pp '~~' 40);
			bp=$(pp '##' 40);
			bs=$(pp '//' 40);
		printf "\n $be \n $(date) \n $bc \n
		$(ls -laA1 -tr $PWD/* ) \n $bu " >> ~/trail.txt ;
		tail -n 10 ~/trail.txt ;
  }

###########################################################
	alias memo=" gedit ~/Documents/memo.txt & "
	function odateline(){
		printf "\n# %s\n $(date)\n $(pwd)\n $(hostname -s)\n# %s \n " \
    $(pfs '#' 77)  $(pfs '~' 77) >>$1
	}
	function dateline(){
		printf "\n# %s\n $(date)\n $(pwd)\n $(hostname -s)\n# %s \n " \
    $(pfs '#' 77)  $(pfs '~' 77)
	}
  # $(pfs '~~' 40)
###########################################################
#  monitoring cpu tools
	aloo=$HOME/atop.log
	floo=$HOME/freetop.log
	alias atop=" . /home/common/sh/atop.sh"
	alias memow=' memorywatch.sh s 15 i 4 & '

	function meshgen() {
		memorywatch.sh s 15 i 4   &
		meshsim.sh 16             &
	}

###########################################################
# other applications
	alias spyder='/opt/pyanaconda/bin/spyder & ' ;

###########################################################
  ONEDR='/home/dac/onedrive';
  ONEDR='/ware1a/onedrive';
  ONENIC="${ONEDR}/NICKEL";
  ONEARB="${ONEDR}/_arb";
  ONEETC="${ONEDR}/_etc";
  ONESIM="${ONEDR}/_SIM_";
  ONEDAT="${ONEDR}/_SIM_/data";

##  sync-up repositories with .sh
  CAR="${ONEDR}/_etc/sh";
  function tax(){
    CAR="${ONEDR}/_etc/sh";
    printf "Repositories:
      HUB = $HUB
      DEN = /home/$USER/sh
      CAR = ${CAR}
    "
    REPOL=($HUB $HOME/sh $HOME/onedrive/_etc/sh ) ;
      chmod -R 777 $DEN $HUB $CAR

      cpt -r -pvu $DEN/*     $HUB/.
      cpt -r -pvu $HUB/*     $DEN/.
      cpt -r -pvu $HUB/*     $CAR/.

  }

###########################################################
## PATHS
## OLD : export PYTHONPATH=$PYTHONPATH:/home/dac/mylab:/home/dac/mylab/lib:/home/dac/mylab/star
  Catpath(){
    f=${1}; i=0;
    for p in `cat ${f} `;do
      q=${p:0:1}
      if [ "$q" != "#" ]; then
        if [ $i -gt 0 ]; then printf ":"; fi 
        printf "%s" $p; 
      fi;
      i=$((i+1));
    done
  };
  # PYTHONPATH:
  RC_ENV_PATH=$HOME/rc/paths/
  PYTHONPATH=$( Catpath ${RC_ENV_PATH}/PYTHONPATH )
  #printf "PYTHONPATH=%s \n" $PYTHONPATH
#==============================================================================#
. ~/sh/bashboot.sh

#alias jp='jupyter notebook ${1}  & '
jp(){
	jupyter notebook ${1} 
}

pipi(){
	python3 -m pip install ${1} | tee -ai  ~/pip_install.log
}
 condain(){
	conda install -y  ${1} | tee -ai  ~/conda_install.log
}
 pyinstall(){
    printf "\n Now installing ${1} \n\n";
    if [ ${2}=="cf" ]; then cc="-c conda-forge"; printf "\t... will use conda-forge \n\n" ; fi;
    
    echo "#pyinstall ${1} " >> ~/pyinstall.list.txt
    python3 -m pip install ${1} | tee -ai  ~/pip_install.log	
    echo "#conda install -y ${1} ${cc} | tee -ai  ~/conda_install.log " >> ~/pyinstall.list.txt
    conda install -y ${1} ${cc} | tee -ai  ~/conda_install.log
}
 . ~/sh/cfgpaths.sh

### set app path 
  alias setapp.sh='. ~/sh/setapppath.sh '
  . ~/.pathrc_apps

##### more paths for projects.... 
  meta='/Users/dac/qlab/metash/'
  qlab='/Users/dac/qlab/'
  export PATH=$PATH:/Users/dac/qlab/metash/
  meta_testing=/Users/dac/qlab/testing
  # /Applications/PowerShell.app/Contents/MacOS/PowerShell.sh 
  # alias psh='. /Applications/PowerShell.app/Contents/MacOS/PowerShell.sh '
  powershell(){
   .  /Applications/PowerShell.app/Contents/MacOS/PowerShell.sh
  }
  alias pwsh='/usr/local/microsoft/powershell/7/pwsh'
  pwsh_profile='~/.config/powershell/Microsoft.PowerShell_profile.ps1'
  pwsh_profile_homesh="$HOME/sh/PS_PROFILE.ps1"
