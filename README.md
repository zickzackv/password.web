
# Password.Web #

A simple centralized rails based password store. 

The data is encrypted with [aes265][0] [cbc][1] using a common 
secret. This secret is encrypted with the password of each user. 

For encryption or decryption of a stored seceret, the user has to use
his own password. 

For decryption of the common secret [crypto-js][2] is used.

[0]:https://de.wikipedia.org/wiki/Advanced_Encryption_Standard
[1]:https://en.wikipedia.org/wiki/Cipher_block_chaining#Cipher-block_chaining_.28CBC.29)
[2]:https://code.google.com/p/crypto-js/

## Installation ##

* create a `config/database.yml`

        development:  
          adapter: sqlite3  
          database: db/development.sqlite3  
          pool: 5  
        test:  
          adapter: sqlite3  
          database: db/test.sqlite3  
          pool: 5  
        production:  
          adapter: sqlite3  
          database: db/production.sqlite3  
          pool: 5  

* create the databases

        rake db:create:all
    
* run the migrations 

        rake db:migrate ; RAILS_ENV=production rake db:migrate

* setup your first user (wizard style)

        rails generate user
    
* start the server and enjoy

        rails server 
   
# Authors #

Paul Spieker

## Credits ##
 
Based on the idea of
[webpasswordsafe](https://code.google.com/p/webpasswordsafe/)

## License ##

Not specifyd yet.






