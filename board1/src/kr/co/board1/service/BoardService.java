package kr.co.board1.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import kr.co.board1.config.DBConfig;
import kr.co.board1.config.SQL;

public class BoardService {

	
	// 전체 페이지 수 구하기
	public int getTotalPage(int boardTotal) {
		
		int pageTotal = 0;
		
		if(boardTotal % 10 == 0){
			pageTotal = boardTotal / 10;	
		}else{
			pageTotal = boardTotal / 10 + 1;
		}
		
		return pageTotal;		
	}
	
	// 전체 게시물 구하기
	public int getTotalBoard() throws Exception {
		// 1단계, 2단계
		Connection conn = DBConfig.getConnection();

		// 3단계 
		Statement stmt = conn.createStatement();
		
		// 4단계
		ResultSet rs = stmt.executeQuery(SQL.SELECT_COUNT_TOTAL);
		
		// 5단계
		int total = 0;
		
		if(rs.next()) {
			total = rs.getInt(1);
		}
		
		// 6단계
		rs.close();
		stmt.close();
		conn.close();
		
		return total;
	}
	
	// 게시물 목록 구하기
	public void getBoardList() {}
	
	// 게시물 추가하기
	public void insertBoard() {}
	
	
}
