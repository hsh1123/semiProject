package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
import dto.ForeCastWeatherDTO;

public class ForeCastWeatherDAO {


	private static ForeCastWeatherDAO dao = null;

	private ForeCastWeatherDAO() {
		DBConnection.initConnection();
	}

	public static ForeCastWeatherDAO getInstance() {
		if (dao == null) {
			dao = new ForeCastWeatherDAO();
		}
		return dao;
	}

	/*
	 * private int seq; private String locationCode; private Date accessDate;
	 * private Date accessHour; private Date accessMin; private String rain; private
	 * String humidity; private String temperature;
	 */
	public boolean addWeather(ForeCastWeatherDTO Fdto) {
		String sql1 = " SELECT * FROM FORECAST WHERE LOCATIONCODE=?" + " AND ACCESSDATE = ? " + " AND ACCESSHOUR = ?"
				+ " AND ACCESSMIN = ? ";

		String sql2 = " INSERT INTO FORECAST " + " VALUES(SEQ_FORECAST.NEXTVAL,?,?,?,?,?,?,?) ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);// 동시에 쿼리문을 넣기위해서 실행
			System.out.println("addWeather 1/6 성공");
			
			psmt = conn.prepareStatement(sql1);
			psmt.setString(1, Fdto.getLocationCode());
			psmt.setString(2, Fdto.getAccessDate());
			psmt.setString(3, Fdto.getAccessHour());
			psmt.setString(4, Fdto.getAccessMin());
			System.out.println("addWeather 2/6 성공");
			
			rs = psmt.executeQuery();

			System.out.println(sql1);
			System.out.println("addWeather 3/6 성공");
			psmt.clearParameters();

			System.out.println(rs);

			if(!rs.next()) {
				psmt = conn.prepareStatement(sql2);
				psmt.setString(1, Fdto.getLocationCode());
				psmt.setString(2, Fdto.getAccessDate());
				psmt.setString(3, Fdto.getAccessHour());
				psmt.setString(4, Fdto.getAccessMin());
				psmt.setString(5, Fdto.getRain().replace(" ", ""));
				psmt.setString(6, Fdto.getHumidity().replace(" ", ""));
				psmt.setString(7, Fdto.getTemperature().replace(" ", ""));
				System.out.println("addWeather 4/6 성공");

				count = psmt.executeUpdate();
				System.out.println("addWeather 5/6 성공");
				conn.commit();
				System.out.println("addWeather 6/6 성공");
			}
		} catch (SQLException e) {
			System.out.println("addWeather 실패");
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} //작업취소해야함! rollback 되돌려줌
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			DBClose.close(conn, psmt, rs);
		}

		return count > 0 ? true : false;
	}

}
