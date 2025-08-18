const express = require('express');
const https = require('https');
const http = require('http');
const { URL } = require('url');
const app = express();

app.use(express.json());

// Handle CORS preflight requests for /proxy only
app.options('/proxy', (req, res) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', '*');
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
  res.sendStatus(200);
});

app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', '*');
  next();
});

app.post('/proxy', (req, res) => {
  const urlStr = req.query.url;
  if (!urlStr) return res.status(400).send('Missing url param');
  const urlObj = new URL(urlStr);
  const lib = urlObj.protocol === 'https:' ? https : http;
  const options = {
    method: req.headers['x-http-method-override'] || 'PUT',
    headers: {
      ...req.headers,
      host: urlObj.host
    }
  };
  const proxyReq = lib.request(urlStr, options, proxyRes => {
    res.writeHead(proxyRes.statusCode, proxyRes.headers);
    proxyRes.pipe(res, { end: true });
  });
  proxyReq.on('error', err => {
    res.status(500).send('Proxy error: ' + err.message);
  });
  if (req.body && Object.keys(req.body).length) {
    proxyReq.write(JSON.stringify(req.body));
  } else {
    req.pipe(proxyReq, { end: true });
  }
  proxyReq.end();
});

app.listen(3000, () => console.log('CORS proxy running on port 3000'));
