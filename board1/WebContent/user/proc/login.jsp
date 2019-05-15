<%@page import="kr.co.board1.bean.UserBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 파라미터 언어셋 지정
	request.setCharacterEncoding("UTF-8");

	// 파라미터 수신
	String uid  = request.getParameter("id");
	String pass = request.getParameter("pw");
	
	//데이터베이스 정보
	final String HOST = "jdbc:mysql://192.168.0.161:3306/big3";
	final String USER = "big3";
	final String PASS = "1234";
	
	//1단계
	Class.forName("com.mysql.jdbc.Driver");
	
	//2단계
	Connection conn = DriverManager.getConnection(HOST, USER, PASS);
	
	// 3단계
	String sql = "SELECT * FROM `JSP_USER` WHERE uid=? AND pass=PASSWORD(?);";
	PreparedStatement psmt = conn.prepareStatement(sql);
	psmt.setString(1, uid);
	psmt.setString(2, pass);
	
	// 4단계
	ResultSet rs = psmt.executeQuery();
	
	// 5단계
	if(rs.next()){
		// 회원이 맞을 경우
		UserBean ub = new UserBean();
		ub.setUid(rs.getString(1));
		ub.setPass(rs.getString(2));
		ub.setName(rs.getString(3));
		ub.setNick(rs.getString(4));
		ub.setEmail(rs.getString(5));
		ub.setHp(rs.getString(6));
		ub.setGrade(rs.getInt(7));
		ub.setZip(rs.getString(8));
		ub.setAddr1(rs.getString(9));
		ub.setAddr2(rs.getString(10));
		ub.setRegip(rs.getString(11));
		ub.setRdate(rs.getString(12));

		// 회원정보 객체 세션에 저장
		session.setAttribute("user", ub);
		
		// 게시판 목록 이동
		response.sendRedirect("../../list.jsp");
		
	}else{
		// 회원이 아닐 경우
		response.sendRedirect("../login.jsp?result=fail");		
	}
	
	// 6단계
	rs.close();
	psmt.close();
	conn.close();
	
%>

