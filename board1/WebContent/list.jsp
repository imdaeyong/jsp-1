<%@page import="kr.co.board1.service.BoardService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.board1.bean.BoardBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.co.board1.config.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.board1.config.DBConfig"%>
<%@page import="kr.co.board1.bean.UserBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	UserBean ub = (UserBean) session.getAttribute("user");
	String nick = null;

	List<BoardBean> list = new ArrayList<>();
	int totalPage = 0;
	
	if(ub == null){
		// 로그인을 안했을때
		response.sendRedirect("./user/login.jsp?result=101");
	}else{
		
		BoardService bs = new BoardService();
		
		int total = bs.getTotalBoard();
		totalPage = bs.getTotalPage(total);
		
		
		// 로그인을 했을때
		nick = ub.getNick();
		
		//1단계, 2단계
 		Connection conn = DBConfig.getConnection();
		
		//3단계
		PreparedStatement psmt = conn.prepareStatement(SQL.SELECT_LIST);
		
		//4단계
		ResultSet rs = psmt.executeQuery();
		
		//5단계
		while(rs.next()){
			BoardBean bb = new BoardBean();
			bb.setSeq(rs.getInt(1));
			bb.setParent(rs.getInt(2));
			bb.setComment(rs.getInt(3));
			bb.setCate(rs.getString(4));
			bb.setTitle(rs.getString(5));
			bb.setContent(rs.getString(6));
			bb.setFile(rs.getInt(7));
			bb.setHit(rs.getInt(8));
			bb.setUid(rs.getString(9));
			bb.setRegip(rs.getString(10));
			bb.setRdate(rs.getString(11));
			bb.setNick(rs.getString(12));
			
			list.add(bb);
		}
		
		//6단계
		rs.close();
		psmt.close();
		conn.close();
	}
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>글목록</title> 
		<link rel="stylesheet" href="./css/style.css" />
	</head>
	<body>
		<div id="board">
			<h3>글목록</h3>
			<!-- 리스트 -->
			<div class="list">
				<p class="logout"><%= nick %>님! 반갑습니다. <a href="/board1/user/proc/logout.jsp">[로그아웃]</a><p>
				<table>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>글쓴이</td>
						<td>날짜</td>
						<td>조회</td>
					</tr>
				
				<% for(BoardBean bb : list){ %>
					<tr>
						<td><%= bb.getSeq() %></td>
						<td><a href="#"><%= bb.getTitle() %></a>&nbsp;[<%= bb.getComment() %>]</td>
						<td><%= bb.getNick() %></td>
						<td><%= bb.getRdate().substring(2, 10) %></td>
						<td><%= bb.getHit() %></td>
					</tr>
				<% } %>
					
				</table>
			</div>
			<!-- 페이징 -->
			<nav class="paging">
				<span> 
				<a href="#" class="prev">이전</a>
				
				<% for(int i=1 ; i<=totalPage ; i++){ %>
					<a href="#" class="num"><%= i %></a>
				<% } %>
				
				<a href="#" class="next">다음</a>
				</span>
			</nav>
			<a href="/board1/write.jsp" class="btnWrite">글쓰기</a>
		</div>
	</body>

</html>










