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

public class FreeBoardDAO {
	private static FreeBoardDAO dao = null;
	

	private FreeBoardDAO() {
		DBConnection.initConnection();
	}
	
	public static FreeBoardDAO getInstance() {
		if(dao==null) {
			dao = new FreeBoardDAO();
		}
		return dao;
	}

	/** 자유게시판 리스트 가져오기
	 * @param userID : 회원 아이디
	 * @param city : 시
	 * @param state : 구
	 * @param categoryCode : 카테고리
	 * @return
	 */
	
	
	//게시판 전체 리스트 가져오기 
	   public List<FreeBoardDTO> getFreeBoardList(String userID,String choice,String search) {
		   
		   System.out.println(userID);

		      String sql = " SELECT A.SEQ, A.USERID, A.TITLE, A.CONTENT,B.LOCATIONCODE, B.STATE, A.LASTUPDATE, A.READCOUNT, A.DEL, A.CATEGORYCODE "
		               + " FROM FREEBOARD A "
		               + " INNER JOIN WEATHERLOCATION B "
		               + " ON A.LOCATIONCODE = B.LOCATIONCODE WHERE A.DEL = 0";
		      			
		  	String sWord = "";
			if(choice.equals("title")) {
				sWord = " AND TITLE LIKE '%" + search  +"%' ";
			}else if(choice.equals("content")){
				sWord = " AND CONTENT LIKE '%" + search  +"%' ";
			}else if(choice.equals("category")) {
				sWord = " AND CATEGORYCODE LIKE '%" + search  +"%' ";
			}else if(choice.equals("writer")) {
				sWord = " AND USERID LIKE '%" + search  +"%' ";
			}
			
			sql = sql + sWord;  
		      
		      if(userID != null) {
		         sql += " AND A.USERID = ? ";
		      }
		      sql += " ORDER BY A.LASTUPDATE DESC ";
		         
		      
		      Connection conn = null;
		      PreparedStatement psmt = null;
		      ResultSet rs = null;
		         
		      List<FreeBoardDTO> list = new ArrayList<FreeBoardDTO>();
		      
		      
		      try {
		         conn = DBConnection.getConnection();
		         System.out.println("전체리스트, 1/4 getFreeboardList success");
		         
		         psmt = conn.prepareStatement(sql);

		         if(userID != null) {
		            psmt.setString(1, userID);
		         }
		         
		         System.out.println("전체리스트, 2/4 getFreeboardList success");
		         
		         rs = psmt.executeQuery();
		         System.out.println("전체리스트, 3/4 getFreeboardList success");
		         
		         while(rs.next()) {
		            
		            int n = 1; 
		            FreeBoardDTO dto = new FreeBoardDTO(rs.getInt(n++),
		                                          rs.getString(n++), 
		                                          rs.getString(n++), 
		                                          rs.getString(n++), 
		                                          rs.getString(n++),
		                                          rs.getString(n++), 
		                                          rs.getString(n++), 
		                                          rs.getInt(n++),
		                                          rs.getInt(n++),
		                                          rs.getString(n++));    
		            
		            list.add(dto);
		            
		         }
		         System.out.println("전체리스트, 4/4 getFreeboardList success");
		      } catch (SQLException e) {
		         System.out.println("전체리스트 getFreeboardList fail");
		         e.printStackTrace();
		      }finally {
		         DBClose.close(conn, psmt, rs);
		      }
		      
		      return list;   
		   }
	   
 public List<FreeBoardDTO> getFreeBoardList(String userID) {
		   
		   System.out.println(userID);

		      String sql = " SELECT A.SEQ, A.USERID, A.TITLE, A.CONTENT,B.LOCATIONCODE, B.STATE, A.LASTUPDATE, A.READCOUNT, A.DEL, A.CATEGORYCODE "
		               + " FROM FREEBOARD A "
		               + " INNER JOIN WEATHERLOCATION B "
		               + " ON A.LOCATIONCODE = B.LOCATIONCODE";
		      			
	
			      
		      if(userID != null) {
		         sql += " WHERE A.USERID = ? ";
		      }
		      sql += " ORDER BY A.LASTUPDATE DESC ";
		         
		      
		      Connection conn = null;
		      PreparedStatement psmt = null;
		      ResultSet rs = null;
		         
		      List<FreeBoardDTO> list = new ArrayList<FreeBoardDTO>();
		      
		      
		      try {
		         conn = DBConnection.getConnection();
		         System.out.println("전체리스트, 1/4 getFreeboardList success");
		         
		         psmt = conn.prepareStatement(sql);

		         if(userID != null) {
		            psmt.setString(1, userID);
		         }
		         
		         System.out.println("전체리스트, 2/4 getFreeboardList success");
		         
		         rs = psmt.executeQuery();
		         System.out.println("전체리스트, 3/4 getFreeboardList success");
		         
		         while(rs.next()) {
		            
		            int n = 1; 
		            FreeBoardDTO dto = new FreeBoardDTO(rs.getInt(n++),
		                                          rs.getString(n++), 
		                                          rs.getString(n++), 
		                                          rs.getString(n++), 
		                                          rs.getString(n++),
		                                          rs.getString(n++), 
		                                          rs.getString(n++), 
		                                          rs.getInt(n++),
		                                          rs.getInt(n++),
		                                          rs.getString(n++));    
		            
		            list.add(dto);
		            
		         }
		         System.out.println("전체리스트, 4/4 getFreeboardList success");
		      } catch (SQLException e) {
		         System.out.println("전체리스트 getFreeboardList fail");
		         e.printStackTrace();
		      }finally {
		         DBClose.close(conn, psmt, rs);
		      }
		      
		      return list;   
		   }
	
	/** 자유게시판 상세정보 가져오기
	 * @param seq : 글번호
	 * @return
	 */
	public FreeBoardDTO getFreeBoardDetail(int seq){
		
		String sql = " SELECT A.SEQ, A.USERID, A.TITLE, A.CONTENT, A.LOCATIONCODE, B.STATE, "
					+ " 		A.LASTUPDATE, A.READCOUNT, A.DEL, A.CATEGORYCODE "
					+ "	FROM FREEBOARD A "
					+ " INNER JOIN WEATHERLOCATION B"
					+ " ON A.LOCATIONCODE = B.LOCATIONCODE "
					+ " WHERE SEQ=? " ;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
	
		FreeBoardDTO dto = null;
		
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("1/3 getFreeBoardDetail success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 getFreeBoardDetail success");
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				int n = 1;
				dto = new FreeBoardDTO(rs.getInt(n++),
										rs.getString(n++),
										rs.getString(n++),
										rs.getString(n++),
                                        rs.getString(n++), 
										rs.getString(n++),
										rs.getString(n++),
										rs.getInt(n++),
										rs.getInt(n++),
										rs.getString(n++));
			}			
			System.out.println("3/3 getFreeBoardDetail success");
			
		} catch (SQLException e) {
			System.out.println("getFreeBoardDetail fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return dto;
	}

	/** 자유게시판 글 등록하기
	 * @param userID ㅣ 회원 아이디
	 * @param title : 글 제목
	 * @param content : 글 내용
	 * @param readCount : 조회수
	 * @param del
	 * @param categoryCode : 카테고리
	 */
	public boolean addFreeBoard(FreeBoardDTO dto){
				
		String sql = " INSERT INTO FREEBOARD(SEQ, USERID, TITLE, CONTENT, "
					+ " 					LOCATIONCODE, LASTUPDATE, READCOUNT, DEL, CATEGORYCODE) "
					+ " VALUES(SEQ_FREEBOARD.NEXTVAL, ?, ?, ?, ?, SYSDATE, 0, 0, ?) ";
				
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0 ;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addFreeBoard success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 addFreeBoard success");
			
			psmt.setString(1, dto.getUserID());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getLocationCode());
			psmt.setString(5, dto.getCategoryCode());
			
			count = psmt.executeUpdate();
			System.out.println("3/3 addFreeBoard success");
		} catch (SQLException e) {
			System.out.println("addFreeBoard fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0 ? true:false;
	}
	
	
	/** 자유게시판 글 수정하기
 * @param seq : 글번호
	 * @param userID ㅣ 회원 아이디
	 * @param title : 글 제목
	 * @param content : 글 내용
	 * @param locationcode : 지역코드
	 * @param lastUpdate : 등록/수정일
	 * @param readCount : 조회수
	 * @param del : 삭제 
	 * @param categoryCode : 카테고리
	 */
	 
	public boolean updateFreeBoard(int seq, FreeBoardDTO dto){
		
		String sql = " UPDATE FREEBOARD "
					+ " SET TITLE=?, CONTENT=?, LOCATIONCODE=?, LASTUPDATE=SYSDATE, CATEGORYCODE=? "
					+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null; 
		
		int count = 0 ;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 updateFreeBoard");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getLocationCode());
			psmt.setString(4, dto.getCategoryCode());
			psmt.setInt(5, seq);
			System.out.println("2/3 updateFreeBoard");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 updateFreeBoard");
		} catch (SQLException e) {
			System.out.println("uadateFreeBoard Fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0 ? true:false;
	}
	
	
	
	/** 자유게시판 글 삭제하기
	 * @param seq : 글번호
	 * @return
	 */
	public boolean deleteFreeBoard(int seq){

		String sql = " UPDATE FREEBOARD "
					+ " SET DEL=1 "
					+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0 ;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 deleteFreeBoard success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 deleteFreeBoard success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 deleteFreeBoard success");
		} catch (SQLException e) {
			System.out.println("deleteFreeBoard fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
	
		return count>0 ? true:false;	
		
	}
	
	
	
	/** 자유게시판 조회수 가져오기
	 * @param seq : 글번호
	 * @param userID ㅣ 회원 아이디
	 * @param title : 글 제목
	 * @param content : 글 내용
	 * @param locationcode : 지역코드
	 * @param lastUpdate : 등록/수정일
	 * @param readCount : 조회수
	 * @param del : 삭제 
	 * @param categoryCode : 카테고리
	 */
	public void readCount(int seq){
		
		String sql = " UPDATE FREEBOARD "
					+ " SET READCOUNT=READCOUNT+1 "
					+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/2 readcount success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/2 readcount success");
			
			psmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("readcount fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
		
	}
	
	
	/*
	 *  글 총수 구하기
	 */
	

	public int freeboardAllPages(String choice, String search, String locationCode) {
		String sql = " SELECT COUNT(*) "
				+ " FROM FREEBOARD WHERE DEL = 0";
				
		
		String sWord = "";
		if(choice.equals("title")) {
			sWord = " AND TITLE LIKE '%" + search  +"%' ";
		}else if(choice.equals("content")){
			sWord = " AND CONTENT LIKE '%" + search  +"%' ";
		}else if(choice.equals("category")) {
			sWord = " AND CATEGORYCODE LIKE '%" + search  +"%' ";
		}else if(choice.equals("writer")) {
			sWord = " AND USERID LIKE '%" + search  +"%' ";
		}else if(locationCode != null || !locationCode.equals("")) {
			sWord = " AND LOCATIONCODE LIKE '%" + locationCode  +"%' ";
		}
		
		
		sql = sql + sWord;     // where 조건절 sql문에 추가 
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int write = 0;   //글 갯수 
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 freeboardAllpages success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 freeboardAllpages success");
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				write= rs.getInt(1);
			System.out.println("3/3 freeboardAllpages success");
			}
		} catch (SQLException e) {
			System.out.println("freeboardAllpages fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		
			return write;
		
	}

	public int freeboardAllPagesAdmin(String choice, String search) {
		String sql = " SELECT COUNT(*) "
				+ " FROM FREEBOARD ";
				
		
		String sWord = "";
		if(choice.equals("USERID")) {
			sWord = " WHERE USERID LIKE '%" + search  +"%' ";
		}else if(choice.equals("TITLE")){
			sWord = " WHERE TITLE LIKE '%" + search  +"%' ";
		}else if(choice.equals("CATEGORYCODE")) {
			sWord = " WHERE CATEGORYCODE LIKE '%" + search  +"%' ";
		}
		
		sql = sql + sWord;     // where 조건절 sql문에 추가 
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int write = 0;   //글 갯수 
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 freeboardAllpages success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 freeboardAllpages success");
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				write= rs.getInt(1);
			System.out.println("3/3 freeboardAllpages success");
			}
		} catch (SQLException e) {
			System.out.println("freeboardAllpages fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		
			return write;
		
	}
	
	/** 페이징하기 
	 * @param seq : 글번호
	 * @param userID ㅣ 회원 아이디
	 * @param title : 글 제목
	 * @param content : 글 내용
	 * @param locationcode : 지역코드
	 * @param lastUpdate : 등록/수정일
	 * @param readCount : 조회수
	 * @param del : 삭제 
	 * @param categoryCode : 카테고리
	 */
	
	public List<FreeBoardDTO> freeboardPaging(String choice, String search, int pageNumber, String locationCode){
		
		//System.out.println(locationCode);
		
		String sql = " SELECT SEQ, USERID, TITLE, CONTENT, LOCATIONCODE,STATE, "
					+ " LASTUPDATE, READCOUNT, DEL, CATEGORYCODE "
					+ " FROM ";
		
		sql += " (SELECT ROW_NUMBER()OVER(ORDER BY A.LASTUPDATE DESC) AS RNUM, "
					+ " A.SEQ, A.USERID, A.TITLE, A.CONTENT, A.LOCATIONCODE,B.STATE, A.LASTUPDATE, A.READCOUNT, A.DEL, A.CATEGORYCODE "
					+ " FROM FREEBOARD A "
					+ " INNER JOIN WEATHERLOCATION B "
					+ " ON A.LOCATIONCODE = B.LOCATIONCODE "
					+ " WHERE A.LOCATIONCODE = ? AND A.DEL = 0 ";
	
		String sWord = "";
		if(choice.equals("title")) {
			sWord = " AND A.TITLE LIKE '%" + search + "%' ";
		}else if(choice.equals("content")) {
			sWord = " AND A.CONTENT LIKE '%" + search + "%' ";
		}else if(choice.equals("writer")) {
			sWord = " AND A.USERID= '" + search + "' ";
		}	
		sql += sWord;

		sql += " ORDER BY A.LASTUPDATE DESC ) ";
		sql += " WHERE RNUM >= ? AND RNUM <= ? ";
	
		
		int start, end;
		start = 1+ 10 * pageNumber;
		end = 10 + 10 * pageNumber;
	
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<FreeBoardDTO> list = new ArrayList<FreeBoardDTO>();
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 freeboardPaging success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, locationCode);
			psmt.setInt(2, start);
			psmt.setInt(3, end);
			System.out.println("2/4 freeboardPaging success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 freeboardPaging success");
			
			while(rs.next()) {
				FreeBoardDTO dto = new FreeBoardDTO(rs.getInt(1),
													rs.getString(2),
													rs.getString(3),
													rs.getString(4),
													rs.getString(5),
													rs.getString(6),
													rs.getString(7),
													rs.getInt(8),
													rs.getInt(9),
													rs.getString(10));
				
				list.add(dto);
			}
			System.out.println("4/4 freeboardPaging success");
			
		} catch (SQLException e) {
			System.out.println("freeboardPaging fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
			return list;
		
	}

	//게시판 전체 리스트 가져오기 
	   public List<FreeBoardDTO> adminGetFreeBoardList(String choice,String search, int pageNumber) {
		   
		   System.out.println(choice);
		   System.out.println(search);

			String sql = " SELECT SEQ, USERID, TITLE, CONTENT, LOCATIONCODE,STATE, "
						+ " LASTUPDATE, READCOUNT, DEL, CATEGORYCODE "
						+ " FROM ";
			
			sql += " (SELECT ROW_NUMBER()OVER(ORDER BY A.LASTUPDATE DESC) AS RNUM, "
						+ " A.SEQ, A.USERID, A.TITLE, A.CONTENT, A.LOCATIONCODE,B.STATE, A.LASTUPDATE, A.READCOUNT, A.DEL, A.CATEGORYCODE "
						+ " FROM FREEBOARD A "
						+ " INNER JOIN WEATHERLOCATION B "
						+ " ON A.LOCATIONCODE = B.LOCATIONCODE ";
	
		      			
		  	String sWord = "";
			if(choice.equals("title")) {
				sWord = " WHERE TITLE LIKE '%" + search  +"%' ";
			}else if(choice.equals("content")){
				sWord = " WHERE CONTENT LIKE '%" + search  +"%' ";
			}else if(choice.equals("category")) {
				sWord = " WHERE CATEGORYCODE LIKE '%" + search  +"%' ";
			}else if(choice.equals("USERID")) {
				sWord = " WHERE USERID LIKE '%" + search  +"%' ";
			}
			
			sql = sql + sWord;  

			sql += " ORDER BY A.LASTUPDATE DESC ) ";
			sql += " WHERE RNUM >= ? AND RNUM <= ? ";

			
			int start, end;
			start = 1+ 10 * pageNumber;
			end = 10 + 10 * pageNumber;
		      
		      Connection conn = null;
		      PreparedStatement psmt = null;
		      ResultSet rs = null;
		         
		      List<FreeBoardDTO> list = new ArrayList<FreeBoardDTO>();
		      
		      
		      try {
		         conn = DBConnection.getConnection();
		         System.out.println("전체리스트, 1/4 getFreeboardList success");
		         
		         psmt = conn.prepareStatement(sql);
					psmt.setInt(1, start);
					psmt.setInt(2, end);

		         
		         System.out.println("전체리스트, 2/4 getFreeboardList success");
		         
		         rs = psmt.executeQuery();
		         System.out.println("전체리스트, 3/4 getFreeboardList success");
		         
		         while(rs.next()) {
		            
		            int n = 1; 
		            FreeBoardDTO dto = new FreeBoardDTO(rs.getInt(n++),
		                                          rs.getString(n++), 
		                                          rs.getString(n++), 
		                                          rs.getString(n++), 
		                                          rs.getString(n++),
		                                          rs.getString(n++), 
		                                          rs.getString(n++), 
		                                          rs.getInt(n++),
		                                          rs.getInt(n++),
		                                          rs.getString(n++));    
		            
		            list.add(dto);
		            
		         }
		         System.out.println("전체리스트, 4/4 getFreeboardList success");
		      } catch (SQLException e) {
		         System.out.println("전체리스트 getFreeboardList fail");
		         e.printStackTrace();
		      }finally {
		         DBClose.close(conn, psmt, rs);
		      }
		      
		      return list;   
		   }
}
