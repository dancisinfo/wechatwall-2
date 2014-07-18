package com.wedding.wechat.bean;

/**
 * 登录返回信息Json对象
 *
 * @author Kone
 */
public class LoginJson {
    public int Ret;
    public String ErrMsg;
    public int ShowVerifyCode;
    public int ErrCode;
    public String base_resp;
    public String redirect_url;

    public String getRedirect_url() {
		return redirect_url;
	}

	public void setRedirect_url(String redirect_url) {
		this.redirect_url = redirect_url;
	}

	public String getBase_resp() {
		return base_resp;
	}

	public void setBase_resp(String base_resp) {
		this.base_resp = base_resp;
	}

	public int getRet() {
        return Ret;
    }

    public void setRet(int ret) {
        Ret = ret;
    }

    public String getErrMsg() {
        return ErrMsg;
    }

    public void setErrMsg(String ErrMsg) {
        this.ErrMsg = ErrMsg;
    }

    public int getShowVerifyCode() {
        return ShowVerifyCode;
    }

    public void setShowVerifyCode(int showVerifyCode) {
        ShowVerifyCode = showVerifyCode;
    }

    public int getErrCode() {
        return ErrCode;
    }

    public void setErrCode(int errCode) {
        ErrCode = errCode;
    }

}
