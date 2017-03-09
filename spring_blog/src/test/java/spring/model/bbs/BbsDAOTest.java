package spring.model.bbs;

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

public class BbsDAOTest {
	private static BeanFactory beans;
	private static BbsDAO bdao;

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
		bdao = (BbsDAO)beans.getBean("bdao");
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test @Ignore
	public void testCheckRefno() {
		int bbsno = 28;
		assertTrue(bdao.checkRefno(bbsno));
	}

	@Test @Ignore
	public void testTotal() {
		assertEquals(bdao.total("wname", "a"), 4);
	}

	@Test
	public void testList() {
		Map map = new HashMap();
		map.put("col", "wname");
		map.put("word", "");
		map.put("sno", 1);
		map.put("eno", 5);
		
		List<BbsDTO> list = bdao.list(map);
		assertEquals(list.size(), 5);
	}

	@Test @Ignore
	public void testCreate() {
		BbsDTO dto = new BbsDTO();
		dto.setWname("홍길동");
		dto.setTitle("글제목");
		dto.setContent("글내용");
		dto.setPasswd("123");
		dto.setFilename("test.txt");
		dto.setFilesize(100);
		assertTrue(bdao.create(dto));
	}

	@Test @Ignore
	public void testRead() {
		BbsDTO dto = bdao.read(2);
		assertNotNull(dto);
	}

	@Test @Ignore
	public void testUpViewcnt() {
		fail("Not yet implemented");
	}

	@Test @Ignore
	public void testCheckPasswd() {
		Map map = new HashMap();
		map.put("bbsno", 40);
		map.put("passwd", 123);
		assertTrue(bdao.checkPasswd(map));
	}

	@Test @Ignore
	public void testUpdate() {
		BbsDTO dto = new BbsDTO();
		dto.setBbsno(40);
		dto.setWname("홍길동");
		dto.setTitle("제목변경");
		dto.setContent("내용변경");
		dto.setFilename("text02");
		dto.setFilesize(150);
		assertTrue(bdao.update(dto));
	}

	@Test @Ignore
	public void testDelete() {
		int bbsno = 28;
		assertTrue(bdao.delete(bbsno));
	}
	
	@Test @Ignore
	public void testReadReply() {
		BbsDTO dto = bdao.readReply(19);
		assertEquals(dto.getGrpno(), 17);
		assertEquals(dto.getIndent(), 1);
		assertEquals(dto.getAnsnum(), 1);
		assertEquals(dto.getTitle(), "존나이쁨");
	}

	@Test @Ignore
	public void testReply() {
		BbsDTO dto = bdao.readReply(41);
		dto.setWname("답변자1");
		dto.setContent("답변내용1");
		dto.setPasswd("12345");
		dto.setFilename("text2.txt");
		dto.setFilesize(1100);
		bdao.addAnsnum(dto.getGrpno(), dto.getAnsnum());
		assertTrue(bdao.reply(dto));
	}

	@Test @Ignore
	public void testAddAnsnum() {
		fail("Not yet implemented");
	}

}
