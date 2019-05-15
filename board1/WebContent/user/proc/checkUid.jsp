<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String uid = request.getParameter("uid");

	//데이터베이스 정보
	final String HOST = "jdbc:mysql://192.168.0.161:3306/big3";
	final String USER = "big3";
	final String PASS = "1234";
	
	//1단계
	Class.forName("com.mysql.jdbc.Driver");
	
	//2단계
	Connection conn = DriverManager.getConnection(HOST, USER, PASS);
	
	//3단계
	Statement stmt = conn.createStatement();
	
	//4단계
	ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM `JSP_USER` WHERE uid='"+uid+"';");
	
	//5단계
	int count = 0;
	
	if(rs.next()){
		count = rs.getInt(1);
	}
	
	//6단계
	rs.close();
	stmt.close();
	conn.close();
	
	// JSON 데이터생성 및 전송
	JSONObject json = new JSONObject();
	json.put("result", count);
		
	out.print(json);
%>