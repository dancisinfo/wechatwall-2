/**
 * 
 */
package com.wedding.wechat;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.wedding.wechat.util.MySqlHelper;

/**
 * 微信墙类
 *
 * @author xuhan
 *
 * @since 2014年7月18日 上午11:29:51
 */
public class MessageBoard {

	/**
	 * 根据返回的消息页面解析出消息json数组
	 * 
	 * @param ret
	 * @return
	 */

	public JSONArray getMessagesJSON(String ret, String token) {
		String json = ret.substring(ret.indexOf("list : (") + 8,
				ret.indexOf(").msg_item,"));
		JSONObject jo = JSONObject.parseObject(json);
		JSONArray ja = jo.getJSONArray("msg_item");
		for (Object o : ja) {
			JSONObject msg = (JSONObject) o;
			msg.put("headimg", WeChat.VIEW_HEAD_IMG + "?token=" + token
					+ "&fakeid=" + msg.getString("fakeid"));
			if (msg.getIntValue("type") == 2) {
				msg.put("content", WeChat.GET_IMG_DATA + "?token=" + token
						+ "&msgid=" + msg.getString("id")
						+ "&mode=large&source=&fileId=0&ow=");
			}
		}
		return ja;
	}

	/**
	 * 入口
	 * 
	 * @param args
	 * @throws ConfigurationException
	 */
	public static void main(String[] args) throws ConfigurationException {
		Configuration config = new PropertiesConfiguration(
				"com/wedding/wechat/constants.properties");
		WeChat wechat = new WeChat(config.getString("username"),
				config.getString("password"));
		wechat.login();
		String ret = wechat.getMessages();
		MessageBoard mb = new MessageBoard();
		JSONArray ja = mb.getMessagesJSON(ret, wechat.getToken());
		for (Object o : ja) {
			JSONObject msg = (JSONObject) o;

			// TODO 写进数据库
			String sql = "insert into message_board values (?,?,?,?,?,?,?)";
			Object[] parms = new Object[7];
			parms[0] = msg.getString("id");
			parms[1] = msg.getString("fakeid");
			parms[2] = msg.getString("type");
			parms[3] = msg.getString("headimg");
			parms[4] = msg.getString("nick_name");
			parms[5] = msg.getString("content");
			parms[6] = msg.getString("date_time");
			MySqlHelper.ExecuteNoneQuery(sql, parms);
		}
	}
}
