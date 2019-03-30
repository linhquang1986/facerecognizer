const express = require('express')
const app = express()

app.get('/webcam', (req, res) => {

    const { spawn } = require('child_process');
    const pyProg = spawn('python3', ['./webcam.py']);

    pyProg.stdout.on('data', function(data) {

        console.log(data.toString());
        res.write(data);
        res.end('end');
    });
})

app.listen(3000, () => console.log('Application listening on port 3000!'))