<%@page import="kr.co.board1.bean.UserBean"%>
<%@page import="kr.co.board1.config.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.board1.config.DBConfig"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String subject 	= request.getParameter("subject");
	String content 	= request.getParameter("content");
	String regip	= request.getRemoteAddr();

	//세션에서 사용자 아이디 가져오기
	UserBean ub = (UserBean) session.getAttribute("user");
	String uid = ub.getUid();
	
	//1단계, 2단계
	Connection conn = DBConfig.getConnection();
	
	//3단계
	PreparedStatement psmt = conn.prepareStatement(SQL.INSERT_BOARD);
	psmt.setString(1, subject);
	psmt.setString(2, content);
	psmt.setString(3, uid);
	psmt.setString(4, regip);
	
	//4단계
	psmt.executeUpdate();
	
	//5단계 - 결과셋 처리(SELECT 경우)
	
	//6단계
	psmt.close();
	conn.close();
	
	response.sendRedirect("../list.jsp");

%>