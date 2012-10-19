
# Password.Web #

A simple centralized rails based password store


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
[webpasswordsafe][https://code.google.com/p/webpasswordsafe/]


## License ## 







