const express = require('express');
const app = express();

app.set("port", process.env.PORT || 5000);

let name = process.port || 'Erro';
app.get('/', (req, res) => {
  res.send('Cargo: Sr DevOps Engineer' + '<br/>' + 'Candidato: Hercules Aleixo');
});

app.get("/", function(req, res) {
  res.sendStatus(200);
});

app.listen(app.get("port"));
console.log('Aplicação teste executando em http://localhost:', app.port);

app.use('/healthcheck', require('express-healthcheck')());
app.use('/healthcheck', require('express-healthcheck')({
    healthy: function () {
        return { everything: 'is ok' };
    }
}));
