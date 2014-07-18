package com.wedding.wechat;

import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.httpclient.Cookie;
import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.URI;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSON;
import com.wedding.wechat.bean.BaseResponse;
import com.wedding.wechat.bean.LoginJson;

public class WeChat {
	private final static Log log = LogFactory.getLog(WeChat.class);
	public final static String HOST = "http://mp.weixin.qq.com";
	public final static String LOGIN_URL = "http://mp.weixin.qq.com/cgi-bin/login?lang=zh_CN";
	public final static String INDEX_URL = "https://mp.weixin.qq.com/cgi-bin/home?t=home/index&lang=zh_CN";
	public final static String FANS_URL = "http://mp.weixin.qq.com/cgi-bin/contactmanagepage?t=wxm-friend&lang=zh_CN&pagesize=10&pageidx=0&type=0&groupid=0";
	public final static String LOGOUT_URL = "http://mp.weixin.qq.com/cgi-bin/logout?t=wxm-logout&lang=zh_CN";
	public final static String DOWNLOAD_URL = "http://mp.weixin.qq.com/cgi-bin/downloadfile?";
	public final static String VERIFY_CODE = "http://mp.weixin.qq.com/cgi-bin/verifycode?";
	public final static String POST_MSG = "https://mp.weixin.qq.com/cgi-bin/masssend?t=ajax-response";
	public final static String VIEW_HEAD_IMG = "http://mp.weixin.qq.com/misc/getheadimg";
	public final static String GET_IMG_DATA = "http://mp.weixin.qq.com/cgi-bin/getimgdata";
	public final static String GET_REGIONS = "http://mp.weixin.qq.com/cgi-bin/getregions";
	public final static String GET_MESSAGE = "https://mp.weixin.qq.com/cgi-bin/message?t=message/list&count=20&day=7&lang=zh_CN";
	public final static String OPER_ADVANCED_FUNC = "http://mp.weixin.qq.com/cgi-bin/operadvancedfunc";
	public final static String MASSSEND_PAGE = "http://mp.weixin.qq.com/cgi-bin/masssendpage";
	public final static String FILE_MANAGE_PAGE = "http://mp.weixin.qq.com/cgi-bin/filemanagepage";
	public final static String OPERATE_APPMSG = "https://mp.weixin.qq.com/cgi-bin/operate_appmsg";
	public final static String FMS_TRANSPORT = "http://mp.weixin.qq.com/cgi-bin/fmstransport";
	public final static String CONTACT_MANAGE_PAGE = "http://mp.weixin.qq.com/cgi-bin/contactmanage";
	public final static String OPER_SELF_MENU = "http://mp.weixin.qq.com/cgi-bin/operselfmenu";
	public final static String REPLY_RULE_PAGE = "http://mp.weixin.qq.com/cgi-bin/replyrulepage";
	public final static String SINGLE_MSG_PAGE = "http://mp.weixin.qq.com/cgi-bin/singlemsgpage";
	public final static String USER_INFO_PAGE = "http://mp.weixin.qq.com/cgi-bin/userinfopage";
	public final static String DEV_APPLY = "http://mp.weixin.qq.com/cgi-bin/devapply";
	public final static String UPLOAD_MATERIAL = "https://mp.weixin.qq.com/cgi-bin/uploadmaterial?cgi=uploadmaterial&type=2&token=416919388&t=iframe-uploadfile&lang=zh_CN&formId=1";

	public final static String USER_AGENT_H = "User-Agent";
	public final static String REFERER_H = "Referer";
	public final static String USER_AGENT = "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22";
	public final static String UTF_8 = "UTF-8";

	private HttpClient client = new HttpClient();

	private Cookie[] cookies;
	private String cookiestr;

	private String token;
	private String loginErrMsg;

	private String loginUser;
	private String loginPwd;
	public boolean isLogin = false;

	public WeChat() throws ConfigurationException {
		Configuration config = new PropertiesConfiguration(
				"constants.properties");
		this.loginUser = config.getString("username");
		this.loginPwd = config.getString("password");
	}

	public WeChat(String user, String pwd) {
		this.loginUser = user;
		this.loginPwd = pwd;
	}

	public Cookie[] getCookies() {
		return cookies;
	}

	public void setCookies(Cookie[] cookies) {
		this.cookies = cookies;
	}

	public String getCookiestr() {
		return cookiestr;
	}

	public void setCookiestr(String cookiestr) {
		this.cookiestr = cookiestr;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getLoginErrMsg() {
		return loginErrMsg;
	}

	public void setLoginErrMsg(String loginErrMsg) {
		this.loginErrMsg = loginErrMsg;
	}

	public String getLoginUser() {
		return loginUser;
	}

	public void setLoginUser(String loginUser) {
		this.loginUser = loginUser;
	}

	public String getLoginPwd() {
		return loginPwd;
	}

	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}

	public boolean isLogin() {
		return isLogin;
	}

	public void setLogin(boolean isLogin) {
		this.isLogin = isLogin;
	}

	/**
	 * 登录,登录失败会重复请求登录
	 */
	public void login() {
		boolean bool = _login();
		while (!bool) {
			String info = "【登录失败】【错误代码：" + this.loginErrMsg + "】【账号："
					+ this.loginUser + "】正在尝试重新登录....";
			log.debug(info);
			System.out.println(info);
			bool = _login();
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				bool = _login();
			}
		}
		System.out.println("登陆成功：");
	}

	/**
	 * 发送登录信息,记录cookie，登录状态，token等信息
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	private boolean _login() {
		try {
			System.setProperty("jsse.enableSNIExtension", "false");
			PostMethod post = new PostMethod(LOGIN_URL);
			int status;
			do {
				Header locationHeader = post.getResponseHeader("location");
				String location = null;
				if (locationHeader != null) {
					location = locationHeader.getValue();
					post.releaseConnection();
					post.setURI(new URI(location));
				}
				post.setRequestHeader(USER_AGENT_H, USER_AGENT);
				NameValuePair[] params = new NameValuePair[] {
						new NameValuePair("username", this.loginUser),
						new NameValuePair("pwd",
								DigestUtils.md5Hex(this.loginPwd.getBytes())),
						new NameValuePair("f", "json"),
						new NameValuePair("imagecode", "") };
				post.setQueryString(params);
				post.setRequestHeader(REFERER_H, "https://mp.weixin.qq.com/");
				status = client.executeMethod(post);
			} while (status == HttpStatus.SC_MOVED_PERMANENTLY
					|| status == HttpStatus.SC_MOVED_TEMPORARILY);

			if (status == HttpStatus.SC_OK) {
				String ret = post.getResponseBodyAsString();
				LoginJson lj = JSON.parseObject(ret, LoginJson.class);
				BaseResponse retcode = JSON.parseObject(lj.getBase_resp(),
						BaseResponse.class);
				if (retcode.getRet() == 0) {
					this.cookies = client.getState().getCookies();
					StringBuffer cookie = new StringBuffer();
					for (Cookie c : client.getState().getCookies()) {
						cookie.append(c.getName()).append("=")
								.append(c.getValue()).append(";");
					}
					this.cookiestr = cookie.toString();
					this.isLogin = true;
					this.token = getToken(lj.getRedirect_url());
					return true;
				}
				int errCode = retcode.getRet();
				switch (errCode) {

				case -1:
					this.loginErrMsg = "系统错误";
					return false;
				case -2:
					this.loginErrMsg = "帐号或密码错误";
					return false;
				case -3:
					this.loginErrMsg = "密码错误";
					return false;
				case -4:
					this.loginErrMsg = "不存在该帐户";
					return false;
				case -5:
					this.loginErrMsg = "访问受限";
					return false;
				case -6:
					this.loginErrMsg = "需要输入验证码";
					return false;
				case -7:
					this.loginErrMsg = "此帐号已绑定私人微信号，不可用于公众平台登录";
					return false;
				case -8:
					this.loginErrMsg = "邮箱已存在";
					return false;
				case -32:
					this.loginErrMsg = "验证码输入错误";
					return false;
				case -200:
					this.loginErrMsg = "因频繁提交虚假资料，该帐号被拒绝登录";
					return false;
				case -94:
					this.loginErrMsg = "请使用邮箱登陆";
					return false;
				case 10:
					this.loginErrMsg = "该公众会议号已经过期，无法再登录使用";
					return false;
				case 65201:
				case 65202:
					this.loginErrMsg = "成功登陆，正在跳转...";
					return true;
				case 0:
					this.loginErrMsg = "成功登陆，正在跳转...";
					return true;
				default:
					this.loginErrMsg = "未知的返回";
					return false;
				}
			}
		} catch (Exception e) {
			String info = "【登录失败】【发生异常：" + e.getMessage() + "】";
			System.err.println(info);
			log.debug(info);
			log.info(info);
			return false;
		}
		return false;
	}

	/**
	 * 从登录成功的信息中分离出token信息
	 * 
	 * @param s
	 * @return
	 */
	private String getToken(String s) {
		try {
			if (StringUtils.isBlank(s))
				return null;
			String[] ss = StringUtils.split(s, "?");
			String[] params = null;
			if (ss.length == 2) {
				if (!StringUtils.isBlank(ss[1]))
					params = StringUtils.split(ss[1], "&");
			} else if (ss.length == 1) {
				if (!StringUtils.isBlank(ss[0]) && ss[0].indexOf("&") != -1)
					params = StringUtils.split(ss[0], "&");
			} else {
				return null;
			}
			for (String param : params) {
				if (StringUtils.isBlank(param))
					continue;
				String[] p = StringUtils.split(param, "=");
				if (null != p && p.length == 2
						&& StringUtils.equalsIgnoreCase(p[0], "token"))
					return p[1];

			}
		} catch (Exception e) {
			String info = "【解析Token失败】【发生异常：" + e.getMessage() + "】";
			System.err.println(info);
			log.debug(info);
			log.info(info);
			return null;
		}
		return null;
	}

	/**
	 * 获取首页
	 * 
	 * @throws org.apache.commons.httpclient.HttpException
	 * 
	 * @throws java.io.IOException
	 */
	public void index() throws HttpException, IOException {
		GetMethod get = new GetMethod(INDEX_URL);
		get.setRequestHeader(USER_AGENT_H, USER_AGENT);
		get.setRequestHeader("Cookie", this.cookiestr);
		int status = client.executeMethod(get);
		if (status == HttpStatus.SC_OK) {
			System.out.println(get.getResponseBodyAsString());
		}
	}

	/**
	 * 登出操作
	 * 
	 * @throws org.apache.commons.httpclient.HttpException
	 * 
	 * @throws java.io.IOException
	 */
	public void logout() throws HttpException, IOException {
		GetMethod get = new GetMethod(LOGOUT_URL);
		get.setRequestHeader(USER_AGENT_H, USER_AGENT);
		get.setRequestHeader("Cookie", this.cookiestr);
		int status = client.executeMethod(get);
		if (status == HttpStatus.SC_OK) {
			System.err.println("-----------注销登录成功-----------");
		}
	}

	/**
	 * 获取验证码
	 * 
	 * @throws org.apache.commons.httpclient.HttpException
	 * 
	 * @throws java.io.IOException
	 */
	public InputStream code() throws HttpException, IOException {
		GetMethod get = new GetMethod(VERIFY_CODE);
		get.setRequestHeader(USER_AGENT_H, USER_AGENT);
		get.setRequestHeader("Cookie", this.cookiestr);
		NameValuePair[] params = new NameValuePair[] {
				new NameValuePair("username", this.loginUser),
				new NameValuePair("r", "1365318662649") };
		get.setQueryString(params);
		int status = client.executeMethod(get);
		if (status == HttpStatus.SC_OK) {
			return get.getResponseBodyAsStream();
		}
		return null;
	}

	/**
	 * 页面跳转
	 * 
	 * @param url
	 */

	public void redirect(String url) {
		if (url.indexOf("https://") == -1)
			url = HOST + url;
		try {
			if (this.isLogin) {
				GetMethod get = new GetMethod(url);
				get.setRequestHeader(USER_AGENT_H, USER_AGENT);
				get.setRequestHeader(REFERER_H, INDEX_URL);
				get.setRequestHeader("Cookie", this.cookiestr);
				int status = client.executeMethod(get);
				if (status == HttpStatus.SC_OK) {
					System.err.println("正在跳转.....");
					System.out.println(get.getResponseBodyAsString());
				}
			}
		} catch (Exception e) {
		}
	}

	public String getMessages() {
		String ret = "";
		try {
			if (this.isLogin) {
				String url = GET_MESSAGE + "&token=" + this.token;
				GetMethod get = new GetMethod(url);
				get.setRequestHeader(USER_AGENT_H, USER_AGENT);
				get.setRequestHeader(REFERER_H, INDEX_URL);
				get.setRequestHeader("Cookie", this.cookiestr);
				int status = client.executeMethod(get);
				if (status == HttpStatus.SC_OK) {
					ret = get.getResponseBodyAsString();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
}
