package dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.CommentsDTO;

/**
 * @author kun
 *
 */
public class CommentsDAO implements Serializable{
	private static CommentsDAO dao = null;
	
	private CommentsDAO() {
		DBConnection.initConnection();
	}
	
	public static CommentsDAO getInstance() {
		if(dao==null) {
			dao = new CommentsDAO();
		}
		return dao;
	}
	
	/*
	 * @param int commentNum : 코멘트 넘버 
	 * @param String UserID : 회원 아이디
	 * @param String commentContent : 코멘트 내용 
	 * @param String commentDate : 코멘트 등록 날짜 
	 * @param int Seq : 본글의 seq
	 * @param int commentdel : 삭제
	 */
	//TODO: 코멘트 전체 리스트 가져오기
	
	public List<CommentsDTO> getCommentsList(int seq){
		
		//System.out.println("getCommentsList seq :" + seq); 
		
		String sql = " SELECT COMMENT_NUMBER, USERID, COMMENT_CONTENT, COMMENT_DATE, SEQ, COMMENTDEL "
					+ " FROM COMMENTS "
					+ " WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CommentsDTO> list = new ArrayList<CommentsDTO>();
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getCommentsList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/4 getCommentsList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getCommentsList success");
			
			while(rs.next()) {
				CommentsDTO dto = new CommentsDTO(rs.getInt(1),
										rs.getString(2),
										rs.getString(3),
										rs.getString(4),
										rs.getInt(5),
										rs.getInt(6));
				
				list.add(dto);
			}
			System.out.println("4/4 getCommentsList success");
			
		} catch (SQLException e) {
			System.out.println("getCommentsList fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
				
		return list;
		
	}
	
	/*
	 * @param int commentNum : 코멘트 넘버 
	 * @param String UserID : 회원 아이디
	 * @param String commentContent : 코멘트 내용 
	 * @param String commentDate : 코멘트 등록 날짜 
	 * @param int Seq : 본글의 seq
	 * @param int commentdel : 삭제
	 */
	//TODO : 코멘트 등록하기
	
	public boolean addComment(int seq, CommentsDTO dto) {
		
	//	System.out.println("addCOMMENT:" + seq + " " + dto);
		
		String sql = " INSERT INTO COMMENTS(COMMENT_NUMBER, USERID, COMMENT_CONTENT, "
					+ " 			COMMENT_DATE, SEQ, COMMENTDEL) "
					+ " VALUES (COMMENTS_SEQ.NEXTVAL, ?, ?, SYSDATE, ?, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addComment success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 addComment success");
			
		
			psmt.setString(1, dto.getUserID());
			psmt.setString(2, dto.getCommentContent());
			psmt.setInt(3, seq);
		
			count = psmt.executeUpdate();
			System.out.println("3/3 addComment success");
			
		} catch (SQLException e) {
			System.out.println("addComment fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
	}
	
	//TODO: 코멘트 삭제
	/*
	 * @param int commentNum : 코멘트 넘버 
	 * @param String UserID : 회원 아이디
	 * @param String commentContent : 코멘트 내용 
	 * @param String commentDate : 코멘트 등록 날짜 
	 * @param int Seq : 본글의 seq
	 * @param int commentdel : 삭제
	 */
	
	public boolean deleteComment(int commentNum) {
		String sql = " UPDATE COMMENTS "
					+ " SET COMMENTDEL=1 "
					+ " WHERE COMMENT_NUMBER=? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0 ;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 deleteComment success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, commentNum);
			System.out.println("2/3 deleteComment success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 deleteFreeBoard success");
			
		} catch (SQLException e) {
			System.out.println("deleteComment fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
	
		return count>0 ? true:false;	
		
	}
	
}
