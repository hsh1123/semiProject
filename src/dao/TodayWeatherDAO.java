package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import db.DBClose;
import db.DBConnection;
import dto.TodayWeatherDTO;

/**
 * @author SYKANG
 *
 */
/**
 * @author 82102 0. getInstance 1. getTodayWeatherList 게시판 목록 - 이미지 카드가 즉시 뜨도록
 *         수정해야함 2. addTodayWeather
 */
public class TodayWeatherDAO {
	private static TodayWeatherDAO dao = new TodayWeatherDAO();

	private TodayWeatherDAO() {
		DBConnection.initConnection();

	}

	public static TodayWeatherDAO getInstance() {
		return dao;
	}

	// 1-1. 게시판 목록 불러오기
	// Q. 원래 값처럼 파라미터를 String UserId, String LocationCode를 넣어주어야 하나요??
	public List<TodayWeatherDTO> getTodayWeatherList() { // 210625 11:26 작성

		String sql = " SELECT SEQ, USERID, TITLE, CONTENT, FILENAME, NEWFILENAME, "
				+ "		   LASTUPDATE, LIKECOUNT, LOCATIONCODE, DEL " + " FROM TODAYWEATHER "; // UserName 삭제

		Connection conn = null; // DB 연결
		PreparedStatement psmt = null; // Query문을 실행
		ResultSet rs = null; // 결과 취득

		List<TodayWeatherDTO> list = new ArrayList<TodayWeatherDTO>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getWeatherDTOList success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getWeatherDTOList success");

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

	// 1-2. 글의 총수
	public int getAllTodayWeather(/* 지역코드 셀렉트 한 것만 추출해볼까 함 */) {

		String sql = " SELECT COUNT(*) FROM TODAYWEATHER ";

		/*
		 * 지역코드 맞는것만 검색하게 하는 sql 구문 작성할 것 String sWord = "";
		 * if(choice.equals("selectLoc")) { sWord = " WHERE LOCATIONCODE LIKE '%" +
		 * LocationCode + "%' "; } sql = sql + sWord;
		 */

		Connection conn = null; // DB 연결
		PreparedStatement psmt = null; // Query문을 실행
		ResultSet rs = null; // 결과 취득

		int len = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getAllTodayWeather success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getAllTodayWeather success");

			rs = psmt.executeQuery();
			if (rs.next()) {
				len = rs.getInt(1);
			}
			System.out.println("3/3 getAllTodayWeather success");

		} catch (SQLException e) {
			System.out.println("getAllTodayWeather fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return len;
	}

	// 1-3. 게시판 페이징
	public List<TodayWeatherDTO> getTodayWeatherPagingList(int pageNumber/* 지역코드 셀렉트 한 것만 추출해볼까 함 */) {

		String sql = " SELECT SEQ, USERID, TITLE, CONTENT, FILENAME, NEWFILENAME, " // UserName 삭제
				+ "		 LASTUPDATE, LIKECOUNT, LOCATIONCODE, DEL " + " FROM ";

		// 1. number설정
		sql += " (SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, "
				+ "		SEQ, USERID, TITLE, CONTENT, FILENAME, NEWFILENAME, "
				+ "		LASTUPDATE, LIKECOUNT, LOCATIONCODE, DEL " + "	FROM TODAYWEATHER " + "     WHERE DEL=0";

		/*
		 * 지역코드 맞는것만 검색하게 하는 sql 구문 작성할 것 String sWord = "";
		 * if(WriteLocation.equals("LocationCode")) { sWord = " WHERE TITLE LIKE '%" +
		 * 지역코드 + "%' "; } sql = sql + sWord;
		 */

		sql += " ORDER BY SEQ DESC) ";
		sql += " WHERE RNUM >= ? AND RNUM <= ? ";
		// sql += " AND DEL=0 ";

		int start, end;
		start = 1 + 15 * pageNumber; // 0 -> 1 ~ 15 1 -> 16 ~ 20
		end = 15 + 15 * pageNumber;

		Connection conn = null; // DB 연결
		PreparedStatement psmt = null; // Query문을 실행
		ResultSet rs = null; // 결과 취득

		List<TodayWeatherDTO> list = new ArrayList<TodayWeatherDTO>();
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getTodayWeatherPagingList success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/4 getTodayWeatherPagingList success");

			rs = psmt.executeQuery();
			System.out.println("3/4 getTodayWeatherPagingList success");

			while (rs.next()) {
				int i = 1;
				TodayWeatherDTO dto = new TodayWeatherDTO(rs.getInt(i++), rs.getString(i++),
						// rs.getString(i++),
						rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getString(i++),
						rs.getInt(i++), rs.getString(i++), rs.getInt(i++));
				list.add(dto);
			}
			System.out.println("4/4 getTodayWeatherPagingList success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getTodayWeatherPagingList fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return list;
	}

	public int getAllTodayWeatherSearch(String choice,String search) {

		String sql = " SELECT COUNT(*) FROM TODAYWEATHER ";

		String sWord = "";
		if(choice.equals("userId")) {
			sWord = " WHERE USERID LIKE '%" + search + "%' ";
		}else if(choice.equals("TITLE")) {
			sWord = " WHERE TITLE LIKE '%" + search + "%' ";
		}
		
		sql += sWord;
		/*
		 * 지역코드 맞는것만 검색하게 하는 sql 구문 작성할 것 String sWord = "";
		 * if(choice.equals("selectLoc")) { sWord = " WHERE LOCATIONCODE LIKE '%" +
		 * LocationCode + "%' "; } sql = sql + sWord;
		 */

		Connection conn = null; // DB 연결
		PreparedStatement psmt = null; // Query문을 실행
		ResultSet rs = null; // 결과 취득

		int len = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getAllTodayWeather success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getAllTodayWeather success");

			rs = psmt.executeQuery();
			if (rs.next()) {
				len = rs.getInt(1);
			}
			System.out.println("3/3 getAllTodayWeather success");

		} catch (SQLException e) {
			System.out.println("getAllTodayWeather fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return len;
	}

	// 1-3. 게시판 페이징
	public List<TodayWeatherDTO> getTodayWeatherPagingListSearch(int pageNumber,String choice,String search) {

		String sql = " SELECT SEQ, USERID, TITLE, CONTENT, FILENAME, NEWFILENAME, " // UserName 삭제
				+ "		 LASTUPDATE, LIKECOUNT, LOCATIONCODE, DEL " + " FROM ";

		// 1. number설정
		sql += " (SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, "
				+ "		SEQ, USERID, TITLE, CONTENT, FILENAME, NEWFILENAME, "
				+ "		LASTUPDATE, LIKECOUNT, LOCATIONCODE, DEL " + "	FROM TODAYWEATHER ";

		String sWord = "";
		if(choice.equals("userId")) {
			sWord = " WHERE USERID LIKE '%" + search + "%' ";
		}else if(choice.equals("TITLE")) {
			sWord = " WHERE TITLE LIKE '%" + search + "%' ";
		}
		
		sql += sWord;

		sql += " ORDER BY SEQ DESC) ";
		sql += " WHERE RNUM >= ? AND RNUM <= ? ";
//	sql += " AND DEL=0 ";
		
		System.out.println(sql);

		int start, end;
		start = 1 + 15 * pageNumber; // 0 -> 1 ~ 15 1 -> 16 ~ 20
		end = 15 + 15 * pageNumber;

		Connection conn = null; // DB 연결
		PreparedStatement psmt = null; // Query문을 실행
		ResultSet rs = null; // 결과 취득

		List<TodayWeatherDTO> list = new ArrayList<TodayWeatherDTO>();
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getTodayWeatherPagingListSearch success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/4 getTodayWeatherPagingListSearch success");

			rs = psmt.executeQuery();
			System.out.println("3/4 getTodayWeatherPagingListSearch success");

			while (rs.next()) {
				int i = 1;
				TodayWeatherDTO dto = new TodayWeatherDTO(rs.getInt(i++), rs.getString(i++),
						// rs.getString(i++),
						rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getString(i++),
						rs.getInt(i++), rs.getString(i++), rs.getInt(i++));
				list.add(dto);
			}
			System.out.println("4/4 getTodayWeatherPagingListSearch success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getTodayWeatherPagingListSearch fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return list;
	}
	// 1-4. 글내용

	public TodayWeatherDTO getTodayWeather(int seq) {

		String sql = " SELECT SEQ, USERID, TITLE, CONTENT, "
				+ "			  FILENAME, NEWFILENAME, LASTUPDATE, LIKECOUNT, LOCATIONCODE, DEL "
				+ "	   FROM TODAYWEATHER " + "    WHERE SEQ=? "; // UserName삭제

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		TodayWeatherDTO dto = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getTodayWeather success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 getTodayWeather success");

			rs = psmt.executeQuery();
			if (rs.next()) {
				int i = 1;
				dto = new TodayWeatherDTO(rs.getInt(i++), rs.getString(i++),
						// rs.getString(i++),
						rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getString(i++),
						rs.getInt(i++), rs.getString(i++), rs.getInt(i++));
			}
			System.out.println("3/3 getTodayWeather success");

		} catch (SQLException e) {
			System.out.println("getTodayWeather fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return dto;
	}

	// 2. 작성
	/**
	 * 오늘의 날씨 추가하기
	 * 
	 * @param userID        : 유저 아이디
	 * @param title         : 제목
	 * @param content       : 한줄 코멘트
	 * @param FileName      : 업로드 이미지의 원 파일명
	 * @param newFileName   : 업로드 이미지의 변환 파일명
	 * @param locationCode: 사진 위치
	 * @return : true(성공), false(실패)
	 */
	public boolean addTodayWeather(TodayWeatherDTO dto) {
		System.out.println(dto.toString());

		String sql = " INSERT INTO TODAYWEATHER(SEQ, USERID, TITLE, CONTENT, FILENAME, NEWFILENAME, "
				+ "                      LASTUPDATE, LIKECOUNT, LOCATIONCODE, DEL) "
				+ " VALUES(SEQ_TODAYWEATHER.NEXTVAL, ?, ?, ?, ?, ?, SYSDATE, 0, ?, 0) "; // username삭제

		Connection conn = null; // DB 연결
		PreparedStatement psmt = null; // Query문을 실행

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addTodayWeather success");

			psmt = conn.prepareStatement(sql);

			psmt.setString(1, dto.getUserID());
			// psmt.setString(2, dto.getUserName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getFileName());
			psmt.setString(5, dto.getNewFileName());
			psmt.setString(6, dto.getLocationCode()); // 이렇게만 구성하는거 맞나??

			System.out.println("2/3 addTodayWeather success");

			count = psmt.executeUpdate();
			System.out.println("3/3 addTodayWeather success");

		} catch (SQLException e) {
			System.out.println("addTodayWeather fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count > 0 ? true : false;
	}

	/**
	 * 오늘의 날씨 삭제하기
	 * 
	 * @param userID : 유저 아이디
	 * @param seq    :글 번호
	 * @return : true(성공), false(실패)
	 */

	// 3. 수정

	public boolean updateTodayWeather(int Seq, String Title, String Content) {
		String sql = " UPDATE TODAYWEATHER SET " + " TITLE=?, CONTENT=? " + " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S updateTodayWeather");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, Title);
			psmt.setString(2, Content);
			psmt.setInt(3, Seq);

			System.out.println("2/3 S updateTodayWeather");

			count = psmt.executeUpdate();
			System.out.println("3/3 S updateTodayWeather");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count > 0 ? true : false;
	}

	// 4. 삭제
	// Q. 원래 값처럼 파라미터를 String userID, int seq를 넣어주어야 하나요??
	public boolean deleteTodayWeather(int seq) {

		String sql = " UPDATE TODAYWEATHER " + " SET DEL=1 " + " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S deleteTodayWeather");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 S deleteTodayWeather");

			count = psmt.executeUpdate();
			System.out.println("3/3 S deleteTodayWeather");

		} catch (Exception e) {
			System.out.println("fail deleteTodayWeather");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		/* seq--; */
		return count > 0 ? true : false;

	}

	public boolean LikeCountUp(int seq) {
		String sql = " UPDATE TODAYWEATHER " + " SET LIKECOUNT=LIKECOUNT+1 " + " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S LikeCountUp");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);

			System.out.println("2/3 S LikeCountUp");

			count = psmt.executeUpdate();
			System.out.println("3/3 S LikeCountUp");

		} catch (SQLException e) {
			System.out.println("LikeCountUp FAIL");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count > 0 ? true : false;
	}

}