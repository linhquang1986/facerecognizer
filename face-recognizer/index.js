const express = require('express')
const app = express()
const path = require('path');
const fs = require('fs');
const Buffer = require('buffer').Buffer;
// import fs from 'fs'

app.get('/webcam', (req, res) => {

    const { spawn } = require('child_process');
    const pyProg = spawn('python3', ['./webcam.py']);

    pyProg.stdout.on('data', function(data) {

        console.log(data.toString());
        let buff = new Buffer(data, 'base64');
        decode_base64(data,'rane.png');
        // res.write(buff);
        //res.end('end');
    });
})

app.listen(3000, () => console.log('Application listening on port 3000!'))

function decode_base64(base64str , filename){

    var buf = Buffer.from(base64str,'base64');
  
    fs.writeFile(path.join(__dirname,'/public/',filename), buf, function(error){
      if(error){
        throw error;
      }else{
        console.log('File created from base64 string!');
        return true;
      }
    });
  
  }