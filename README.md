# ticket_viewer

### 1. Solution summary
This is a full stack solution built to: 
1. Connect to the Zendesk API
2. Request all the tickets for my trial account
3. Display them in a list
4. Page through tickets with each page showing maximum 25 tickets
5. Display individual ticket details
<br /><br />
Technologies used: Ruby 2.7.0, Ruby Sinatra, Minitest, React <br />
Repo for the React frontend is [here](https://github.com/allen0lee/ticket-viewer-react).

### 2. How to run this solution
1. Install RVM(Ruby Version Manager) and Ruby 2.7.0 if you don't have it in your system. 

2. Install dependencies<br />
Clone this solution repo to your machine, inside the repo directory, type the following in terminal window: `bundle`<br /> 
If you can't find the command, install by typing: `gem install bundler`<br />
This will install the dependencies required to run the solution.

3. Run the solution<br />
In the repo directory window, type: `rackup  config.ru`<br />
Open your web browser, type in: `localhost:9292`<br />
By now you have finished setting up the backend.<br />
Download the React frontend (Repo is [here](https://github.com/allen0lee/ticket-viewer-react)), follow the instructions there and you will see the results on the frontend.

4. Run the test<br />
This solution provides test on:
* User authication when making requests to the Zendesk API
* Whether valid tickets are coming back
* Whether single ticket details are available
* Whether the requester's name of a ticket is available
<br /><br />
To run the test, navigate to the `test` folder, run the test file by typing: `ruby api_helper_test.rb`

### 3. Key things to know
This solution is built using a design pattern called model-view-controller(MVC).<br />
* Model - `Ticket` class
* View - render different pages (tickets list, single ticket details, error) on the web browser, using model data. A React frontend is developed to perform this task.  
* Controller - API endpoints and methods that decide which view would be displayed and prepare the data needed by views 
  
       
