## oreno-kcl

### これなに？ 

- [Kinesis Client Library for Ruby](https://github.com/awslabs/amazon-kinesis-client-ruby) を使った雑なアプリケーション
- VPC Flow Logs => CloudWatch Logs Subscriptions によって Kinesis ストリームに保存されているデータ（REJECT されたログ）を Datadog Event に送信する
- http://inokara.hateblo.jp/entry/2015/09/04/170750

以下、イメージ。

![](http://cdn-ak.f.st-hatena.com/images/fotolife/i/inokara/20150904/20150904170914.png)

### 必要な情報

- AWS access key
- AWS secret access key
- Datadog API Key
- Kinesis のストリーム名
- ストリームが存在する AWS リージョン名

### 使い方

```sh
$ git clone https://github.com/inokappa/oreno-kcl.git
$ cd oreno-kcl
$ export STREAM_NAME=${Kinesis Stream Name}
$ export REGION_NAME=${AWS Region}
$ export AWS_ACCESS_KEY=${AWS ACCESS KEY}
$ export AWS_SECRET_KEY=${AWS SECRET ACCESS KEY}
$ export DATADOG_API_KEY=${Datadog API Key}
$ cat oreno.properties.template | while read line; do eval "echo `echo $line`"; done > oreno.properties
$ rake run
```

### 使い方 Docker 編

```sh
docker run -d \
  --name='kcl-datadog' \
  --env='STREAM_NAME=${Kinesis Stream Name}' \
  --env='REGION_NAME=${AWS Region}' \
  --env='AWS_ACCESS_KEY=${AWS ACCESS KEY} ' \
  --env='AWS_SECRET_KEY=${AWS SECRET ACCESS KEY}' \
  --env='DATADOG_API_KEY=${Datadog API Key}' \
inokappa/kcl-datadog
```

### 雑過ぎるので

- つっこみ等よろしくお願いします！
