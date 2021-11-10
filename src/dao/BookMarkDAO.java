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

public class BookMarkDAO {
	
	private static BookMarkDAO dao = null;
	

	private BookMarkDAO() {
		DBConnection.initConnection();
	}
	
	public static BookMarkDAO getInstance() {
		if(dao==null) {
			dao = new BookMarkDAO();
		}
		return dao;
	}

	// 북마크 리스트 가져오기
	public List<BookMarkDTO> getBookMarkList(String userID) {
		
		System.out.println(userID);
		
		String sql = " SELECT B.SEQ, w.state,f.rain, f.humidity, f.temperature "
					+ " FROM forecast f, WEATHERLOCATION w, BOOKMARK B"
					+ " WHERE f.locationcode = w.locationcode "
					+ " AND W.LOCATIONCODE = B.LOCATIONCODE " 
					+ " AND f.SEQ IN ("
					+ " 	select  Max(f.seq)"
					+ " 	from forecast f, bookmark b, WEATHERLOCATION w "
					+ "		where f.locationcode = b.locationcode "
					+ "		and b.locationcode = w.locationcode "
					+ "		and b.userid = ?"
					+ "		group by w.state )";
	

		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		System.out.println("getBookMarkList********************");
				    

		List<BookMarkDTO> list = new ArrayList<BookMarkDTO>();
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBookMarkList success ");
			
			
			psmt = conn.prepareStatement(sql);
	        psmt.setString(1, userID);			
			
			System.out.println("2/4 getBookMarkList ");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getBookMarkList success ");
			
			while(rs.next()) {
				BookMarkDTO dto = new BookMarkDTO( 
											rs.getInt(1),
						  					rs.getString(2),
											  rs.getString(3), 
											  rs.getString(4), 
											  rs.getString(5));
				
				list.add(dto);				
	
			}
			System.out.println("4/4 getBookMarkList success ");
					
		} catch (SQLException e) {
			System.out.println(e);
			System.out.println(" getBookMarkList fail ");
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return list;	
	}
	
	/** 북마크 등록하기
	 * @param userID: 회원 아이디
	 * @param locationCode 
	
	 * @return
	 */
	public boolean BookMarkAdd(String UserID, String locationCode) {
		
		String sql = " INSERT INTO BOOKMARK(SEQ, USERID, LOCATIONCODE ) "
				   + "VALUES (SEQ_BOOKMARK.NEXTVAL, ?, ? )" ;
				 
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0 ;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addBookMark success ");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, UserID);
		
			psmt.setString(2, locationCode);
			System.out.println("2/3 addBookMark success ");
			
			count =psmt.executeUpdate();
			System.out.println("3/3 addBookMark success ");
			
		} catch (SQLException e) {
			System.out.println("addBookMark fail ");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		
		return count>0 ? true:false;
		
	}

	/** 북마크 삭제하기
	 * @param userID: 회원 아이디
	 * @param seq : 글번호
	 * @return
	 */
	public boolean BookMarkDel(int seq)
	{
		
		String sql = " DELETE FROM BOOKMARK "
	               + " WHERE SEQ =? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0 ;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 BookMarkDel success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 BookMarkDel success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 BookMarkDel success");
		} catch (SQLException e) {
			System.out.println("deleteFreeBoard fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
	
		
		return count>0 ? true:false;
		
	}
	
	// 북마크 리스트 가져오기
	public List<BookMarkDTO> getdelBookMarkList(String userID) {
		
		System.out.println(userID);
		
		String sql = " SELECT * FROM BOOKMARK where userid=? ";
	

		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

				    

		List<BookMarkDTO> list = new ArrayList<BookMarkDTO>();
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getdelBookMarkList success ");
			
			
			psmt = conn.prepareStatement(sql);
	        psmt.setString(1, userID);			
			
			System.out.println("2/4 getdelBookMarkList ");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getdelBookMarkList success ");
			
			while(rs.next()) {
				BookMarkDTO dto = new BookMarkDTO(rs.getInt(1), rs.getString(2)
						, rs.getString(3));
				
				list.add(dto);				
	
			}
			System.out.println("4/4 getdelBookMarkList success ");
					
		} catch (SQLException e) {
			System.out.println(e);
			System.out.println(" getBookMarkList fail ");
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return list;	
	}
}