前面两天：搭建了一下UI框，和一些细节的自定View
后面8天：获取新浪微博的数据，进行一个界面展示

要获取新浪微博的数据：

1.要在新浪微博的开放平台上注册成为新浪微博的开发者
    *只要一个微博帐号
    *登录到新浪微博的的开放平台：http://open.weibo.com
    *如果还没有成为开发者的话，登录到开放平台，填写相关信息

2.要在开放平台上注册一个应用：(得让新浪微博知道有我们这么一个应用的存在)
    *创建应用：进入到开放平台首页-->点击移动应用-->创建移动应用-->填写相关信息
    *应用信息-->基本信息：
        "App Key"：4036192405 -->代表某一个唯一的应用 -- Client_id
        "App Secret"：ec7a1f57bd720bebfa5335510afc5796 -->获取访问令牌(Access Token)
    *应用信息-->高级信息-->OAuth2.0 授权设置
        授权回调页(url地址): 用户在登录成功之后，有一个提示用户是否授权的界面，当用户点击允许授权之后，会回调这个地址，回调的时候会把'授权code'拼接在授权回调页后面
        取消授权回调页(url地址)：用户在点击取消授权(不同意授权)之后，会回调这个页面，我们可以根据这个页面做相应提示
    *应用信息-->测试帐号
        在应用的开发阶段，新浪不会允许较多的用户去登录这个正在处于开发中的应用，如果想要在开发阶段让别人能够登录的话，只把要别人的帐号添加成为测试帐号：

3.就要通过注册完应用拿到的一些参数去进行登录

    *服务器提供商 -->新浪微博
    *第三方App --> 我们自己
    *用户 -->


    *OAuth 2.0授权登录
    出现的场景：
        *要分享一张图片到新浪微博：
            *先保存到本地，然后打开微博应用，发送微博-->增加用户的操作成本
            *我们自己的APP（第三方App）能不能拿到用户的帐号与密码去登录新浪微博，帮助用户直接在我们的应用里面发送微博
    概念：
        *OAuth 2.0授权登录
            *是一个开放协议-->微信->QQ-->
            *第三方App->可以在用户授权的情况下，去访问用户存储在服务器提供商上面数据
            *可在第三方App不知道用户的帐号与密码的情况下，去进行登录授权
                *其实登录页面就是新浪微博提供
    授权步骤：
        *1.先打开新浪微博提供的登录页面
        *2.进入登录-->获取一个授权码（授权code，授权Token） "要用到授权回调页，填写的时候一定要与在开放平台上面填写的一要致"
            *授权码是怎么返回给我们？-- 通过授权回调页返回给我们
        *3.拿到授权code-->获取访问令牌(Access Token)
            *怎么去获取--新浪官方提供了通过授权code去获取Access Toke的这么一个接口

4.就可以获取新浪微博的数据
    *通过Access Token 去访问新浪微博数据接口(获取首页数据，获取用户的个人信息，发送微博)
    *限制：限制我们未上线的应用，每天可以获取某些接口多少次



5.OAuth 2.0
    首页->文档->移动API->OAuth 2.0授权接口
        请求的地址：https://api.weibo.com/oauth2/authorize
        请求参数：client_id	申请应用时分配的AppKey。 4036192405
                redirect_uri 授权回调地址  http://www.baidu.com/
            重定向：//同意授权后会重定向
            http://www.baidu.com/&code=CODE

