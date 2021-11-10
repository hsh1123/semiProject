package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.MemberDTO;
import dto.TodayWeatherDTO;

public class MemberDAO {
	private static MemberDAO dao = null;

	private MemberDAO() {

		DBConnection.initConnection();

	}

	public static MemberDAO getInstance() {
		if (dao == null) {
			dao = new MemberDAO();
		}
		return dao;
	}

	/**
	 * @param dto
	 * @param userID    : 회원 아이디
	 * @param userPW    : 회원 비밀번호
	 * @param userName  : 회원 닉네임
	 * @param email     : 이메일
	 * @param gradeCode : 등급
	 * @return
	 */
	public boolean addMember(MemberDTO dto) {

		String sql = " INSERT INTO WEATHERMEMBER(SEQ,USERID, USERPW, USERNAME, LOCATIONCODE, EMAIL, GRADECODE, DEL) "
				+ " VALUES(SEQ_WEATHERMEMBER.NEXTVAL,?, ?, ?, ?, ?, ?,?) ";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addMember success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getUserID());
			psmt.setString(2, dto.getUserPW());

			psmt.setString(3, dto.getUserName());
			psmt.setString(4, dto.getLocationCode());
			psmt.setString(5, dto.getEmail());
			psmt.setInt(6, dto.getGradeCode());
			psmt.setInt(7, dto.getDel());
			System.out.println("2/3 addMember success");

			count = psmt.executeUpdate();
			System.out.println("3/3 addMember success");

		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("addMember fail");
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count > 0 ? true : false;
	}

	public boolean getId(String id) {

		String sql = " SELECT USERID " + " FROM WEATHERMEMBER " + " WHERE USERID=? ";
		/*
		 * String sql = " SELECT COUNT(*) " + " FROM MEMBER " + " WHERE ID=? ";
		 */

		Connection conn = null; // DB 연결
		PreparedStatement psmt = null; // Query문을 실행
		ResultSet rs = null; // 결과 취득

		boolean findId = false;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getId success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/3 getId success");

			rs = psmt.executeQuery();
			if (rs.next()) {
				findId = true;
			}
			System.out.println("3/3 getId success");

		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("getId fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return findId;
	}

	/**
	 * @param dto
	 * @param userID    : 회원 아이디
	 * @param userPW    : 회원 비밀번호
	 * @param userName  : 회원 닉네임
	 * @param email     : 이메일
	 * @param gradeCode : 등급
	 * @return
	 */
	public boolean updateMember(MemberDTO dto) {
		String sql = " UPDATE WEATHERMEMBER SET USERPW=?, USERNAME=?,EMAIL=?,LOCATIONCODE = ? " + " WHERE USERID=? ";

		int count = 0;

		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 updateMember success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getUserPW());
			psmt.setString(2, dto.getUserName());
			psmt.setString(3, dto.getEmail());
			psmt.setString(4, dto.getLocationCode());
			psmt.setString(5, dto.getUserID());

			System.out.println("2/3 updateMember- success");

			count = psmt.executeUpdate();

			System.out.println("3/3 updateMember- success");
		} catch (SQLException e) {
			System.out.println("updateMember 실패");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count > 0 ? true : false;

	}

	/**
	 * 회원 삭제하기
	 * 
	 * @param userID : 회원 아이디
	 * @return
	 */
	public boolean deleteMember(String userID) {
		String sql = " DELETE FROM WEATHERMEMBER " + " WHERE userid in(?) ";

		Connection conn = null;
		PreparedStatement psmt = null;

		String[] arr = userID.split(",");
		int count[] = new int[arr.length];

		System.out.println("userID" + userID);

		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/3 deleteMember(1) success");

			psmt = conn.prepareStatement(sql);

			for (int i = 0; i < arr.length; i++) {
				psmt.setString(1, arr[i]);
				psmt.addBatch();
			}
			System.out.println("2/3 deleteMember(1 success");

			count = psmt.executeBatch();
			conn.commit();

			System.out.println("3/3 deleteMember(1 success");
		} catch (SQLException e) {

			System.out.println("deleteMember(1 fail");
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			// auto commit을 다시 켜둔다.
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			DBClose.close(conn, psmt, null);
		}

		boolean result = true;
		for (int i = 0; i < count.length; i++) {
			System.out.println(count[i]);
			if (count[i] != -2) {
				result = false;
				break;
			}
		}

		return result;
	}

	// 0624 00:30 편집
	// 0625 16:47 편집 SYK - GRADE 조인문 추가

	public MemberDTO login(MemberDTO dto) {

		/*
		 * String sql =
		 * " SELECT SEQ,USERID,USERPW,USERNAME, LOCATIONCODE, EMAIL, GRADECODE, DEL " +
		 * " FROM WEATHERMEMBER " + " WHERE USERID=? AND USERPW=? ";
		 */

		String sql = " SELECT M.SEQ,M.USERID,M.USERPW,M.USERNAME,M.EMAIL,G.GRADECODE,M.DEL, M.LOCATIONCODE "
				+ " FROM WEATHERMEMBER M " + "		INNER JOIN GRADE G " + "		ON M.GRADECODE=G.GRADECODE "
				+ " WHERE USERID=? AND USERPW=? "; // GRADE JOIN 추가

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		MemberDTO mem = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 log-in success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getUserID());
			psmt.setString(2, dto.getUserPW());
			System.out.println("2/3 log-in success");
			rs = psmt.executeQuery();
			if (rs.next()) {
				int seq = rs.getInt(1);
				String id = rs.getString(2);
				String pw = rs.getString(3);
				String name = rs.getString(4);
				String email = rs.getString(5);
				int gcode = rs.getInt(6);
				int del = rs.getInt(7);
				String locationCode = rs.getString(8);

				mem = new MemberDTO(id, pw, name, email, gcode, del, locationCode);
			}
			System.out.println("3/3 log-in success");
		} catch (SQLException e) {
			System.out.println("log-in 연결 실패");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return mem;
	}

	public boolean getEmailCheck(String email) {

		String sql = " SELECT EMAIL " + " FROM WEATHERMEMBER " + " WHERE EMAIL=? ";
		/*
		 * String sql = " SELECT COUNT(*) " + " FROM MEMBER " + " WHERE ID=? ";
		 */

		Connection conn = null; // DB 연결
		PreparedStatement psmt = null; // Query문을 실행
		ResultSet rs = null; // 결과 취득

		boolean findEmail = false;

		System.out.println(email);
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getEmailCheck success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			System.out.println("2/3 getEmailCheck success");

			rs = psmt.executeQuery();

			if (rs.next()) {
				findEmail = true;
			}
			System.out.println("3/3 getEmailCheck success");

		} catch (SQLException e) {
			System.out.println("getEmailCheck fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return findEmail;
	}

	public boolean deleteFreeBoard(String arrSeq) {

		String sql = " UPDATE FREEBOARD " + " SET DEL = 1 " + " WHERE SEQ IN(?) ";

		Connection conn = null;
		PreparedStatement psmt = null;

		String[] arr = arrSeq.split(",");
		int count[] = new int[arr.length];

		System.out.println("arrSeq" + arrSeq);

		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/3 deleteFreeBoard(1) success");

			psmt = conn.prepareStatement(sql);

			for (int i = 0; i < arr.length; i++) {
				psmt.setInt(1, Integer.parseInt(arr[i]));
				psmt.addBatch();
			}
			System.out.println("2/3 deleteFreeBoard(1 success");

			count = psmt.executeBatch();
			conn.commit();

			System.out.println("3/3 deleteFreeBoard(1 success");
		} catch (SQLException e) {

			System.out.println("deleteFreeBoard(1 fail");
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			// auto commit을 다시 켜둔다.
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			DBClose.close(conn, psmt, null);
		}

		boolean result = true;
		for (int i = 0; i < count.length; i++) {
			System.out.println(count[i]);
			if (count[i] != -2) {
				result = false;
				break;
			}
		}
		return result;

	}

	public boolean deleteTodayWeather(String arrSeq) {

		String sql = " UPDATE TODAYWEATHER " + " SET DEL = 1" + " WHERE SEQ IN(?) ";

		Connection conn = null;
		PreparedStatement psmt = null;

		String[] arr = arrSeq.split(",");
		int count[] = new int[arr.length];

		System.out.println("arrSeq" + arrSeq);

		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/3 deleteTodayWeather(1) success");

			psmt = conn.prepareStatement(sql);

			for (int i = 0; i < arr.length; i++) {
				psmt.setInt(1, Integer.parseInt(arr[i]));
				psmt.addBatch();
			}
			System.out.println("2/3 deleteTodayWeather(1 success");

			count = psmt.executeBatch();
			conn.commit();

			System.out.println("3/3 deleteTodayWeather(1 success");
		} catch (SQLException e) {

			System.out.println("deleteTodayWeather(1 fail");
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			// auto commit을 다시 켜둔다.
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			DBClose.close(conn, psmt, null);
		}

		boolean result = true;
		for (int i = 0; i < count.length; i++) {
			System.out.println(count[i]);
			if (count[i] != -2) {
				result = false;
				break;
			}
		}
		return result;

	}

	public boolean deleteQna(String arrSeq) {

		String sql = " UPDATE QNA " + " SET DEL = 1 " + " WHERE SEQ IN(?) ";

		Connection conn = null;
		PreparedStatement psmt = null;

		String[] arr = arrSeq.split(",");
		int count[] = new int[arr.length];

		System.out.println("arrSeq" + arrSeq);

		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/3 deleteQna(1) success");

			psmt = conn.prepareStatement(sql);

			for (int i = 0; i < arr.length; i++) {
				psmt.setInt(1, Integer.parseInt(arr[i]));
				psmt.addBatch();
			}
			System.out.println("2/3 deleteQna(1 success");

			count = psmt.executeBatch();
			conn.commit();

			System.out.println("3/3 deleteQna(1 success");
		} catch (SQLException e) {

			System.out.println("deleteQna(1 fail");
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			// auto commit을 다시 켜둔다.
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			DBClose.close(conn, psmt, null);
		}

		boolean result = true;
		for (int i = 0; i < count.length; i++) {
			System.out.println(count[i]);
			if (count[i] != -2) {
				result = false;
				break;
			}
		}
		return result;

	}

	public List<MemberDTO> getMemberlist(String choice, String search, int pageNumber) { // 회원 리스트 불러오기

		String sql = "SELECT * FROM " + " (SELECT ROW_NUMBER()OVER(ORDER BY USERID ASC) AS RNUM, "
				+ " w.UserID, w.UserPW, w.UserName,w.Email,w.GradeCode,g.GradeName,w.LocationCode,w.del "
				+ " FROM WEATHERMEMBER w, grade g " + " where w.gradecode = g.gradecode ";

		String sWord = "";
		if (choice.equals("userId")) {
			sWord = "AND userId LIKE '%" + search + "%' ";
		} else if (choice.equals("userName")) {
			sWord = "AND userName LIKE '%" + search + "%' ";
			// search가 title이나 content일 경우 포함된 내용을 찾아야하기떄문에 sql문에 %search%로 찾아야함
		} else if (choice.equals("gradeName")) {
			sWord = "AND gradeName LIKE '%" + search + "%' ";
			// writer는 id를 찾는거기때문에 id=search(넘어온입력값)으로 찾아줘야함
		}

		sql = sql + sWord;

		sql = sql + " ORDER BY USERID ASC) ";

		sql = sql + " WHERE RNUM >= ? AND RNUM <= ? ";

		int start, end;
		start = 1 + 10 * pageNumber; // 0 -> 1 ~ 10 1 -> 11 ~ 20
		end = 10 + 10 * pageNumber;

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<MemberDTO> list = new ArrayList<MemberDTO>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("getMemberlist 1/4 success!");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("getMemberlist 2/4 success!");

			rs = psmt.executeQuery();
			System.out.println("getMemberlist 3/4 success!");

			while (rs.next()) {
				MemberDTO dto = new MemberDTO(rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
						rs.getInt(6), rs.getString(7), rs.getString(8), rs.getInt(9));
				// 데이터가 돌면서 새롭게 dto생성

				list.add(dto);

			}
			System.out.println("getMemberlist 4/4 success!");
		} catch (SQLException e) {
			System.out.println("getMemberlist failed!");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return list;

	}

	public int getAllMember(String choice, String search) { // 총 회원 수 구하기

		String sql = " SELECT COUNT(*) FROM WEATHERMEMBER ";

		String sWord = "";
		if (choice.equals("userId") && !search.equals("")) {
			sWord = "WHERE userId= '%" + search + "%' ";
		} else if (choice.equals("userName") && !search.equals("")) {
			sWord = "WHERE userName= '%" + search + "%' ";
		} else if (choice.equals("gradeName") && !search.equals("")) {
			sWord = "WHERE gradeName='%" + search + "%' ";
		}

		sql = sql + sWord;

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int len = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getAllMember 성공");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getAllMember 성공");

			rs = psmt.executeQuery();
			if (rs.next()) {
				len = rs.getInt(1);
			}

			System.out.println("3/3 getAllMember 성공");

		} catch (SQLException e) {
			System.out.println("getAllMember 실패");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return len;
	}

	// 1-1. 게시판 목록 불러오기
	// Q. 원래 값처럼 파라미터를 String UserId, String LocationCode를 넣어주어야 하나요??
	public List<TodayWeatherDTO> getTodayWeatherList(String userID) { // 210625 11:26 작성

		String sql = " SELECT SEQ, USERID, TITLE, CONTENT, FILENAME, NEWFILENAME, "
				+ "		   LASTUPDATE, LIKECOUNT, LOCATIONCODE, DEL " + " FROM TODAYWEATHER " + " WHERE USERID = ?"; // UserName
																														// 삭제

		Connection conn = null; // DB 연결
		PreparedStatement psmt = null; // Query문을 실행
		ResultSet rs = null; // 결과 취득

		List<TodayWeatherDTO> list = new ArrayList<TodayWeatherDTO>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getWeatherDTOList success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getWeatherDTOList success");

			psmt.setString(1, userID);
			rs = psmt.executeQuery();
			System.out.println("3/4 getWeatherDTOList success");

			while (rs.next()) {
				int i = 1;
				TodayWeatherDTO dto = new TodayWeatherDTO(rs.getInt(i++), rs.getString(i++),
						// rs.getString(i++),
						rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getString(i++),
						rs.getInt(i++), rs.getString(i++), rs.getInt(i++));
				list.add(dto);
			}
			System.out.println("4/4 getWeatherDTOList success");

		} catch (SQLException e) {
			System.out.println("getWeatherDTOList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
	}

	public String findId(String name, String email) {

		String sql = " SELECT USERID " + " FROM WEATHERMEMBER " + " WHERE USERNAME=? AND EMAIL=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		String id = "";

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 findId success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, name);
			psmt.setString(2, email);
			System.out.println("2/3 findId success");
			rs = psmt.executeQuery();
			if (rs.next()) {
				id = rs.getString(1);
			}
			System.out.println("3/3 findId success");
		} catch (SQLException e) {
			System.out.println("findId fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return id;
	}

	public String findPw(String id, String email, String name) {

		String sql = " SELECT USERPW " + " FROM WEATHERMEMBER " + " WHERE USERID=? AND EMAIL=? AND USERNAME=? ";

		String pw = "";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, email);
			psmt.setString(3, name);
			rs = psmt.executeQuery();
			if (rs.next()) {
				pw = rs.getString(1);
			}
		} catch (SQLException e) {
			System.out.println("");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return pw;

	}
}
