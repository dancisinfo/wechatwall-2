/**
 * 
 */
package com.wedding.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.wedding.wechat.WeChat;
import com.wedding.wechat.util.MySqlHelper;

/**
 * 
 * 
 * @author xuhan
 * 
 * @since 2014年7月21日 下午1:09:26
 */
public class WallServlet extends HttpServlet {

	private static final long serialVersionUID = 2852734733100553404L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			String sql;
			JSONObject result = new JSONObject();
			JSONArray resultJa = new JSONArray();
			WeChat wc = new WeChat();
			// 登录
			wc.login();

			if ("all".equals(req.getParameter("get"))) {
				sql = "select * from message_board order by msg_time desc limit 0,20";
				List<Object[]> l = MySqlHelper.ExecuteReader(sql, null);
				for (int i = 0; i < l.size(); i++) {
					Object[] obs = l.get(i);
					JSONObject jo = new JSONObject();
					jo.put("id", obs[0].toString());
					jo.put("fakeid", obs[1].toString());
					jo.put("type", obs[2].toString());
					jo.put("headimg", obs[3].toString());
					jo.put("nick_name", obs[4].toString());
					jo.put("content", obs[5].toString());
					jo.put("date_time", obs[6].toString());
					resultJa.add(jo);
				}
			} else {
				// 收取消息
				JSONArray ja = wc.getMessages();

				// 取当前数据库中的最新消息的时间做比照，大于他的部分写入数据库，并返回给前台
				sql = "select IFNULL(max(msg_time),0) from message_board";
				int latestMessage = Integer.valueOf(MySqlHelper.ExecuteScalar(
						sql, null).toString());

				sql = "insert into message_board values (?,?,?,?,?,?,?)";

				for (Object o : ja) {
					JSONObject msg = (JSONObject) o;
					if (Integer.valueOf(msg.getString("date_time")) > latestMessage) {
						Object[] params = new Object[7];
						params[0] = msg.getString("id");
						params[1] = msg.getString("fakeid");
						params[2] = msg.getString("type");
						params[3] = msg.getString("headimg");
						params[4] = msg.getString("nick_name");
						params[5] = msg.getString("content");
						params[6] = msg.getString("date_time");
						MySqlHelper.ExecuteNoneQuery(sql, params);
						resultJa.add(msg);
					} else {
						continue;
					}
				}
			}
			result.put("token", wc.getToken());
			result.put("messages", resultJa);
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter pw = resp.getWriter();
			pw.print(result.toJSONString());
			pw.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
