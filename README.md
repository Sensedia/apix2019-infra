# apix2019-infra

Este repositório contem os componentes, de infra estrutura, usados em comum por todos os micro serviços desenvolvidos durante o APIX. As aplicações estão dividas nas seguintes stacks:

### Desenvolvimento

* MySQL 5.7
* RaabitMQ 3.7-management
* ElasticSearch 7.0.1
* Kibana 7.0.1
* LogStash 7.0.1

### Monitoramento

* Prometheus
* Node-Exporter
* Alertmanager
* Grafana
* BlackBox
* cAdvisor

### Logs

* ElasticSearch 7.0.1 (o mesmo usado em desenvolvimento)
* Kibana 7.0.1 (o mesmo usado em desenvolvimento)
* Fluentd 1.4.2

# Pré requisitos para utilização da stack

Foi disponibilizado aos participantes um link para download da máquina virtual de desenvolvimento.

Se você quiser utilizar o seu próprio notebook, por favor, garanta que ele tenha instalado as aplicações abaixo:

* Docker
* Docker Compose

Também é legal você fazer o download prévio das imagens dos containers. Para isto, no diretório do repositório execute o comando:
```
$ docker-compose pull
```

Dependendo da sua conexão com a internet o download pode levar até 20 minutos.

# Como iniciar os containers

Os containers já estão configurados para iniciar automaticamente na máquina virtual de desenvolvimento fornecida pela Sensedia. Porem, caso necessite iniciar ou reiniciar algum container, a forma mais fácil de fazê-lo é:
```
$ cd apix2019-infra
$ ./apix2019-infra-start.sh
```
Contudo, se você é root e gosta de linha de comando:
```
$ docker-compose down
$ docker-compose build --no-cache
$ docker-compose up -d
```

# Como enviar os logs dos micro serviços para o Fluentd

Abra o arquivo docker-compose.yml da aplicação, em seguida adicione as linhas abaixo:

```
    logging:
      driver: fluentd
      options:
        fluentd-address: "localhost:24224"
        fluentd-async-connect: "true"
        tag: <nome-da-sua-aplicação>
```
Para visualizar os logs acesse a interface do Kibana:
```
http://localhost:5601
```

Se quiser fazer um teste de envio de logs inicie o servidor web contido no arquivo docker-compose-web.yml:
```
$  docker-compose -f docker-compose-web.yml up -d
```

Depois faça uma chamada na aplicação:
```
$ curl -I http://localhost:40080
```

Em seguida veja os logs no Kibana:
```
http://localhost:5601
```

## License
[AGPLv3.0](https://choosealicense.com/licenses/agpl-3.0/)