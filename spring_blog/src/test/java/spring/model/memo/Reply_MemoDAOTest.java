package spring.model.memo;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class Reply_MemoDAOTest {
	private static BeanFactory beans;
	private static Reply_MemoDAO dao;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		Resource resource = new ClassPathResource("blog.xml");
		beans = new XmlBeanFactory(resource);
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
		dao = (Reply_MemoDAO) beans.getBean("rmdao");
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test @Ignore
	public void testRcount() {
		fail("Not yet implemented");
	}

	@Test @Ignore
	public void testCreate() {
		Reply_MemoDTO dto = new Reply_MemoDTO();
		dto.setMemono(502);
		dto.setContent("댓글1");
		dto.setId("user1");
		assertTrue(dao.create(dto));
	}

	@Test @Ignore
	public void testRead() {
		Reply_MemoDTO dto = dao.read(20);
		assertEquals(dto.getMemono(), 502);
		assertEquals(dto.getId(), "user1");
		assertEquals(dto.getContent(), "댓글1");
	}

	@Test @Ignore
	public void testUpdate() {
		Reply_MemoDTO dto = new Reply_MemoDTO();
		dto.setContent("댓글2로 변경");
		dto.setRnum(20);
		assertTrue(dao.update(dto));
	}

	@Test @Ignore
	public void testList() {
		Map map = new HashMap();
		map.put("memono", 502);
		map.put("sno", 1);
		map.put("eno", 5);
		List<Reply_MemoDTO> list = dao.list(map);
		assertEquals(list.size(), 1);
	}

	@Test @Ignore
	public void testTotal() {
		int memono = 502;
		int cnt = dao.total(memono);
		assertEquals(cnt, 1);
	}

	@Test @Ignore
	public void testDelete() {
		int rnum = 20;
		assertTrue(dao.delete(rnum));
	}

	@Test @Ignore
	public void testBdelete() throws Exception {
		int memono = 502;
		assertEquals(dao.bdelete(memono), 1);
	}

}
