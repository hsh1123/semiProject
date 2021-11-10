package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.BookMarkDTO;
import dto.GradeDTO;

public class GradeDAO {
	private static GradeDAO dao = null;

	private GradeDAO() {
		DBConnection.initConnection();
	}

	public static GradeDAO getInstance() {
		if (dao == null) {
			dao = new GradeDAO();
		}
		return dao;
	}
	
	public int getGradeCode(String userid)
	{
		int grade = 1;
		
		String sql = "SELECT GRADECODE FROM WEATHERMEMBER "
					+ " WHERE USERID =?";
				

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getGradeCode success ");
			
			
			psmt = conn.prepareStatement(sql);
	        psmt.setString(1, userid);			
			
			System.out.println("2/4 getGradeCode ");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getGradeCode success ");
			
			if(rs.next()) {
				grade = rs.getInt(1);
	
			}
			
			System.out.println("4/4 getGradeCode success ");
					
		} catch (SQLException e) {
			System.out.println(e);
			System.out.println(" getGradeCode fail ");
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return grade;	
		
	}
	
	
	

	public boolean updatePoint(String userid) { // 하나의 글을 쓸 때 포인트 5점을 적립함.
		String sql = "  INSERT INTO MEMBERPOINT VALUES(SEQ_MEMBERPOINT.NEXTVAL,?,5) ";

		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count =0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("updatePoint 1/3 성공");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, userid);
			System.out.println("updatePoint 2/3 성공");
			count = psmt.executeUpdate();
			System.out.println("updatePoint 3/3 성공");
		} catch (SQLException e) {
			System.out.println("updatePoint 실패");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
			
		}
		return count>0?true:false;
	}
	
	public boolean setGradeCode(String userid){
		String sql= " UPDATE WEATHERMEMBER "
				+ " SET GRADECODE =   "
				+ "	(SELECT GRADECODE "
				+ "    FROM GRADE "
				+ "    WHERE (STARTPOINT <= (SELECT SUM(POINT) FROM MEMBERPOINT	"
				+ "    		    WHERE USERID = ?) "
				+ "    AND ENDPOINT >= (SELECT SUM(POINT) FROM MEMBERPOINT	"
				+ "    		    WHERE USERID = ?)						"	
				+ "    ) "
				+ " ) "
				+ " WHERE USERID = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count =0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("setGradeName 1/3 성공");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, userid);
			psmt.setString(2, userid);
			psmt.setString(3, userid);
			
			System.out.println("setGradeName 2/3 성공");
			count = psmt.executeUpdate();
			System.out.println("setGradeName 3/3 성공");
		} catch (SQLException e) {
			System.out.println("setGradeName 실패");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
			
		}
		return count>0?true:false;
	}
		
		
	

}
