## oreno-kcl

### ����ȂɁH 

- [Kinesis Client Library for Ruby](https://github.com/awslabs/amazon-kinesis-client-ruby) ���g�����G�ȃA�v���P�[�V����
- VPC Flow Logs => CloudWatch Logs Subscriptions �ɂ���� Kinesis �X�g���[���ɕۑ�����Ă���f�[�^�iREJECT ���ꂽ���O�j�� Datadog Event �ɑ��M����
- http://inokara.hateblo.jp/entry/2015/09/04/170750

�ȉ��A�C���[�W�B

![](http://cdn-ak.f.st-hatena.com/images/fotolife/i/inokara/20150904/20150904170914.png)

### �K�v�ȏ��

- AWS access key
- AWS secret access key
- Datadog API Key
- Kinesis �̃X�g���[����
- �X�g���[�������݂��� AWS ���[�W������

### �g����

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

### �g���� Docker ��

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

### �G�߂���̂�

- �����ݓ���낵�����肢���܂��I
