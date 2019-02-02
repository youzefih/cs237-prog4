*----------------------------------------------------------------------
* Programmer: Youssef Iraqi
* Class Account:  cssc0813
* Assignment or Title:  recursive
* Filename: binSearch.s
* Date completed:  
*----------------------------------------------------------------------
	
	ORG $8000
        
hi:           EQU           14
lo:           EQU           10
key:          EQU           8

binSearch:	

              link	    A6,#0
              movem.l	    A0-A3/D1-D3,-(SP)    *registers used
              move.w        key(A6),D1   * key saved              
	      movea.l       lo(A6),A0    * &lo saved
              movea.l       hi(A6),A1    * &hi saved
              
    * CHECKING TO SEE IF HIGH IS BIGGER THAN LOW
 
              cmpa.l    A0,A1   * HI>LO  
              Bhi       curse
              move      #2,CCR
              BRA       DONE * GOTO NOTFOUND *
              
    *ADDING LOW + HIGH AND DIVIDING BY TWO  
curse:  
              move.l    A1,D2
              add.l     A0,D2    
              asr.l     #1,D2  * dividing by two 
              andi.w    #$fffe,D2
              move.l    D2,A3  
              
    *CHECKING IF THE INPUT IS LESS THAN MID  
    
              cmp.w   (A3),D1   *Comparing Key with mid
       	      BEQ     MID	*if they're equal go to mid
       	      cmp.w   (A3),D1   
       	      BLT     SMALL  * if smaller go to small
        	
BIG:      * return binSearch(key, mid+1, hi); // right*

              addq.w   #2,A3   *adding one to middle
	      cmp.w    (A3),D1
	      BEQ       MID 
              movea.l  A3,A0   * making mid the new low 
              pea     (A1)
              pea     (A0)
              move.w  D1,-(SP)
              jsr     binSearch
              adda.l  #10,SP
	      bra     DONE

MID:          move.l   A3,D0
              BRA      DONE




SMALL:     *return binSearch(key, lo, mid-1); // left

             subq.w   #2,A3 
	     cmp.w    (A3),D1
	     BEQ       MID 
             movea.l  A3,A1  * making mid the new high
             pea     (A1)
             pea     (A0)
             move.w  D1,-(SP)
             jsr     binSearch
             adda.l  #10,SP
	     BRA     DONE
DONE:

              movem.l		(SP)+,A0-A3/D1-D3  *restoring rgts
              unlk		     A6            * removing a6
              rts                                  * return    
              end 
