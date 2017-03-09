package spring.model.memo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class Reply_MemoTest {

	public static void main(String[] args) {
		Resource resource = new ClassPathResource("blog.xml");

		BeanFactory beans = new XmlBeanFactory(resource);

		Reply_MemoDAO dao = (Reply_MemoDAO) beans.getBean("rdao");

		// create(dao);
		// read(dao);
		// update(dao);
		// list(dao);
		// delete(dao);
		// total(dao);

	}

	private static void total(Reply_MemoDAO dao) {
		int memono = 8;
		int total = dao.total(memono);
		p("total:" + total);

	}

	private static void delete(Reply_MemoDAO dao) {

		if (dao.delete(1)) {
			p("성공");
		} else {
			p("실패");
		}

	}

	private static void list(Reply_MemoDAO dao) {
		int sno = 1;
		int eno = 5;
		Map map = new HashMap();
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("memono", 38);

		List<Reply_MemoDTO> list = dao.list(map);

		for (int i = 0; i < list.size(); i++) {
			Reply_MemoDTO dto = list.get(i);

			p(dto);
			p("-------------------");
		}

	}

	private static void update(Reply_MemoDAO dao) {
		Reply_MemoDTO dto = dao.read(38);
		dto.setContent("댓글 내용을 변경합니다.");

		if (dao.update(dto)) {
			p("성공");
			dto = dao.read(1);
			p(dto);
		} else {
			p("실패");
		}

	}

	private static void read(Reply_MemoDAO dao) {
		Reply_MemoDTO dto = dao.read(1);
		p(dto);

	}

	private static void p(Reply_MemoDTO dto) {
		p("번호:" + dto.getRnum());
		p("내용:" + dto.getContent());
		p("아이디:" + dto.getId());
		p("글번호:" + dto.getMemono());
		p("등록날짜:" + dto.getRegdate());

	}

	private static void create(Reply_MemoDAO dao) {

		Reply_MemoDTO dto = new Reply_MemoDTO();
		dto.setId("user2");// member table에서 id가져오기
		dto.setContent("댓글 쓰기 예제");
		dto.setMemono(37);// bbs table에서 존재하는 글번호 가져오기
		if (dao.create(dto)) {
			p("성공");
		} else {
			p("실패");
		}

	}

	private static void p(String string) {
		System.out.println(string);

	}

}