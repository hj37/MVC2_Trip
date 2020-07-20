package question;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import notice.noticeVO;

public class questionDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	private Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/travel");
		con = ds.getConnection();
		return con;
		}//getConnection ?��
	private void freeResource() {
		try {
			if(rs != null) {rs.close();}
			if(pstmt != null) {pstmt.close();}
			if(con != null) {con.close();}
		} catch (Exception e) {
			e.printStackTrace();
		}
	 }//freeResource?��
	public List<questionVO> getquestionList(int startRow, int pageSize) {
		List<questionVO> questionlist = new ArrayList<questionVO>();
		try {
			con = getConnection();
			String query ="select * from question order by num desc limit ?,?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				questionVO q = new questionVO();
				q.setId(rs.getString("id"));
				q.setContent(rs.getString("content"));
				q.setDate(rs.getTimestamp("date"));
				q.setNum(rs.getInt("num"));				
				q.setPos(rs.getInt("pos"));
				q.setDepth(rs.getInt("depth"));
				q.setPassword(rs.getString("password"));
				q.setTitle(rs.getString("title"));
				q.setCount(rs.getInt("count"));
				questionlist.add(q);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return questionlist;
	}
	public questionVO getquestion(int num) {
		questionVO qvo = new questionVO();
		try {
			con = getConnection();
			String query = "select * from question where num=? ";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				qvo.setId(rs.getString("id"));
				qvo.setContent(rs.getString("content"));
				qvo.setDate(rs.getTimestamp("date"));
				qvo.setNum(rs.getInt("num"));
				qvo.setPos(rs.getInt("pos"));
				qvo.setDepth(rs.getInt("depth"));
				qvo.setPassword(rs.getString("password"));
				qvo.setTitle(rs.getString("title"));
			}
			
		} catch (Exception e) {
			System.out.println("questionVO메서드에서 예외 발생 : " + e);
		}finally {
			freeResource();
		}
		return qvo;
	}
	public void insertquestion(questionVO q) {

		try {
			con = getConnection();			
			String query = "insert into question"
					+ "(id,title,password,content,pos,depth,date,count)"
					+ "values(?,?,?,?,0,0,now(),0)";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, q.getId());
			pstmt.setString(2, q.getTitle());
			pstmt.setString(3, q.getPassword());			
			pstmt.setString(4, q.getContent());
		
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("insertquestion메서드에서 예외발생 : " + e);
		}
	}//insertquestion끝
	public  int updatequestion(questionVO qvo, int num) {
		int check=0;
		try {
			con = getConnection();
			String qeury = "select password from question where num=?";
			pstmt = con.prepareStatement(qeury);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(qvo.getPassword().equals(rs.getString("password"))) {
					check = 1;
				qeury = "update question set id=?, title=?, content=? where num=?";
				pstmt = con.prepareStatement(qeury);
				pstmt.setString(1, qvo.getId());
				pstmt.setString(2, qvo.getTitle());
				pstmt.setString(3, qvo.getContent());
				pstmt.setInt(4, num);
				pstmt.executeUpdate();
			}else {
					check = 0;
				}
			}
		} catch (Exception e) {
			System.out.println("updatequestion메서드에서 예외 발생:" + e);
		}finally {
			freeResource();
		}
		return check;
	}
	public void questionCount(int num) { //조회수
		
		String sql="";

		try {
			con=getConnection();
			sql="update question set count=count+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
	  }
	public int getquestionCount() {
		int count = 0;
		try {
			con = getConnection();
			String query = "select count(*) from question";
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("getquestionCount메서드에서 예외  발생 : " + e);
		} finally {
			freeResource();
		}
		return count;
	}
	public void deletequestion(questionVO qvo) {
		try {
			con = getConnection();
			String query = "select password from question where num=?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, qvo.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			  query = "delete from question where num=?";
			  pstmt = con.prepareStatement(query);
			  pstmt.setInt(1, qvo.getNum());
			  pstmt.executeUpdate();
			}
		} catch (Exception e) {
			System.out.println("deletqeustion메서?��?��?�� ?���? 발생 : " +e);
		}finally {
			freeResource();
		}
	}
	public boolean replyWrite(int num) {// 이전보드의 정보 + 새로운 보드 정보				
		boolean result = false;
		questionVO vo = new questionDAO().getquestion(num);
		try {
			con = getConnection();							
			String query = "update question set pos= pos+1 where pos > ?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1,vo.getPos());			
			pstmt.executeUpdate();
			 
			query="insert into question"
					+ "(id,title,password,content,pos,depth,date,count)"
					+ "values(?,?,?,?,0,0,now(),0)";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getPassword());			
			pstmt.setString(4, vo.getContent());
			pstmt.setInt(5, vo.getPos()+1);
			pstmt.setInt(6, vo.getDepth()+1);			
			if(pstmt.executeUpdate()==1)result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return result;
	}
}// questionDAO 끝