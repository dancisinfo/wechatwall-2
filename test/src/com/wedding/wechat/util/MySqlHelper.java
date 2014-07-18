/**
 * 
 */
package com.wedding.wechat.util;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * <strong>mysql数据库操作帮助类</strong>
 * <p>
 * 包装了mysql常用的操作方法。类似于SqlHelper在java中的实现。
 * </p>
 * 
 * @author birdshover
 */
public abstract class MySqlHelper {

	private static final String url = "jdbc:mysql://192.168.15.108:3306/test1?useUnicode=true&characterEncoding=gbk";
	private static final String driver = "com.mysql.jdbc.Driver";
	private static final String name = "root";
	private static final String pwd = "rk";

	public MySqlHelper() {
	}

	// 获取连接connection
	private static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, name, pwd);
		} catch (SQLException | ClassNotFoundException e) {
			throw new RuntimeException("获取con错误");
		}
		return con;
	}

	private static void closeConnection(Connection con, PreparedStatement ps,
			ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				throw new RuntimeException(e.getMessage());
			} finally {
				if (ps != null) {
					try {
						ps.close();
					} catch (SQLException e) {
						throw new RuntimeException(e.getMessage());
					} finally {
						if (con != null) {
							try {
								con.close();
							} catch (SQLException e) {
								throw new RuntimeException(e.getMessage());
							}
						}
					}
				}
			}
		}
	}

	/**
	 * 无结果查询，适用于更新和插入
	 * 
	 * @param SQL语句
	 * @param 语句带的参数
	 * @return 操作影响行数
	 * 
	 * @example Object[] parms = new Object[2];<br/>
	 *          parms[0] = "标题"; <br/>
	 *          parms[1] = "内容";<br/>
	 *          int val = mysqlhelper.ExecuteNoneQuery(
	 *          "insert into Documents(Title,Content) values (?,?)", parms);
	 */
	public static int ExecuteNoneQuery(String cmdtext, Object[] parms) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(cmdtext);
			prepareCommand(pstmt, parms);
			return pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			closeConnection(conn, pstmt, null);
		}
		return 0;
	}

	/**
	 * 返回查询结果集
	 * 
	 * @param SQL语句
	 * @param 附带参数
	 * @return 返回结果，用ArrayList包装Object数组
	 * 
	 * @example ArrayList list =
	 *          mysqlhelper.ExecuteReader("Select * from Documents",null); <br/>
	 *          for(int i = 0;i&lt;list.size();i++) { <br/>
	 *          &nbsp;&nbsp;Object[] obs = (Object[])list.get(i); <br/>
	 *          &nbsp;&nbsp;for(int j = 0;j&lt;obs.length;j++) { <br/>
	 *          &nbsp;&nbsp;&nbsp;&nbsp;out.print(obs[j].toString()); <br/>
	 *          &nbsp;&nbsp;} <br/>
	 *          &nbsp;&nbsp;out.print("&lt;br/&gt;"); <br/>
	 *          } <br/>
	 * 
	 */
	public static ArrayList<Object[]> ExecuteReader(String cmdtext,
			Object[] parms) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(cmdtext);

			prepareCommand(pstmt, parms);
			rs = pstmt.executeQuery();

			ArrayList<Object[]> al = new ArrayList<Object[]>();
			ResultSetMetaData rsmd = rs.getMetaData();
			int column = rsmd.getColumnCount();

			while (rs.next()) {
				Object[] ob = new Object[column];
				for (int i = 1; i <= column; i++) {
					ob[i - 1] = rs.getObject(i);
				}
				al.add(ob);
			}
			return al;

		} catch (Exception ex) {
		} finally {
			closeConnection(conn, pstmt, rs);
		}
		return null;
	}

	/**
	 * 返回第1行第1列数据，一般用来查询count值
	 * 
	 * @param SQL语句
	 * @param 带参数
	 * @return 值
	 */
	public static Object ExecuteScalar(String cmdtext, Object[] parms) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(cmdtext);
			prepareCommand(pstmt, parms);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getObject(1);
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConnection(conn, pstmt, rs);
		}
		return null;
	}

	private static void prepareCommand(PreparedStatement pstmt, Object[] parms)
			throws SQLException, UnsupportedEncodingException {
		if (parms != null && parms.length > 0) {
			for (int i = 1; i < parms.length + 1; i++) {
				Object item = parms[i - 1];
				if (item == null) {
					item = "";
				}
				String typeName = item.getClass().getSimpleName();
				if (typeName.equals("String")) {
					pstmt.setString(i, item.toString());
				} else if (typeName.equals("Integer")) {
					pstmt.setInt(i, Integer.parseInt(item.toString()));
				} else if (typeName.equals("Date")) {
					pstmt.setDate(i, Date.valueOf(item.toString()));
				} else {
					pstmt.setObject(i, item);
				}
			}
		}
	}
}