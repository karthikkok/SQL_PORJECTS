


-- Library Database analysis project

-- Tables Creations

create database library_p;

use library_p;

create table publisher(publisher_PublisherName varchar(50) primary key,
						publisher_PublisherAddress varchar(255),
                        publisher_PublisherPhone varchar(20)
                        );

select * from publisher;



create table borrower(borrower_CardNo tinyint primary key,
						borrower_BorrowerName varchar(50),
                        borrower_BorrowerAddress varchar(255),
                        borrower_BorrowerPhone varchar(50)
                        );
desc borrower;                        
						
select * from borrower;

create table library_branch(library_branch_BranchID tinyint auto_increment primary key,
							library_branch_BranchName varchar(50) ,
                            library_branch_BranchAddress varchar(50)
                            );
                            
select * from library_branch;                            


create table books(book_BookID tinyint primary key,
					book_Title varchar(255),
                    book_PublisherName varchar(255),
                    FOREIGN KEY(book_PublisherName) REFERENCES  publisher(publisher_PublisherName)
					on update cascade on delete cascade
                    );
		
select * from books;
desc books;

create table book_loans(book_loans_LoansID tinyint auto_increment ,
						book_loans_BookID tinyint ,
						book_loans_BranchID tinyint ,
                        book_loans_CardNo tinyint ,
                        book_loans_DateOut varchar(10) ,
                        book_loans_DueDate varchar(10),
                        primary key(book_loans_LoansID),
                        foreign key(book_loans_BookID) references books(book_BookID)
                        on update cascade on delete cascade,
                        foreign key(book_loans_BranchID) references library_branch(library_branch_BranchID)
                        on update cascade on delete cascade,
                        foreign key(book_loans_CardNo) references borrower(borrower_CardNo)
                        on update cascade on delete cascade
                        );
                        
select * from book_loans;   

create table book_copies(book_copies_CopiesID tinyint auto_increment ,
						book_copies_BookID tinyint ,
						book_copies_BranchID tinyint ,
                        book_copies_No_Of_Copies tinyint ,
                        primary key (book_copies_CopiesID ),
                        foreign key(book_copies_BookID) references books(book_BookID) 
                        on update cascade on delete cascade,
                        foreign key(book_copies_BranchID) references library_branch(library_branch_BranchID) 
                        on update cascade on delete cascade
                        );
					
select * from book_copies;                    

create table book_authors(book_authors_AuthorID tinyint auto_increment ,
							book_authors_BookID tinyint ,
							book_authors_AuthorName varchar(20),
                            primary key(book_authors_AuthorID),
                            foreign key(book_authors_BookID) references books(book_BookID)
                            on update cascade on delete cascade 
                            );
                            
select * from book_authors; 
desc book_authors;



                           