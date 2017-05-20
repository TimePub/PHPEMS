2013-08-30（1.1测试版）更改功能：
1、增加CMS模块
2、默认引导页面为CMS主页
3、增加后台批量删除试题功能
4、增加用户中心基本功能（不支持UCENTER同步更改密码）

2013-08-01（1.01beta）更改功能：
增加功能：
UCenter支持（目前仅支持用户同步登陆和退出，暂不支持积分兑换等）

修复bug
1、后台科目编辑页面模板缺失
2、后台编辑地区模板缺失
3、用户后台课程开通和取消时的bug。
4、题型修改模板缺失。
5、题冒题添加bug。


安装步骤：
1、将pe.sql用phpmyadmin导入数据库
2、在lib/config.inc.php文件中设置数据库参数，注意都要保存为utf8无bom形式（bom问题可能导致后台验证码不出现，修改方法请看：http://phpems.net/bbs/?thread-index-fid-2-tid-23.htm）
3、设置data目录、files/attach目录为可读写（777权限）
4、以上3步完成后即可完成安装。

前台地址：
域名/index.php
后台地址：
域名/index.php?core-master

默认管理员：
用户名：peadmin
密码：peadmin

ucenter用户整合请参看论坛帖子：
http://phpems.net/bbs/?thread-index-fid-1-tid-26.htm

