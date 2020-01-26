* Program Name: W2G0460
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Transaction Delete Module.
*
*
function w2g0460()
memvar getlist
set escape on
set exact off
m->rec_id   = space (09)
m->r          = 4
seek dtoc(m->b_date)+str(m->b_number,4)
clear
@  0, 20  say "Transaction Delete Screen"
@  2, 00  say "   SSN"
@  3, 00  say "-----------"
@  2, 15  say "Gross Amount"
@  3, 15  say "------------"
@  2, 30  say "Federal Withholding"
@  3, 30  say "-------------------"

if m->state_tax = 'Y' 
   @ 2, 55 say "State Withholding"
   @ 3, 55 say "-----------------"
end-if 

do while ticket->batch_date = m->b_date   .and. ;
	     ticket->batch_num  = m->b_number .and. .not. eof()

         @  4, 00  say substr(ticket->record_id,1,3) + '-' + ;
         			   substr(ticket->record_id,4,2) + '-' + ;
                       substr(ticket->record_id,6,4)
                       
         @  4, 15  say ticket->gross	 picture '$9,999,999.99'
         @  4, 30  say ticket->fed_with	 picture '$9,999,999.99'

         if m->state_tax = 'Y'
		    @ 4, 55 say ticket->sta_with picture '$9,999,999.99'
		 end-if

         @  6, 10  say "Would you like to delete this transaction (y or n)?"

         m->choice = ' '

         do while .not. m->choice$'YNX'
            m->choice = ' '
            @  7, 10  get m->choice picture '!'
            read
         enddo

         do case
            case m->choice = 'Y'

	             @ 8, 10 say "Please verify the delete of this transaction (y or n)."

	             m->choice = ' '

	             do while .not. m->choice$'YNX'
	                m->choice = ' '
	                @  9, 10  get m->choice picture '!'
	                read
	             enddo

	             if m->choice = 'Y'
	                delete
	             endif

	             @ 8, 00 clear

            case m->choice = 'X'
	             clear
	             @ 7,20 say 'working, one moment please.'
	             pack
	             return (nil)
         endcase

         skip

         if eof()
            exit
         endif
enddo

@ 10,10 say "End of data for this batch"
wait
clear
@ 7,20 say 'Working, one moment please.'
pack
return (nil)
* eof w2g0460.prg
