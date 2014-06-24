<<<"One_Fugue_for_each_day_of_the_next_25920_Years">>>; //prints title
//listen to 7225260 FUGUE
//Sound chain
Pan2 xunomaster =>  dac;


//estimate duration

// SndBuf click => Pan2 p1 => NRev verbOscA =>xunomaster;
SinOsc oscA => Pan2 pA => xunomaster;
TriOsc oscB => Pan2 pB => xunomaster;
SinOsc oscC => Pan2 pC => xunomaster;
TriOsc oscD => Pan2 pD => xunomaster;

/////////////////////////////////////////////////////////////////
//SEED 
/////////////
Math.random2( 1, 9331200 )=> int seed;//25920.360
//set seed with the day's number
if (me.args()==1) Math.srandom(Std.atoi( me.arg(0)));
else Math.srandom(seed);
seed/365=> int year;
seed%365 =>int days;

<<<"Year", year,"Day number:",days>>>;
<<<"Name", seed>>>;
/////////////////////////////////////////////////////////////////

//reset Gain
0 =>oscA.gain=>oscB.gain=>oscC.gain=>oscD.gain;;


//set pan positions
-1.0 =>pA.pan;
0.333 =>pB.pan;
-0.333 =>pC.pan;
1.0 =>pD.pan;

//store now to deduct lenght later       
now => time t1;

//init beat counter
0=> int counter;  

//timing parammeter 
0.43 => float beattime;
// 0.35 => float beattime;

//global arrays
[49, 50, 52, 54, 56, 57, 59, 61,0] @=> int notes[];

//create arrays of random notes with a lengh of x notes in each one
20=> int x;
int melo_1 [x]; 
int melo_2 [x];
int melo_3 [x]; 
int melo_4 [x];
int melo_5 [x]; 
int melo_6 [x];

//put the random notes into each arr
for( 0=>int i; i < melo_1.cap() -1 ; i++) 
{ 
    notes[Math.random2(0, notes.cap()-1)] => melo_1[i]; 
    notes[Math.random2(0, notes.cap()-1)] => melo_2[i];
    notes[Math.random2(0, notes.cap()-1)] => melo_3[i]; 
    notes[Math.random2(0, notes.cap()-1)] => melo_4[i];
    notes[Math.random2(0, notes.cap()-1)] => melo_5[i]; 
    notes[Math.random2(0, notes.cap()-1)] => melo_6[i];
} 

// small utility function to print integer arrays, as strings
fun string int_array_asString(int a[]){
    "[" + Std.itoa(a[0]) => string output_str;
    for (1 => int i; i < a.cap(); i++){
        output_str + ", " + Std.itoa(a[i]) => output_str;
    }
    return output_str + "]";
}
<<<"melo_1", int_array_asString(melo_1) >>>;
<<<"melo_2", int_array_asString(melo_2) >>>;
<<<"melo_3", int_array_asString(melo_3) >>>;
<<<"melo_4", int_array_asString(melo_4) >>>;

////////////////////////////////////////////////////
// COMPOSITOR's ID
//this should no be used aalways...
//rewrite last notes of melo_1 array (for pseudocompositional reasons)
//this short succesion will be reapeated at the end of each subject
// 61 => melo_1[x-1]; //store this value into position x -1 of the arrray
// 59 => melo_1[x-2];
// 57 => melo_1[x-3];
// 52 => melo_1[x-4];
// 50 => melo_1[x-5];
// 49 => melo_1[x-6];

<<<"melo_1", int_array_asString(melo_1) >>>;//print again  to see the changes
////////////////////////////////////////////////////

/* ****************************** */
public class FUGER
 {
     fun void play( int x[], int y, int z)
    {        
        for (0 => int i; i < x.cap(); i++ )
        {
            if (z==0 ) Std.mtof((x[i])+ y)  => oscA.freq;// set freq using array A and route audio to the proper instrument
            if (z==1 ) Std.mtof((x[i])+ y)  => oscB.freq ;// route audio to OscB 
            if (z==2 ) Std.mtof((x[i])+ y)  => oscC.freq ;// route audio to OscC
            if (z==3 ) Std.mtof((x[i])+ y)  => oscD.freq ;// route audio to OscC
           beattime::second =>now;

        }
     }
}     
/* ****************************** */
// SCORE

// 1=> env.keyOn;

  1=>int i;

 ////////////////////////////////////////////////////
 //FUGUE MAKER   
/////////////
FUGER Fa;
FUGER Fb;
FUGER Fc;
FUGER Fd;
FUGER Fe;
FUGER Ff;
FUGER Fg;
FUGER Fh;
FUGER Fi;
FUGER Fj;
////////////////////////////////////////////////////
 while(true)
{ 
//FIRST VOICE
0.6 => oscA.gain;
spork~Fa.play(melo_1, 0, 0); 
beattime::second*x =>now;

//SECOND VOICE
0.4/2 => oscA.gain => oscB.gain;
// play(melo_2, 7, 0, melo_1, 7, 1); 
spork~ Fb.play(melo_2, 7, 0);
spork~ Fc.play (melo_1, 7, 1); 
beattime::second*x=>now;

//SECOND VOICE, solo
0.6 => oscA.gain;
spork~Fa.play(melo_2, 0, 0); 
beattime::second*x =>now;
    
//THIRD VOICE, three voices  
0.5/2 => oscA.gain=>oscB.gain;
0.4 => oscC.gain;
spork~ Fd.play(melo_3, 2,0 ) ;
spork~ Fe.play (melo_2, 14,1);
spork~ Ff.play (melo_1, 14,2);
beattime::second*x=>now;

//THIRD VOICE, solo
0.6 => oscA.gain;
spork~Fa.play(melo_3, 0, 0); 
beattime::second*x =>now;
    

//FOURTH VOICE, four voices    
0.4/3 => oscA.gain=>oscB.gain=>oscC.gain;
0.5 => oscD.gain;
spork~ Fg.play (melo_4, -3,0 ) ;
spork~ Fh.play (melo_3, 9,1);
spork~ Fi.play (melo_2, 21,2);
spork~ Fj.play (melo_1, -15,3);
beattime::second*x=>now;

// //FIRST VOICE again
// 0.6 => oscA.gain;
// spork~Fa.play(melo_4, 0, 0); 
// beattime::second*x =>now;
    
// //Reexposition 1 rotating all the four voices VOICE    
// 0.4/3 => oscA.gain=>oscB.gain=>oscC.gain;
// 0.5 => oscD.gain;
// spork~ Fg.play (melo_3, -3,0 ) ;
// spork~ Fh.play (melo_4, 9,1);
// spork~ Fi.play (melo_1, 21,2);
// spork~ Fj.play (melo_2, -15,3);
// beattime::second*x=>now;

// // //FIRST VOICE again
// // 0.6 => oscA.gain;
// // spork~Fa.play(melo_3, 0, 0); 
// // beattime::second*x =>now;

// // //Reexposition 2 rotating all the four voices VOICE    
// // 0.4/3 => oscA.gain=>oscB.gain=>oscC.gain;
// // 0.5 => oscD.gain;
// // spork~ Fg.play (melo_2, -3,0 ) ;
// // spork~ Fh.play (melo_3, 9,1);
// // spork~ Fi.play (melo_4, 21,2);
// // spork~ Fj.play (melo_1, -15,3);
// // beattime::second*x=>now;


// // //FIRST VOICE again
// // 0.6 => oscA.gain;
// // spork~Fa.play(melo_1, 0, 0); 
// // beattime::second*x =>now;


// //Reexposition 3 rotating all the four voices VOICE    
// 0.4/3 => oscA.gain=>oscB.gain=>oscC.gain;
// 0.5 => oscD.gain;
// spork~ Fg.play (melo_1, -3,0 ) ;
// spork~ Fh.play (melo_2, 9,1);
// spork~ Fi.play (melo_3, 21,2);
// spork~ Fj.play (melo_4, -15,3);
// beattime::second*x=>now;


// //CODA A /21notes
// 0.8/4 => oscA.gain=>oscB.gain=>oscC.gain=>oscD.gain;
// spork~ Fg.play (melo_1, 4,0 ) ;
// spork~ Fh.play (melo_1, 16,1);
// spork~ Fi.play (melo_1, 21,2);
// spork~ Fj.play (melo_1, -8,3);
// beattime::second*x=>now;

1::second =>now;
// Turn down all volume
0=> oscA.gain=>oscB.gain=>oscC.gain=>oscD.gain;

now => time t2;
<<<"TOTAL DURATION:",(t2-t1)/second,"seconds">>>;
<<<"run the command 'chuck <PATH_TO_FILE>:",seed, " in your terminal to play this again">>>;

1::second =>now;

break;


 }
