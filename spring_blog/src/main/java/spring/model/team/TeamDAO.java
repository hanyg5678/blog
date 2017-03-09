package spring.model.team;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.utility.blog.DBClose;
import spring.utility.blog.DBOpen;

@Repository
public class TeamDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public boolean updateFile(Map map) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		String filename = (String)map.get("filename");
		int no = (Integer)map.get("no");
		StringBuffer sql = new StringBuffer();
		sql.append(" update team1 ");
		sql.append(" set filename = ? ");
		sql.append(" where no = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, filename);
			pstmt.setInt(2, no);
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt > 0) flag = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		
		return flag;		
	}
	
	public int total(String col, String word) {
		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		return sqlSession.selectOne("team.total", map);
	}
	public boolean delete (int no) {
		boolean flag = false;
		int cnt = sqlSession.delete("team.delete", no);
		if(cnt > 0) flag = true;
		
		return flag;
	}
	
	public boolean update(TeamDTO dto) {
		boolean flag = false;
		int cnt = sqlSession.update("team.update", dto);
		if(cnt > 0) flag = true;		
		return flag;
	}
	
	public TeamDTO read(int no) {
		return sqlSession.selectOne("team.read", no);
	}
	
	public boolean create(TeamDTO dto) {
		boolean flag = false;
		int cnt = sqlSession.insert("team.create", dto);
		if(cnt > 0) flag = true;
		return flag;
	}
	
	public List<TeamDTO> list(Map map) {
						
		return sqlSession.selectList("team.list", map);
	}
}