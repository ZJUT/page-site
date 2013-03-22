
## Feel 直播调试环境

徐栋在我这边 Ubuntu 12.04 上搭的环境, 我做一些记录m
Feel 电台会用到这方面的技术, 前段开发需要这个环境:

#### 安装

Ubuntu 有 `crtmpserver` 这个包, 但配置不同, 采用下载的包
这里下载了 32 位系统对应的包, 解压打开即可
http://www.rtmpd.com/downloads/
对应 `fwplayer` 有 `run_flvplayback.sh` 这个脚本直接可以跑
解压后修改 `configs/flvplayback.lua` 中的配置, 添加:
```lua
{
ip="0.0.0.0",
port=10000,
protocol="inboundUdpTs"
}
```
因为这里用到的是 UDP, 需要额外开启
然后运行 `./run_flvplayback.sh`, 会打印 log 加一张表格:
```
+-----------------------------------------------------------------------------+
|                                                                     Services|
+---+---------------+-----+-------------------------+-------------------------+
| c |      ip       | port|   protocol stack name   |     application name    |
+---+---------------+-----+-------------------------+-------------------------+
|tcp|        0.0.0.0| 1935|              inboundRtmp|              flvplayback|
+---+---------------+-----+-------------------------+-------------------------+
|tcp|        0.0.0.0| 6666|           inboundLiveFlv|              flvplayback|
+---+---------------+-----+-------------------------+-------------------------+
|tcp|        0.0.0.0| 9999|             inboundTcpTs|              flvplayback|
+---+---------------+-----+-------------------------+-------------------------+
|udp|        0.0.0.0|10000|             inboundUdpTs|              flvplayback|
+---+---------------+-----+-------------------------+-------------------------+
```
表明 UDP 端口已经开启,,,

### 视频流

开发环境打算用 `ffmpeg` 模拟音频流
创建了这样一个运行脚本:

```bash
ffmpeg -i "/home/chen/dl/web_components_-_introduction_1280x800.mp4" -re -b 500000 -s 320x180 -strict experimental -g 25 -me_method zero -acodec aac -ab 96000 -ar 48000 -ac 2 -vbsf h264_mp4toannexb -f mpegts udp://127.0.0.1:10000?pkt_size=1316
```

配置来自 Wiki, 其中的部分参数直接删去了, 有报错但能运行:
http://wiki.rtmpd.com/tutorial_live_stream_file

运行脚本后 `crtmpserver` 打印一些数据, 注意 `ts_2_LfDP` 是后边用到的
```
/thelib/src/application/baseclientapplication.cpp:257 Stream INTS(1) with name `ts_2_LfDP` registered to application `flvplayback` from protocol ITS(2)

```

### 播放器

播放器上现成的网页是可以链接到这个服务器的
http://www.longtailvideo.com/jw-player/wizard/#rtmp
修改其中的网址为 `rtmp://localhost/flvplayback/ts_2_LfDP`
注意中间的字符串与上边对应
然后选中其他的内容, 播放器就开始播放 MP4 文件的声音了

调试时候应该只会需要声音的, 所以, 暂时先这样了
