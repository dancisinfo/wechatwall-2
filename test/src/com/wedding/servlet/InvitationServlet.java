/**
 * 
 */
package com.wedding.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wedding.wechat.util.MySqlHelper;

/**
 * 
 *
 * @author xuhan
 *
 * @since 2014年7月21日 下午1:13:51
 */
public class InvitationServlet extends HttpServlet {

	private static final long serialVersionUID = 3712210165752863419L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		PrintWriter pw = resp.getWriter();
		Boolean result = true;
		req.setCharacterEncoding("gbk");
		resp.setContentType("text/html; charset=gbk");
		try {
			String name = req.getParameter("guestName").trim();
			String remark = req.getParameter("remark");
			Integer attend = Integer.valueOf(req.getParameter("attendance"));
			String sql = "insert into `guest_list` (name,attend_flag,note) values (?,?,?)";
			Object[] parms = new Object[3];
			parms[0] = name;
			parms[1] = attend;
			parms[2] = remark;
			MySqlHelper.ExecuteNoneQuery(sql, parms);
		} catch (Exception ex) {
			ex.printStackTrace();
			result = false;
		}
		pw.print(result.toString());
		pw.flush();
		pw.close();
	}
}
