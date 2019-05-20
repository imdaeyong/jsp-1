package kr.co.board1.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import kr.co.board1.config.DBConfig;
import kr.co.board1.config.SQL;

public class BoardService {

	
	// ��ü ������ �� ���ϱ�
	public int getTotalPage(int boardTotal) {
		
		int pageTotal = 0;
		
		if(boardTotal % 10 == 0){
			pageTotal = boardTotal / 10;	
		}else{
			pageTotal = boardTotal / 10 + 1;
		}
		
		return pageTotal;		
	}
	
	// ��ü �Խù� ���ϱ�
	public int getTotalBoard() throws Exception {
		// 1�ܰ�, 2�ܰ�
		Connection conn = DBConfig.getConnection();

		// 3�ܰ� 
		Statement stmt = conn.createStatement();
		
		// 4�ܰ�
		ResultSet rs = stmt.executeQuery(SQL.SELECT_COUNT_TOTAL);
		
		// 5�ܰ�
		int total = 0;
		
		if(rs.next()) {
			total = rs.getInt(1);
		}
		
		// 6�ܰ�
		rs.close();
		stmt.close();
		conn.close();
		
		return total;
	}
	
	// �Խù� ��� ���ϱ�
	public void getBoardList() {}
	
	// �Խù� �߰��ϱ�
	public void insertBoard() {}
	
	
}
