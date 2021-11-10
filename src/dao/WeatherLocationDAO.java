package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.FreeBoardDTO;
import dto.WeatherLocationDTO;

/**
 * @author SYKANG
 *
 */
public class WeatherLocationDAO {
	private static WeatherLocationDAO dao = null;

	private WeatherLocationDAO() {
		DBConnection.initConnection();
	}

	public static WeatherLocationDAO getInstance() {
		if (dao == null) {
			dao = new WeatherLocationDAO();
		}
		return dao;
	}

	/**
	 * 테스트용 메소드
	 * 
	 * @return
	 */
	public WeatherLocationDTO getState(String locationCode) { //test용 method

		String sql = " SELECT * FROM WEATHERLOCATION WHERE LOCATIONCODE=?";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		WeatherLocationDTO dto = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4getLocationList 성공 ");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, locationCode);
			System.out.println("2/4getLocationList 성공 ");
			rs = psmt.executeQuery();
			System.out.println("3/4getLocationList 성공 ");
			if (rs.next()) {
				dto = new WeatherLocationDTO(rs.getString(1), rs.getString(2), rs.getString(3));

			}
			System.out.println("4/4getLocationList 성공 ");

		} catch (SQLException e) {
			System.out.println("getLocationList 실패 ");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return dto;

	}

	/**
	 * State 리스트 가져오기
	 * 
	 * @param state : 구
	 * @return
	 */
	public List<WeatherLocationDTO> getStateList() {

		String sql = " SELECT * FROM WEATHERLOCATION ORDER BY STATE ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<WeatherLocationDTO> list = new ArrayList<WeatherLocationDTO>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4getLocationList 성공 ");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4getLocationList 성공 ");
			rs = psmt.executeQuery();
			System.out.println("3/4getLocationList 성공 ");
			while (rs.next()) {
				WeatherLocationDTO dto = new WeatherLocationDTO(rs.getString(1), rs.getString(2), rs.getString(3));

				list.add(dto);

			}
			System.out.println("4/4getLocationList 성공 ");

		} catch (SQLException e) {
			System.out.println("getLocationList 실패 ");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return list;
	}

}
