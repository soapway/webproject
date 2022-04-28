package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

public class BoardController extends HttpServlet {

	private static final long serialVersionUID = -3103640169723735253L;
	static final int LISTCOUNT = 10;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String requestURI = req.getRequestURI();
		String contextPath = req.getContextPath();
		String command = requestURI.substring(contextPath.length());

		resp.setContentType("text/html; charset=utf-8");
		req.setCharacterEncoding("utf-8");

		if (command.equals("/SearchAction.do")) {
			requestSearch(req);
			RequestDispatcher rd = req.getRequestDispatcher("./list.jsp");
			rd.forward(req, resp);
		} else if (command.equals("/ViewAction.do")) {
			requestView(req);
			RequestDispatcher rd = req.getRequestDispatcher("./view.jsp");
			rd.forward(req, resp);
		} else if (command.equals("/signUpAction.do")) {
			requestSignUp(req);
			RequestDispatcher rd = req.getRequestDispatcher("./signup.jsp");
			rd.forward(req, resp);
		} else if (command.equals("/WriteFormAction.do")) {
			requestWriteForm(req);
			RequestDispatcher rd = req.getRequestDispatcher("./home.jsp");
			rd.forward(req, resp);
		} else if (command.equals("/LoginAction.do")) {
			if (requestLogin(req)) {
				RequestDispatcher rd = req.getRequestDispatcher("./home.jsp");
				rd.forward(req, resp);
			} else {
				RequestDispatcher rd = req.getRequestDispatcher("./login.jsp");
				rd.forward(req, resp);
			}
		} else if (command.equals("/SignUpSubmitAction.do")) {
			boolean signup_ok = requestSignUpSubmit(req);
			if (signup_ok) {
				RequestDispatcher rd = req.getRequestDispatcher("./signUpSuccess.jsp");
				rd.forward(req, resp);
			} else {
				RequestDispatcher rd = req.getRequestDispatcher("./signUpFailed.jsp");
				rd.forward(req, resp);
			}

		} else if (command.equals("/LogoutAction.do")) {
			requestLogout(req);
			RequestDispatcher rd = req.getRequestDispatcher("./home.jsp");
			rd.forward(req, resp);
		} else if (command.equals("/IdCheckAction.do")) {
			requestIdCheck(req);
			RequestDispatcher rd = req.getRequestDispatcher("./checkId.jsp");
			rd.forward(req, resp);
		} else if(command.equals("/DeleteAction.do")) {
			requestDelete(req);
			RequestDispatcher rd = req.getRequestDispatcher("./home.jsp");
			rd.forward(req, resp);
		} else if(command.equals("/UpdateAction.do")){
			requestView(req);
			RequestDispatcher rd = req.getRequestDispatcher("./updateform.jsp");
			rd.forward(req, resp);
		} else if(command.equals("/UpdateFormAction.do")) {
			requestUpdateForm(req);
			RequestDispatcher rd = req.getRequestDispatcher("./home.jsp");
			rd.forward(req, resp);
		}

	}


	private void requestUpdateForm(HttpServletRequest req) {
		// TODO Auto-generated method stub
		// 게시글 수정
		BoardDAO dao = BoardDAO.getInstance();
		String realfolder = getServletContext().getRealPath("/") + "albumart";
		
		int maxSize = 15 * 1024 * 1024;
		String encType = "UTF-8";
		try {

			MultipartRequest multi = new MultipartRequest(req, realfolder, maxSize, encType, new DefaultFileRenamePolicy());
			Enumeration files = multi.getFileNames();
			String fname = (String) files.nextElement();
			String fileName = multi.getFilesystemName(fname);

			String userid = multi.getParameter("userid");
			String album = multi.getParameter("album");
			String artist = multi.getParameter("artist");
			String genre = multi.getParameter("genre");
			String lyric = multi.getParameter("lyric");
			String title = multi.getParameter("title");
			
			if(genre == "none") {
				genre = "alternative";
			}

			BoardDTO board = new BoardDTO();

			board.setUser_id(userid);
			board.setAlbum(album);
			board.setAlbum_art(fileName);
			board.setArtist(artist);
			board.setGenre(genre);
			board.setLyric(lyric);
			board.setTitle(title);
			
			dao.updateBoard(board);
				
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	private void requestDelete(HttpServletRequest req) {
		// TODO Auto-generated method stub
		// 게시글 삭제
		int num = Integer.parseInt(req.getParameter("num"));
		
		BoardDAO dao = BoardDAO.getInstance();
		dao.deleteBoard(num);
		
	}

	private void requestIdCheck(HttpServletRequest req) {
		// TODO Auto-generated method stub
		// 아이디 중복 체크
		int result = 0;
		String user_id = req.getParameter("user_id");
		BoardDAO dao = BoardDAO.getInstance();

		result = dao.getCheckIdDuplicated(user_id);

		req.setAttribute("result", result);
		req.setAttribute("user_id", user_id);

	}

	private void requestLogout(HttpServletRequest req) {
		// TODO Auto-generated method stub
		// 로그아웃
		HttpSession session = req.getSession();
		session.invalidate();
	}

	private boolean requestSignUpSubmit(HttpServletRequest req) {
		// TODO Auto-generated method stub
		// 회원가입 처리

		boolean signup_ok = false;
		BoardDAO dao = BoardDAO.getInstance();

		String realfolder = getServletContext().getRealPath("/") + "imgupload";
		// 폴더 만들어야 함

		int maxSize = 5 * 1024 * 1024;
		String encType = "UTF-8";

		try {
			MultipartRequest multi = new MultipartRequest(req, realfolder, maxSize, encType,
					new DefaultFileRenamePolicy());
			Enumeration files = multi.getFileNames();
			String fname = (String) files.nextElement();
			String fileName = multi.getFilesystemName(fname);

			String id = multi.getParameter("id");
			String password = multi.getParameter("password");
			String username = multi.getParameter("username");

			BoardDTO board = new BoardDTO();
			board.setId(id);
			board.setPassword(password);
			board.setName(username);
			board.setUser_img(fileName);

			dao.insertMember(board);
			signup_ok = true;

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			signup_ok = false;
		}
		return signup_ok;
	}

	private boolean requestLogin(HttpServletRequest req) {
		// TODO Auto-generated method stub
		// 로그인 처리
		String id = req.getParameter("id");
		String password = req.getParameter("password");

		BoardDAO dao = BoardDAO.getInstance();

		boolean login_ok = dao.getLoginInfo(id, password);
		if (login_ok) {
			String userimg = dao.getUserimgById(id);
			HttpSession session = req.getSession();
			session.setAttribute("sessionId", id);
			req.setAttribute("userimg", userimg);
			return true;
		} else {
			req.setAttribute("error", "error");
			return false;
		}

	}

	private void requestWriteForm(HttpServletRequest req) {
		// TODO Auto-generated method stub
		// 글 올리고 홈 화면으로
		BoardDAO dao = BoardDAO.getInstance();
		String realfolder = getServletContext().getRealPath("/") + "albumart";
		
		int maxSize = 15 * 1024 * 1024;
		String encType = "UTF-8";
		try {

			MultipartRequest multi = new MultipartRequest(req, realfolder, maxSize, encType, new DefaultFileRenamePolicy());
			Enumeration files = multi.getFileNames();
			String fname = (String) files.nextElement();
			String fileName = multi.getFilesystemName(fname);

			String userid = multi.getParameter("userid");
			String album = multi.getParameter("album");
			String artist = multi.getParameter("artist");
			String genre = multi.getParameter("genre");
			String lyric = multi.getParameter("lyric");
			String title = multi.getParameter("title");

			BoardDTO board = new BoardDTO();

			board.setUser_id(userid);
			board.setAlbum(album);
			board.setAlbum_art(fileName);
			board.setArtist(artist);
			board.setGenre(genre);
			board.setLyric(lyric);
			board.setTitle(title);
			
			dao.insertBoard(board);
				
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void requestSignUp(HttpServletRequest req) {
		// TODO Auto-generated method stub
		// 회원수 표시하기
		BoardDAO dao = BoardDAO.getInstance();

		int count = dao.getUserCount();

		req.setAttribute("count", count);

	}

	public void requestSearch(HttpServletRequest req) {
		// TODO Auto-generated method stub
		// 목록 가져오기
		BoardDAO dao = BoardDAO.getInstance();
		List<BoardDTO> boardlist = new ArrayList<BoardDTO>();

		int pageNum = 1;
		int limitNum = LISTCOUNT;

		if (req.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(req.getParameter("pageNum"));
		}

		String items = req.getParameter("items");
		String text = req.getParameter("text");

		int total_record = dao.getListCount(items, text);
		boardlist = dao.getBoardList(pageNum, limitNum, items, text);

		int total_page;

		if (total_record % limitNum == 0) {
			total_page = total_record / limitNum;
			Math.floor(total_page);
		} else {
			total_page = total_record / limitNum;
			Math.floor(total_page);
			total_page += 1;
		}

		req.setAttribute("pageNum", pageNum);
		req.setAttribute("total_page", total_page);
		req.setAttribute("total_record", total_record);
		req.setAttribute("boardlist", boardlist);
		req.setAttribute("items", items);
		req.setAttribute("text", text);

	}

	public void requestView(HttpServletRequest req) {
		// TODO Auto-generated method stub
		// 상세 페이지 가져오기

		BoardDAO dao = BoardDAO.getInstance();
		int num = Integer.parseInt(req.getParameter("num"));
		int pageNum = Integer.parseInt(req.getParameter("pageNum"));

		BoardDTO board = new BoardDTO();
		board = dao.getBoardByNum(num, pageNum);
		String name = dao.getLoginNameById(board.getUser_id());
		
		req.setAttribute("name", name);
		req.setAttribute("num", num);
		req.setAttribute("page", pageNum);
		req.setAttribute("board", board);

	}

}
