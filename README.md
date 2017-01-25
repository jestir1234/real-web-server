# real-web-server
A Real Web Server and Browser (from the command line)

#Web Server and Browser
Utilize command line to simulate HTTP GET and POST requests, sending data from client to the server. 
#####To Run:
```
cd to real-web-server 
```

Set up the server in one terminal window:
```
ruby serveropen.rb
```

In another terminal window, run the mini browser:
```
ruby minibrowser.rb
```
######Outcome:

GET request (by default will GET the index.html file for localhost:2000):
```
What type of request do you want to send? (GET or POST): **GET**
```
```
HTTP/1.0 200 OK
Date: Date: 2017-01-25 18:25:58 -0500
Content-Type: text/html
Content-Length: 88

<html>
     <body>
       <h1>Welcome to the Viking Homepage!</h1>
     </body>
</html>
```

POST request:
```
What type of request do you want to send? (GET or POST): **POST**
What is your viking name? **Matt**
What is your viking email? **jestir1234@gmail.com**
```
```
POST /index.html HTTP/1.0
Content-Type: text/json
Content-Length: 57

<html>
  <body>
    <h1>Thanks for Posting, brotherrrr! </h1>
    <h2>Here's what we got from you:</h2>
    <ul>
      <li>name: Matt</li><br><li>email: jestir1234@gmail.com</li><br>
    </ul>
  </body>
</html>
```
