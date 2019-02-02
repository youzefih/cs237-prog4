int &binSearch(int key, int &lo, int &hi) {  done
    if(hi < lo)                         done
       return NOT_FOUND;  //RETURN with V = 1       NOT!!
    int mid = (lo+hi) / 2;          DONE
    
    if(key == array[mid])           DONE
       return mid;                  NOT!!!!!
    else if(key < array[mid]) // go left            NOT!!!
       return binSearch(key, lo, mid-1); // left    NOT!!
    else        
       return binSearch(key, mid+1, hi); // right   NOTT!!
    }


HOW DO I GET IT TO IMPUT *NOTFOUND*
HOW DO I GET IT TO INPUT *MIDDLE*
WHEN I EXIT THE BINSEARCH WHERE DOES MY PROGRAM GO TO? 


ORG $8000
		
        
hi:           EQU           8
lo:           EQU           12
key:          EQU           16

binSearch:	

              link	    A6,#0
              movem.l	    A0-A3/D1-D3,-(SP)    *registers used
              move.w        key(A6),D1   * key saved              
	          movea.l       lo(A6),A0    * &lo saved
              movea.l       hi(A6),A1    * &hi saved
              
    * CHECKING TO SEE IF HIGH IS BIGGER THAN LOW
 
              cmpa.l    A0,A1   * HI>LO  
              BHI       curse
              move      #2,CCR
              BRA       DONE * GOTO NOTFOUND *
              
    *ADDING LOW + HIGH AND DIVIDING BY TWO 
curse:  
              move.l    A1,D2
              add.l     A0,D2    
              asr.l     #1,D2  * dividing by two 
              andi.w    #$FFFE,D2   * MID IS IN D2
              move.l    D2,A3  
              
    *CHECKING IF THE INPUT IS LESS THAN MID 
    
              cmp.w   A3,D1   *Comparing Key with mid
       	      BEQ     MID	*if they're equal go to mid
       	      cmp.w   A3,D1   
       	      BLT     SMALL  * if smaller go to small
        	
BIG:      * return binSearch(key, mid+1, hi); // right*
           addq.w   #1,A3   *adding one to middle
           movea.l  A3,A0   * making mid the new low 
           pea      A0
           jsr      binSearch  *recursing
           


MID:        move.l   A3,D0
            BRA      DONE












SMALL:     *return binSearch(key, lo, mid-1); // left
           subq.w   #1,A3 
           movea.l  A3,A1  * making mid the new high
           pea      A1
           jsr      binSearch
       
       
       
     
DONE:

              movem.l		(SP)+,A0-A3/D1-D3  *restoring rgts
              unlk		     A6            * removing a6
              rts                                  * return    
              end 

