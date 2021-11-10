package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.QnADTO;

public class QnADAO {
	private static QnADAO dao = null;
	

	private QnADAO() {
		DBConnection.initConnection();
		
	}
	
	public static QnADAO getInstance() {
		if(dao==null) {
			dao = new QnADAO();
		}
		return dao;
	}
	
	  public boolean qnaWrite(QnADTO dto) {
		  
		  String sql = " INSERT INTO QNA(SEQ,USERID,TITLE,CONTENT,EMAIL,WDATE,REF,STEP,DEL,READCOUNT)"
				  		+ " VALUES(SEQ_QNA.NEXTVAL,?,?,?,?,SYSDATE,(SELECT NVL(MAX(REF), 0)+1 FROM QNA),0,0,0) ";
		  
		  
		  Connection conn= null;
		  PreparedStatement psmt = null;
		  int count = 0;
		  
		  
		  try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 qnaWrite success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getUserID());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getEmail());
			System.out.println("2/3 qnaWrite success");
			count = psmt.executeUpdate();
			System.out.println("3/3 qnaWrite success");
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
		  return count>0?true:false;
	  }

	/** QnA 리스트 가져오기
	 * @param userID : 회원 아이디
	 * @return
	 */
	  public List<QnADTO> getQnAList(String choice,String search,int pageNumber,String searchM){
			
			String sql = " SELECT SEQ,USERID,TITLE,CONTENT,EMAIL,WDATE,REF,STEP,DEL,READCOUNT "
					+ " FROM ";
			
			sql+= " (SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, "
					+ " SEQ,USERID,TITLE,CONTENT,EMAIL,WDATE,REF,STEP,DEL,READCOUNT "
					+ " FROM QNA ";
			
			String sword="";
			
			if(choice.equals("title")) {
				sword = " WHERE TITLE LIKE '%"+search+"%' ";
			}else if(choice.equals("content")) {
				sword = " WHERE CONTENT LIKE '%"+search+"%' ";
			}else if(choice.equals("writer")) {
				sword = " WHERE USERID = '"+search+"' ";
			}else {
				sword = " WHERE TITLE LIKE '%"+searchM+"%'";
			}
			
			sql= sql+sword;
			
			sql = sql + " ORDER BY REF DESC, STEP ASC) ";
			
			sql = sql + " WHERE RNUM >= ? AND RNUM <= ? ";
			
			int start,end;
			start = 1 + 10 * pageNumber;
			end = 10 + 10 * pageNumber;
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			List<QnADTO> list = new ArrayList<QnADTO>();
			
			
			try {
				conn = DBConnection.getConnection();
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, start);
				psmt.setInt(2, end);
				rs = psmt.executeQuery();
				while(rs.next()) {
					QnADTO dto = new QnADTO(rs.getInt(1),
											rs.getString(2),
											rs.getString(3),
											rs.getString(4),
											rs.getString(5),
											rs.getString(6),
											rs.getInt(7),
											rs.getInt(8),
											rs.getInt(9),
											rs.getInt(10));
				list.add(dto);
				}
			} catch (SQLException e) {
				System.out.println("getQnaList fail");
				e.printStackTrace();
			}finally {
				DBClose.close(conn, psmt, rs);
			}
			return list;	
		}

	  public List<QnADTO> getQnAList2(String choice,String search,int pageNumber){
			
			String sql = " SELECT SEQ,USERID,TITLE,CONTENT,EMAIL,WDATE,REF,STEP,DEL,READCOUNT "
					+ " FROM ";
			
			sql+= " (SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, "
					+ " SEQ,USERID,TITLE,CONTENT,EMAIL,WDATE,REF,STEP,DEL,READCOUNT "
					+ " FROM QNA ";
			
			String sword="";
			
			if(choice.equals("userId")) {
				sword = " WHERE USERID LIKE '%"+search+"%' ";
			}else if(choice.equals("Title")) {
				sword = " WHERE TITLE LIKE '%"+search+"%' ";
			}

			sql= sql+sword;
			
			sql = sql + " ORDER BY REF DESC, STEP ASC) ";
			
			sql = sql + " WHERE RNUM >= ? AND RNUM <= ? ";
			
			int start,end;
			start = 1 + 10 * pageNumber;
			end = 10 + 10 * pageNumber;
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			List<QnADTO> list = new ArrayList<QnADTO>();
			
			
			try {
				conn = DBConnection.getConnection();
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, start);
				psmt.setInt(2, end);
				rs = psmt.executeQuery();
				while(rs.next()) {
					QnADTO dto = new QnADTO(rs.getInt(1),
											rs.getString(2),
											rs.getString(3),
											rs.getString(4),
											rs.getString(5),
											rs.getString(6),
											rs.getInt(7),
											rs.getInt(8),
											rs.getInt(9),
											rs.getInt(10));
				list.add(dto);
				}
			} catch (SQLException e) {
				System.out.println("getQnaList fail");
				e.printStackTrace();
			}finally {
				DBClose.close(conn, psmt, rs);
			}
			return list;	
		}

	/** QnA 상세정보 가져오기
	 * @param seq
	 * @return
	 */
	public QnADTO getQna(int seq)
	{
		String sql = " SELECT SEQ,USERID,TITLE,CONTENT,EMAIL,WDATE,REF,STEP,DEL,READCOUNT"
				+ " FROM QNA "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		QnADTO dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getQnaDetail success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getQnaDetail success");
			psmt.setInt(1, seq);
			rs = psmt.executeQuery();
			if(rs.next()) {
						dto = new QnADTO(rs.getInt(1),
										rs.getString(2),
										rs.getString(3),
										rs.getString(4),
										rs.getString(5),
										rs.getString(6),
										rs.getInt(7),
										rs.getInt(8),
										rs.getInt(9),
										rs.getInt(10));
			}
			System.out.println("3/3 getQnaDetail success");
		} catch (SQLException e) {
			System.out.println("getQnaDetail Fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		return dto;
		
	}
	
	public boolean qnaUpdate(String title,String content,int seq) {
		
		String sql = " UPDATE QNA SET TITLE=? , CONTENT=? WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
	
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 qnaUpdate success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 qnaUpdate success");
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, seq);
			count = psmt.executeUpdate();
			System.out.println("3/3 qnaUpdate success");
			
		} catch (SQLException e) {
			System.out.println("qnaUpdate Fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
	}
	
	public boolean qnaDelete(int seq) {
		String sql = " DELETE FROM QNA WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 qnaDelete success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 qnaDelete success");
			count = psmt.executeUpdate();
			System.out.println("3/3 qnaDelete success");
		} catch (SQLException e) {
			System.out.println("qnaDelete fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
		
	}
	public boolean qnaAnswer(int seq,QnADTO dto) {
		//update
		String sql = " UPDATE QNA "
				+ " SET STEP=STEP+1 "
				+ " WHERE REF = (SELECT REF FROM QNA WHERE SEQ=? ) "
				+ " AND STEP > (SELECT STEP FROM QNA WHERE SEQ=? ) ";
		//insert
		String sql2 = " INSERT INTO QNA(SEQ,USERID,TITLE,CONTENT,EMAIL,WDATE,REF,STEP,DEL,READCOUNT) "
				+ " 	VALUES(SEQ_QNA.NEXTVAL, ?,?,?,?,SYSDATE, "
				+ "					(SELECT REF FROM QNA WHERE SEQ=?), "
				+ "					(SELECT STEP FROM QNA WHERE SEQ=?) + 1, "
				+ "					 0, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count =0;
		
		
		try {
			
			conn= DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 answer success");
			//update
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			System.out.println("2/6 answer success");
			count = psmt.executeUpdate();
			System.out.println("3/6 answer success");
			//insert
			psmt.clearParameters(); // psmt 초기화
			psmt = conn.prepareStatement(sql2);
			psmt.setString(1, dto.getUserID());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getEmail());
			psmt.setInt(5, seq);
			psmt.setInt(6, seq);
			System.out.println("4/6 answer success");
			count = psmt.executeUpdate();
			System.out.println("5/6 answer success");
			conn.commit();
			System.out.println("6/6 answer success");
			
		} catch (SQLException e) {
			System.out.println("answer fail");			
			try {
				conn.rollback();
			} catch (SQLException e1) {				
				e1.printStackTrace();
			}			
			e.printStackTrace();
		}finally {			
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBClose.close(conn, psmt, null);			
		}
		
		return count>0?true:false;
	}
	
	
	public int getAllPage(String choice, String search,String searchM) {
		
		String sql=" SELECT COUNT(*) FROM QNA ";
		
		String sword ="";
		if(choice.equals("title")) {
			sword= " WHERE TITLE LIKE '%"+ search + "%' "; 
		}else if(choice.equals("content")) {
			sword= " WHERE CONTENT LIKE '%"+ search + "%' ";
		}else if(choice.equals("writer")) {
			sword = " WHERE USERID='"+search+"' ";
		}else {
			sword= " WHERE TITLE LIKE '%"+ searchM + "%' ";
		}
		
		sql = sql+sword;
		
		int len =0;
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getAllPage success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getAllPage success");
			rs = psmt.executeQuery();
			if(rs.next()) {
				len =rs.getInt(1);
			}
			System.out.println("3/3 getAllPage success");
		} catch (SQLException e) {
			System.out.println("getAllPage fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		return len;
		
	}

	public int getAllPageSearch(String choice, String search) {
		
		String sql=" SELECT COUNT(*) FROM QNA ";
		
		String sword ="";
		if(choice.equals("userId")) {
			sword= " WHERE USERID LIKE '%"+ search + "%' "; 
		}else if(choice.equals("Title")) {
			sword= " WHERE TITLE LIKE '%"+ search + "%' ";
		}

		
		sql += sword;
		
		int len =0;
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getAllPage success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getAllPage success");
			rs = psmt.executeQuery();
			if(rs.next()) {
				len =rs.getInt(1);
			}
			System.out.println("3/3 getAllPage success");
		} catch (SQLException e) {
			System.out.println("getAllPage fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		return len;
		
	}
	public int getAllPage(String choice, String search) {
		
		String sql=" SELECT COUNT(*) FROM QNA ";
		
		String sword ="";
		if(choice.equals("title")) {
			sword= " WHERE TITLE LIKE '%"+ search + "%' "; 
		}else if(choice.equals("content")) {
			sword= " WHERE CONTENT LIKE '%"+ search + "%' ";
		}else if(choice.equals("writer")) {
			sword = " WHERE USERID='"+search+"' ";
		}
		
		sql = sql+sword;
		
		int len =0;
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getAllPage success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getAllPage success");
			rs = psmt.executeQuery();
			if(rs.next()) {
				len =rs.getInt(1);
			}
			System.out.println("3/3 getAllPage success");
		} catch (SQLException e) {
			System.out.println("getAllPage fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		return len;
		
	}
	
	
	/** QnA 메일 보내기
	 * @param dto
	 * @return
	 */
	public boolean sendMail(QnADTO dto)
	{
		int count = 0 ;
		
		return count>0 ? true:false;
	}
}
