// Setup basic express server
var express = require('express');
var app = express();
var server = require('http').createServer(app);
var io = require('../..')(server);
var port = process.env.PORT || 3000;

server.listen(port, function () {
  console.log('Server listening at port %d', port);
});

// Routing
app.use(express.static(__dirname + '/public'));

// Chatroom

var numUsers = 0;

io.on('connection', function (socket) {
  var addedUser = false;

  //---------add motix egm service api----------------------
  socket.on('motixLogin',function(data){
    //{"R":1001,"UN":"U001","P":"123456"}
    socket.emit('motixLoginResult', {
      "R": 1001,
      "EC": 0,
      "D": "",
      "T": 1
    })
  });

  socket.on('searchByEgmId',function(data) {
    //data:{"R":1002,"EI":"110"}
    socket.emit('searchByEgmIdResult',
        {
          "R": 1002,
          "EI": "110",
          "EC": 0,
          "D": "",
          "EIF": {
            "EI": "110",
            "ARE": "AA",
            "CI": 100,
            "CO": 100,
            "AI": 100,
            "AO": 100,
            "TD": 100,
            "TCC": 100,
            "CC": 10000
          }/*,
          "MIF": {
            "MI": "110",
            "IMG": "https://avatars3.githubusercontent.com/u/16330877?v=3&s=400",//"http://www.xxx.com/head?mid=110",
            "N": "Jenny Smith",
            "AN": "Agent Name",
            "AC": 10000,
            "L": 3,
            "C": 100,
            "NR": 100,
            "R": 100,
            "LLT": "2017-07-01 12:12:12",
            "LLEI": "123"
          }*/
        }
    );
  });

  socket.on('searchByPlayerId',function(data){
    //data:{"R":1003,"MI":"110"}
    socket.emit('searchByPlayerIdResult', {
      "R": 1003,
      "MI": "110",
      "EC": 0,
      "D": "",
      /*
      "EIF": {
        "EI": "110",
        "ARE": "AA",
        "CI": 100,
        "CO": 100,
        "AI": 100,
        "AO": 100,
        "TD": 100,
        "TCC": 100,
        "CC": 10000
      },*/
      "MIF": {
        "MI": "110",
        "IMG": "https://avatars3.githubusercontent.com/u/16330877?v=3&s=400",//"http://www.xxx.com/head?mid=110",
        "N": "Jenny Smith",
        "AN": "Agent Name",
        "AC": 10000,
        "L": 3,
        "C": 100,
        "NR": 100,
        "R": 100,
        "LLT": "2017-07-01 12:12:12",
        "LLEI": "123"
      }
    });
  });

  socket.on('getEgmInfo',function(data){
    //data:{"R":1004,"EI":"110"}
    socket.emit('getEgmInfoResult', {
      "R":1004,
      "EC":0,
      "D":"",
      "EI":"110",
      "EIF":{
        "EI":"110",
        "ARE": "AA",
        "CI":100,
        "CO":100,
        "AI":100,
        "AO":100,
        "TD":100,
        "TCC":100,
        "CC":10000
      }/*,
      "MIF": {
        "MI": "110",
        "IMG": "https://avatars3.githubusercontent.com/u/16330877?v=3&s=400",//"http://www.xxx.com/head?mid=110",
        "N": "Jenny Smith",
        "AN": "Agent Name",
        "AC": 10000,
        "L": 3,
        "C": 100,
        "NR": 100,
        "R": 100,
        "LLT": "2017-07-01 12:12:12",
        "LLEI": "123"
      }*/
    })
  });

  socket.on('getPlayerInfo',function(data){
    //data:{"R":1009,"MI":"110"}
    socket.emit('getPlayerInfoResult', {
      "R":1009,
      "EC":0,
      "D":"",
      "MIF": {
        "MI": "110",
        "IMG": "https://avatars3.githubusercontent.com/u/16330877?v=3&s=400",//"http://www.xxx.com/head?mid=110",
        "N": "Jenny Smith",
        "AN": "Agent Name",
        "AC": 10000,
        "L": 3,
        "C": 100,
        "NR": 100,
        "R": 100,
        "LLT": "2017-07-01 12:12:12",
        "LLEI": "123"
      }
    })
  });

  socket.on('loginToEgm',function(data){
    //data:{"R":1005,"EI":"100","MI":"110"}
    socket.emit('loginToEgmResult', {
      "R": 1005,
      "EC": 0,
      "D": ""
    })
  });

  socket.on('logoutFromEgm',function(data){
    //data:{"R":1006,"EI":"100","MI":"110"}
    socket.emit('logoutFromEgmResult', {
      "R": 1006,
      "EC": 0,
      "D": ""
    })
  });

  socket.on('transferToEgm',function(data){
    //data:{"R":1007,"EI":"100","MI":"110","P":"123456","A":1000}
    socket.emit('transferToEgmResult', {
      "R": 1007,
      "EC": 0,
      "D": "",
      "ECC": 11000,
      "ACC": 9000
    });
  });

  socket.on('transferToAcc',function(data){
    //data:{"R":1008,"EI":"100","MI":"110","P":"123456","A":1000}
    socket.emit('transferToAccResult', {
      "R": 1008,
      "EC": 0,
      "D": "",
      "ECC": 9000,
      "ACC": 11000
    });
  });

  //------------------motix egm service end--------------------------

  // when the client emits 'new message', this listens and executes
  socket.on('new message', function (data) {
    // we tell the client to execute 'new message'
    socket.broadcast.emit('new message', {
      username: socket.username,
      message: data
    });
  });

  // when the client emits 'add user', this listens and executes
  socket.on('add user', function (username) {
    if (addedUser) return;

    // we store the username in the socket session for this client
    socket.username = username;
    ++numUsers;
    addedUser = true;
    socket.emit('login', {
      numUsers: numUsers
    });
    // echo globally (all clients) that a person has connected
    socket.broadcast.emit('user joined', {
      username: socket.username,
      numUsers: numUsers
    });
  });

  // when the client emits 'typing', we broadcast it to others
  socket.on('typing', function () {
    socket.broadcast.emit('typing', {
      username: socket.username
    });
  });

  // when the client emits 'stop typing', we broadcast it to others
  socket.on('stop typing', function () {
    socket.broadcast.emit('stop typing', {
      username: socket.username
    });
  });

  // when the user disconnects.. perform this
  socket.on('disconnect', function () {
    if (addedUser) {
      --numUsers;

      // echo globally that this client has left
      socket.broadcast.emit('user left', {
        username: socket.username,
        numUsers: numUsers
      });
    }
  });
});
