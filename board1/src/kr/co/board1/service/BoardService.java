package kr.co.board1.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.catalina.LifecycleListener;

import kr.co.board1.bean.BoardBean;
import kr.co.board1.config.DBConfig;
import kr.co.board1.config.SQL;

public class BoardService {

	
	// Limit용 Start값 구하기
	public int getStartForLimit(String pg) {
		
		int start = 0;
		
		// null 체크
		if(pg == null) {
			start = 1;
		}else {
			start = Integer.parseInt(pg);	
		}
				
		return (start - 1) * 10;
	}
	
	
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
	public List<BoardBean> getBoardList(int start) throws Exception {
		
		//1단계, 2단계
 		Connection conn = DBConfig.getConnection();
		
		//3단계
		PreparedStatement psmt = conn.prepareStatement(SQL.SELECT_LIST);
		psmt.setInt(1, start);
		
		//4단계
		ResultSet rs = psmt.executeQuery();
		
		//5단계
		List<BoardBean> list = new ArrayList<>(); 
		
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
		
		return list;
	}
	
	// 게시물 추가하기
	public void insertBoard() {}
	
	
}
