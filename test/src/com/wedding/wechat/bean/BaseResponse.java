/**
 * 
 */
package com.wedding.wechat.bean;

/**
 * 
 *
 * @author xuhan
 *
 * @since 2014年7月18日 上午10:08:31
 */
public class BaseResponse {
	public String err_msg;
	public int ret;

	public String getErr_msg() {
		return err_msg;
	}

	public void setErr_msg(String err_msg) {
		this.err_msg = err_msg;
	}

	public int getRet() {
		return ret;
	}

	public void setRet(int ret) {
		this.ret = ret;
	}
}
