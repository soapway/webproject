package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class BoardDAO {
	private static BoardDAO instance;

	private BoardDAO() {

	}

	public static BoardDAO getInstance() {
		if (instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}

	// 레코드 개수 가져오기
	public int getListCount(String items, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int n = 0;
		String sql;

		if (items.equals("all")) {
			sql = "select count(*) from board where artist like '%" + text + "%' or title like '%" + text + "%'";
		} else {
			sql = "select count(*) from board where " + items + " like '%" + text + "%'";
		}

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				n = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("getListCount() 에러 : " + e);
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				throw new RuntimeException(e.getMessage());
			}
		}
		return n;
	}

	// 유저 수 가져오기
	public int getUserCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int n = 0;
		String sql = "select count(*) from member";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				n = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("getUserCount() 에러 : " + e);
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				throw new RuntimeException(e.getMessage());
			}
		}
		return n;

	}

	// 글 목록 가져오기
	public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int total_record = getListCount(items, text);
		int start = (page - 1) * limit;
		int index = start + 1;

		String sql;

		if (items.equals("all")) {
			sql = "select * from board where artist like '%" + text + "%' or title like '%" + text
					+ "%' ORDER BY num DESC";
		} else {
			sql = "select * from board where " + items + " like '%" + text + "%' ORDER BY num DESC";
		}
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = pstmt.executeQuery();

			while (rs.absolute(index)) {
				BoardDTO board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setUser_id(rs.getString("user_id"));
				board.setTitle(rs.getString("title"));
				board.setArtist(rs.getString("artist"));
				board.setAlbum(rs.getString("album"));
				board.setGenre(rs.getString("genre"));
				board.setLyric(rs.getString("lyric"));
				board.setAlbum_art(rs.getString("album_art"));

				list.add(board);

				if (index < (start + limit) && index <= total_record)
					index++;
				else
					break;
			}
			return list;

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("getBoardList() 에러 : " + e);
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
				throw new RuntimeException(e2.getMessage());
			}
		}
		return null;
	}

	// 새 글 등록하기
	public void insertBoard(BoardDTO board) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.getConnection();

			String sql = "insert into board (num, user_id, title, artist, album, genre, lyric, album_art) values(NUM_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getUser_id());
			pstmt.setString(2, board.getTitle());
			pstmt.setString(3, board.getArtist());
			pstmt.setString(4, board.getAlbum());
			pstmt.setString(5, board.getGenre());
			pstmt.setString(6, board.getLyric());
			pstmt.setString(7, board.getAlbum_art());

			pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("insertBoard() 에러 : " + ex);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}

	}

	// 아이디로 유저 이미지 가져오기
	public String getUserimgById(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String user_img = "";

		String sql = "select user_img from member where id = ?";
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user_img = rs.getString("user_img");
				return user_img;
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("getUserimgById() 에러 : " + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return user_img;
	}

//	 선택한 글 상세 내용 가져오기
	public BoardDTO getBoardByNum(int num, int page) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDTO board = null;

		String sql = "select num, user_id, title, artist, album, genre, lyric, album_art from board where num = ?";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				board = new BoardDTO();
				board.setAlbum(rs.getString("album"));
				board.setAlbum_art(rs.getString("album_art"));
				board.setArtist(rs.getString("artist"));
				board.setGenre(rs.getString("genre"));
				board.setLyric(rs.getString("lyric"));
				board.setNum(rs.getInt("num"));
				board.setTitle(rs.getString("title"));
				board.setUser_id(rs.getString("user_id"));
			}

			return board;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("getBoardByNum() 에러 : " + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return board;
	}

	// 아이디로 이름 가져오기
	public String getLoginNameById(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String name = null;
		String sql = "select name from member where id = ?";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next())
				name = rs.getString("name");

			return name;
		} catch (Exception ex) {
			System.out.println("getLoginNameById() 에러 : " + ex);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return name;

	}
	
	public int getBoardCountById(String id) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from board where user_id = ?";
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next())
				count = rs.getInt(1);
			
			return count;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("getBoardCountById() 에러 : " + e);
		}finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return count;
	}

	// 로그인 정보 가져오기(DB에 있는 아이디와 비밀번호와 일치하는지 확인하기)
	public boolean getLoginInfo(String id, String password) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from member where id = ? and password = ?";
		boolean login_ok = false;
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				login_ok = true;
			} else {
				login_ok = false;
			}

		} catch (Exception ex) {
			System.out.println("getLoginInfo() 에러 : " + ex);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return login_ok;
	}

	// 회원 추가하기
	public void insertMember(BoardDTO board) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.getConnection();

			String sql = "insert into member (id, password, name, user_img) values(?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getId());
			pstmt.setString(2, board.getPassword());
			pstmt.setString(3, board.getName());
			pstmt.setString(4, board.getUser_img());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("insertMember() 에러 : " + ex);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	}

	// 로그인 후 메뉴에 유저 이미지 띄우기
	public String getImgForMenu(String id) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String user_img = "";

		try {
			conn = DBConnection.getConnection();
			String sql = "select user_img from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user_img = rs.getString(user_img);
			}

		} catch (Exception ex) {
			System.out.println("getImgForMenu() 에러 : " + ex);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return user_img;
	}

	// 아이디 중복 검사
	public int getCheckIdDuplicated(String id) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBConnection.getConnection();
			String sql = "select id from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 0;
			} else {
				result = 1;
			}

		} catch (Exception ex) {
			System.out.println("getCheckIdDuplicated() 에러 : " + ex);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return result;
	}

	// 게시글 삭제하기
	public void deleteBoard(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBConnection.getConnection();
			String sql = "delete from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("deleteBoard() 에러 : " + ex);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	}

	// 게시글 수정하기
	public void updateBoard(BoardDTO board) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.getConnection();

			String sql1 = "update board set title = ?, artist = ?, album= ?, genre= ?, lyric= ?, album_art = ? where num = ?";
			String sql2 = "update board set title = ?, artist = ?, album= ?, genre= ?, lyric= ? where num = ?";

			if (board.getAlbum_art().isEmpty()) {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, board.getTitle());
				pstmt.setString(2, board.getArtist());
				pstmt.setString(3, board.getAlbum());
				pstmt.setString(4, board.getGenre());
				pstmt.setString(5, board.getLyric());
				pstmt.setInt(6, board.getNum());

				pstmt.executeUpdate();
				
			} else {
				pstmt = conn.prepareStatement(sql1);
				pstmt.setString(1, board.getTitle());
				pstmt.setString(2, board.getArtist());
				pstmt.setString(3, board.getAlbum());
				pstmt.setString(4, board.getGenre());
				pstmt.setString(5, board.getLyric());
				pstmt.setString(6, board.getAlbum_art());
				pstmt.setInt(7, board.getNum());

				pstmt.executeUpdate();
			}

		} catch (Exception ex) {
			System.out.println("updateBoard() 에러 : " + ex);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	}

}
