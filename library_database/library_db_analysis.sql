


-- Library Database Analysis

use library_p;

-- 1. How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?

select * from book_copies;
select * from library_branch;
select * from books;

select library_branch_branchname,book_title, sum(book_copies_no_of_copies) as copies from books
	inner join book_copies
    on books.book_bookid = book_copies.book_copies_bookid
		inner join library_branch
        on book_copies.book_copies_branchid = library_branch.library_branch_branchid
        where book_title in ('The lost tribe') and library_branch_branchname in ('sharpstown');
        
-- library branch 'sharpstown' have 5 copies of book titled 'the lost tribe'         

		
-- 2. How many copies of the book titled "TheLostTribe" are owned by each library branch ?

select library_branch_branchname,book_title, sum(book_copies_no_of_copies) as copies 
	from books
	inner join book_copies
    on books.book_bookid = book_copies.book_copies_bookid
		inner join library_branch
        on book_copies.book_copies_branchid = library_branch.library_branch_branchid
        
        group by library_branch_branchname, book_title
        having book_title = 'the lost tribe'
        ;

-- All the 4 library branches have each 5 copies of the book titled ' the lost tribe'



-- 3. Retrieve the names of all borrowers who do not have any books checked out.    

select * from borrower;        
select * from book_loans;

select * from borrower
	left join book_loans
    on borrower.borrower_cardno = book_loans.book_loans_cardno
    where book_loans_cardno is null
    ;
    
-- borrower_cardno - 101 , name - jane smith -did not borrow any book from the library


/* 4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, 
retrieve the book title, the borrower's name, and the borrower's address.
*/
                        
select book_title, borrower_borrowername , borrower_borroweraddress
	from borrower
	inner join book_loans
    on borrower.borrower_cardno = book_loans.book_loans_cardno
		inner join library_branch
        on book_loans_branchid  = library_branch_branchid
			inner join books
            on book_loans_bookid = book_bookid
            where book_loans_duedate = ('2/3/18') and library_branch_branchname in ('sharpstown')
            ;  
-- tom li was borrower whose duedate is 2/3/18 and the library branch is in sharpstown            
            
            
            
-- 5. For each library branch, retrieve the branch name and the total number of books loaned out from that branch

select library_branch_branchname,
		count(*) as books_loaned_out from library_branch
	inner join book_loans
    on library_branch_branchid = book_loans_branchid
    group by library_branch_branchname
    order by books_loaned_out desc ;

-- sharpstown - 10, central - 11, saline - 10, ann arbor - 20


    
-- 6. Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.

select borrower_borrowername, 
		borrower_borroweraddress, 
		count(book_loans_cardno) as book_checked_out 
	from borrower
	left join book_loans
    on borrower_cardno = book_loans_cardno
    group by borrower_cardno
    having book_checked_out > 5
    order by book_checked_out;

-- joe smith - 7, tom li - 14, angela thompson - 11, tom haverford - 6, michael horford - 8



-- 7. For each book authored by "StephenKing", retrieve the title and the number of copies 
-- owned by the library branch whose name is "Central"

with cte1 as (select * from    book_authors
        inner join books 
		on book_authors_bookid = book_bookid
			inner join book_copies 
			on book_authors_bookid = book_copies_bookid
				inner join library_branch 
				on book_copies_branchid = library_branch_branchid )
            
select 
    book_authors_authorname,
    book_title,
    book_copies_no_of_copies,
    library_branch_branchname
	from cte1
	where book_authors_authorname like ('s%%g') and library_branch_branchname like 'central'
    ;    
