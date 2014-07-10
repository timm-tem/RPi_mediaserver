#!/bin/sh

#Script for crossfading to video clips. The script uses (depends on) 
#the netpbm packages and avconv.

#******************************
#the help text
#\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..
#.\/....\/....\/....\/....\/....\/....\/....\/....\/....\/...

# we have less than 3 arguments. Print the help text:
if [ $# -lt 3 ] ; then
cat <<HELP
The script needs 3 arg. The number one video clip (in mpg format) the number 
two video clip (in mpg format) and the lenght of the crossfade given with a number between 1 and 50.

example:
crossfade first.mpg secund.mpg 8
HELP
  exit 0
fi
#*****************************
#Some variable definition
#\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..
#.\/....\/....\/....\/....\/....\/....\/....\/....\/....\/...

beginv="$1"
finisv="$2"
#amount of frames
amoffr="$3"
mthirty=`expr "$amoffr" "*" 30`

#********************************
# If third argument is greater than 50 the script will stop
# width an error messages.
#.\/....\/....\/....\/....\/....\/....\/....\/....\/....\/...

if [ $amoffr -gt 50 ] ; then
echo "50 is the maximum number you can specify as the thert argument. 
That is 1500 frames with in most cases is one minut of video.
Please specify a number less than 50"
exit 0
fi

#*************************
# Converting and measurement and and split into portions 
# with avconv as the primary engine
#\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..
#.\/....\/....\/....\/....\/....\/....\/....\/....\/....\/...

avconv -i $beginv -sameq ret0tmp.avi;
duraline=`avconv -i ret0tmp.avi 2>&1 | grep "Duration"`

#the result of this process look like this:
#  Duration: 00:00:19.68, start: 0.500000, bitrate: 4949 kb/s

taldel=`echo "$duraline" |sed "s/^.*n. //" |sed "s/, start.*//"`
hou=`echo "$taldel" |cut -b1-2`
min=`echo "$taldel" |cut -b4-5`
sec=`echo "$taldel" |cut -b7-8`
minsec=`echo "$min$sec"`

#*************************
#Some good information to have on hand for the scripting :-)
#\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..
#.\/....\/....\/....\/....\/....\/....\/....\/....\/....\/...

#-eq Equal to
#-ne Not Equal to
#-lt Less than
#-le Less than or equal to
#-gt Greater than
#-ge Greater then or equal to

#************************************
#If less than or equal to 1 min and 20 seconds
#\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/

if [ "$minsec" -le 0120 ] ; then
avconv -i ret0tmp.avi -sameq et%d.png;
fi

#************************************
#If greater than 1 min. and 20 seconds and less than 10 min.
#this conditional statement is only needed for adding a zero before
#the minuet number or not.
#\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/

if [ "$minsec" -ge 0121 -a "$minsec" -lt 1000 ] ; then

	oneless=`expr "$min" "-" 1`
	nuladd=`echo "0$oneless"`
	oneless="$nuladd"

	avconv -t "$hou:$oneless:$sec" -i ret0tmp.avi -sameq forcat1.mpg;

    #the last minute of the first video clip is now 
    #written out to png images
    
    avconv -ss "$hou:$oneless:$sec" -i ret0tmp.avi -sameq  et%d.png;
    
    
fi

#**********************************
#If greater than or equal to 10 min.
#\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/

if [ "$minsec" -ge 1000 ] ; then

	oneless=`expr "$min" "-" 1`
	
	avconv -t "$hou:$oneless:$sec" -i ret0tmp.avi -sameq forcat1.mpg;
    
    #the last minute of the first video clip is now 
    #written out to png images
    
    avconv -ss "$hou:$oneless:$sec" -i ret0tmp.avi -sameq  et%d.png;
    
fi

rm ret0tmp.avi;

avconv -i $finisv -sameq ret0tmp.avi;
duraline=`avconv -i ret0tmp.avi 2>&1 | grep "Duration"`
taldel=`echo "$duraline" |sed "s/^.*n. //" |sed "s/, start.*//"`
hou=`echo "$taldel" |cut -b1-2`
min=`echo "$taldel" |cut -b4-5`
sec=`echo "$taldel" |cut -b7-8`
minsec=`echo "$min$sec"`

#***************************
#If less than or equal to 1 min and 20 seconds
#-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-

if [ "$minsec" -le 0120 ] ; then
# [#]
avconv -i ret0tmp.avi -sameq to%d.png;
fi

#************************************
#If greater than 1 min. and 20 seconds and less than 10 min.
#this conditional statement is only needed for adding a zero before
#the minuet number or not.
#\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/

if [ "$minsec" -ge 0121 -a "$minsec" -lt 1000 ] ; then

	onemore=`expr "$min" "-" 1`
	nuladd=`echo "0$onemore"`
	onemore="$nuladd"

	#The first minute of the second video clip is now 
    #written out to png images

    avconv -ss "$hou:$onemore:$sec" -i ret0tmp.avi -sameq  to%d.png;
	
	avconv -t "$hou:$onemore:$sec" -i ret0tmp.avi -sameq  forcat4.mpg;
    
fi

#***************************
#If greater than or equal to 10 min.
#\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/-\/

if [ "$minsec" -ge 1000 ] ; then

onemore=`expr "$min" "+" 1`

    avconv -ss "$hou:$onemore:$sec" -i ret0tmp.avi -sameq  to%d.png;
	
	#The first minute of the second video clip is now 
    #written out to png images
        
	avconv -t "$hou:$onemore:$sec" -i ret0tmp.avi -sameq forcat4.mpg;
    
fi

rm ret0tmp.avi

#**************************
# Then we just count how many files we have
# from the first video clip
#.\/....\/....\/....\/....\/....\/....\/....\/....\/....\/...

pus=1
while [ -f "et$pus.png" ]; do

	sumtal="$pus"
	tael=`expr "$pus" + 1`
	pus=$tael

done

#**************************
#Further sorting of the images
#\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..
#.\/....\/....\/....\/....\/....\/....\/....\/....\/....\/...

	splitpoint=`expr "$sumtal" "-" "$mthirty"`
	pus1="$splitpoint"
	pus2=1

while [ "$pus1" -le "$sumtal" ] ; do
		
	mv et${pus1}.png etaa${pus2}.png
	
	tael1=`expr "$pus1" + 1`
	pus1="$tael1"
	
	tael2=`expr "$pus2" + 1`
	pus2="$tael2"
	
done

#**************************
#Now the actual crossfading can begin
#\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..
#.\/....\/....\/....\/....\/....\/....\/....\/....\/....\/...


#*************************
#Production of an image to alpha mask
#.\/....\/....\/....\/....\/....\/....\/

maal=`pngtopnm etaa1.png |pnmfile`
widtha=`echo -n $maal |sed 's/.*, //' |sed 's/ by .*//'`
heighta=`echo -n $maal |sed 's/.*by //' |sed 's/ m.*//'`
ppmmake white $widtha $heighta >alphtmp.ppm;

listofdim="0.97
0.94
0.91
0.87
0.84
0.81
0.77
0.74
0.71
0.67
0.64
0.61
0.57
0.54
0.51
0.47
0.44
0.41
0.37
0.34
0.31
0.27
0.24
0.21
0.17
0.14
0.11
0.07
0.04
0.01
0.00
0.00
"

dimfactor=`echo "$listofdim" |sed "2,500d"`
echo "$dimfactor"
editlist=`echo "$listofdim" |sed "1d"`
listofdim="$editlist"

ppmdim "$dimfactor" alphtmp.ppm |ppmtopgm >alpha.pgm;

pus1=0
pus2=0

echo "the thirty levels of transference is applied to the given number of images";

while [ "$pus1" -le "$mthirty" ] ; do
	tael1=`expr "$pus1" + 1`
	pus1=$tael1
	tael2=`expr "$pus2" + 1`
	pus2=$tael2

if [ "$pus2" -eq $amoffr ] ; then
	#Start by resetting pus2 to zero
	pus2=0

pngtopnm etaa${pus1}.png >oeverst.pnm;
pngtopnm to${pus1}.png >nederst.pnm;

pamcomp -alpha=alpha.pgm oeverst.pnm nederst.pnm >comptmp.pnm; 

pnmtopng comptmp.pnm >to${pus1}.png;

#**********************************
#now the transperence mask levels is changed. 
#The modified mask will not have any in affect 
#before the next circle of the loop
#.\/....\/....\/....\/....\/....\/....\/....\/....\/....\/...

dimfactor=`echo "$listofdim" |sed "2,500d"`
echo "$dimfactor"
editlist=`echo "$listofdim" |sed "1d"`
listofdim="$editlist"
ppmdim "$dimfactor" alphtmp.ppm |ppmtopgm >alpha.pgm;

else

#********************************
# Otherwise, we do exactly the same but only without
# Change the mask at the end and without resetting $pus2
#.\/....\/....\/....\/....\/....\/....\/....\/....\/

pngtopnm etaa${pus1}.png >oeverst.pnm;
pngtopnm to${pus1}.png >nederst.pnm;
pamcomp -alpha=alpha.pgm oeverst.pnm nederst.pnm >comptmp.pnm; 
pnmtopng comptmp.pnm >to${pus1}.png;
fi
done

#************************************************************
# Now the many loose images is assembled into mpg video 
# clips and the mpg video clips are then assembled using 
# basic Unix command cat
#\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..
#.\/....\/....\/....\/....\/....\/....\/....\/....\/....\/...

avconv -f image2 -i et%d.png -sameq forcat2.mpg;
avconv -f image2 -i to%d.png -sameq forcat3.mpg;
cat forcat*.mpg >faded.mpg;

#************************************************************
# Cleaning up. Removing the many files that 
# was produced during the process
#\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..
#.\/....\/....\/....\/....\/....\/....\/....\/....\/....\/...

rm forcat*.mpg;
rm et*.png;
rm to*.png;
rm alpha.pgm;
rm comptmp.pnm;
rm alphtmp.ppm;
rm nederst.pnm;
rm oeverst.pnm;

#************************************************************
# The final text massages 
#\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..\||/..
#.\/....\/....\/....\/....\/....\/....\/....\/....\/....\/...
echo "The resulting video clip is in the file faded.mpg"