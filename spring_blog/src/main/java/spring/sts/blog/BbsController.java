package spring.sts.blog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.model.IDAO;
import spring.model.bbs.BbsDAO;
import spring.model.bbs.BbsDTO;
import spring.model.bbs.BbsService;
import spring.model.bbs.ReplyDAO;
import spring.model.bbs.ReplyDTO;
import spring.utility.blog.Utility;

@Controller
public class BbsController {
	@Autowired
	private BbsService service;

	@Autowired
	private ReplyDAO rdao;

	@RequestMapping("/bbs/rdelete")
	public String rdelete(int rnum, int bbsno, int nowPage, int nPage, String col, String word, Model model) {

		int total = rdao.total(bbsno);// 댓글전체레코드값을 가져와서
		int totalPage = (int) (Math.ceil((double) total / 3)); // 전체 페이지
		if (rdao.delete(rnum)) {
			if (nPage != 1 && nPage == totalPage && total % 3 == 1) {// 마지막페이지의
																		// 마지막레코드이면(3은
																		// 한페이지당보여줄
																		// 레코드
																		// 갯수)
				nPage = nPage - 1; // 현재의 페이지값에서 1을 빼자
			}
			model.addAttribute("bbsno", bbsno);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("nPage", nPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);

		} else {
			return "error/error";
		}

		return "redirect:./read";
	}

	@RequestMapping("/bbs/rupdate")
	public String rupdate(ReplyDTO dto, int nowPage, int nPage, String col, String word, Model model) {
		if (rdao.update(dto)) {
			model.addAttribute("bbsno", dto.getBbsno());
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("nPage", nPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
		} else {
			return "error/error";
		}

		return "redirect:./read";
	}

	@RequestMapping("/bbs/rcreate")
	public String rcreate(ReplyDTO dto, int nowPage, String col, String word, Model model) {

		if (rdao.create(dto)) {
			model.addAttribute("bbsno", dto.getBbsno());
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
		} else {
			return "error/error";
		}

		return "redirect:./read";
	}

	@Autowired
	private BbsDAO dao;

	@RequestMapping(value = "/bbs/delete", method = RequestMethod.POST)
	public String delete(int bbsno, Model model, String passwd, String col, String word, String oldfile, String nowPage,
			HttpServletRequest request) {
		String upDir = request.getRealPath("/bbs/storage");
		Map map = new HashMap();
		map.put("bbsno", bbsno);
		map.put("passwd", passwd);
		boolean pflag = dao.checkPasswd(map);
		String url = "passwdError";
		if (pflag) {
			try {
				service.delete(bbsno);
				Utility.deleteFile(upDir, oldfile);
				model.addAttribute("col", col);
				model.addAttribute("word", word);
				model.addAttribute("nowPage", nowPage);
				url = "redirect:./list";
			} catch (Exception e) {
				e.printStackTrace();
                url = "error";
			}
		} 
		return url;
	}

	@RequestMapping(value = "/bbs/delete", method = RequestMethod.GET)
	public String delete(int bbsno, Model model) {

		model.addAttribute("flag", dao.checkRefno(bbsno));

		return "/bbs/delete";
	}

	@RequestMapping(value = "/bbs/reply", method = RequestMethod.POST)
	public String reply(BbsDTO dto, Model model, String col, String word, String nowPage, HttpServletRequest request) {
		String basePath = request.getRealPath("/bbs/storage");
		int filesize = (int) dto.getFileMF().getSize();
		String filename = "";
		if (filesize > 0) {
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}

		dto.setFilename(filename);
		dto.setFilesize(filesize);
		dao.addAnsnum(dto.getGrpno(), dto.getAnsnum());

		boolean flag = dao.reply(dto);
		if (flag) {
			model.addAttribute("word", word);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("col", col);
			return "redirect:./list";
		} else {
			return "error";
		}
	}

	@RequestMapping(value = "/bbs/reply", method = RequestMethod.GET)
	public String reply(int bbsno, Model model) {
		model.addAttribute("dto", dao.readReply(bbsno));

		return "/bbs/reply";
	}

	@RequestMapping(value = "/bbs/update", method = RequestMethod.POST)
	public String update(BbsDTO dto, Model model, String col, String word, String nowPage, String oldfile,
			HttpServletRequest requeset) {
		String basePath = requeset.getRealPath("/bbs/storage");
		int filesize = (int) dto.getFileMF().getSize();
		String filename = "";

		if (filesize > 0) {
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}

		dto.setFilesize(filesize);
		dto.setFilename(filename);

		Map map = new HashMap();
		map.put("bbsno", dto.getBbsno());
		map.put("passwd", dto.getPasswd());
		boolean pflag = dao.checkPasswd(map);
		if (pflag) {
			if (dao.update(dto)) {
				Utility.deleteFile(basePath, oldfile);
				model.addAttribute("col", col);
				model.addAttribute("word", word);
				model.addAttribute("nowPage", nowPage);

				return "redirect:./list";
			} else {
				return "error";
			}
		} else {
			if (filesize > 0)
				Utility.deleteFile(basePath, filename);
			return "passwdError";
		}
	}

	@RequestMapping(value = "/bbs/update", method = RequestMethod.GET)
	public String update(int bbsno, Model model) {
		model.addAttribute("dto", dao.read(bbsno));

		return "/bbs/update";
	}

	@RequestMapping("/bbs/read")
	public String read(int nowPage, String col, String word, HttpServletRequest request, int bbsno, Model model) {
		dao.upViewcnt(bbsno);

		BbsDTO dto = dao.read(bbsno);
		dto.getContent().replaceAll("\r\n", "<br>");
		model.addAttribute("dto", dto);

		/* 댓글 관련 시작 */
		String url = "read";
		String no = "bbsno";
		int nPage = 1; // 시작 페이지 번호는 1부터 댓글에 대한 페이징

		if (request.getParameter("nPage") != null) {
			nPage = Integer.parseInt(request.getParameter("nPage"));
		}
		int recordPerPage = 3; // 한페이지당 출력할 레코드 갯수

		int sno = ((nPage - 1) * recordPerPage) + 1; //
		int eno = nPage * recordPerPage;

		Map map = new HashMap();
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("bbsno", bbsno);

		List<ReplyDTO> list = rdao.list(map);

		int total = rdao.total(bbsno);

		String paging = Utility.paging(total, nPage, recordPerPage, url, bbsno, nowPage, col, word, no);

		model.addAttribute("rlist", list);
		model.addAttribute("paging", paging);
		model.addAttribute("nPage", nPage);

		/* 댓글 관련 끝 */

		return "/bbs/read";
	}

	@RequestMapping(value = "/bbs/create", method = RequestMethod.POST)
	public String create(HttpServletRequest request, BbsDTO dto) {
		String basePath = request.getRealPath("/bbs/storage");
		int filesize = (int) dto.getFileMF().getSize();
		String filename = "";
		if (filesize > 0) {
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}

		dto.setFilename(filename);
		dto.setFilesize(filesize);

		boolean flag = dao.create(dto);
		if (flag) {
			return "redirect:./list";
		} else {
			return "error";
		}
	}

	@RequestMapping(value = "/bbs/create", method = RequestMethod.GET)
	public String create() {

		return "/bbs/create";
	}

	@RequestMapping(value = "/bbs/list")
	public String list(HttpServletRequest request) {
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		if (col.equals("total")) {
			word = "";
		}
		// 페이지 관련---------------
		int nowPage = 1;
		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		int recordPerPage = 5;// 한페이지당 보여줄 레코드 갯수

		// DB 에서 가져올 순번
		int sno = ((nowPage - 1) * recordPerPage) + 1;
		int eno = nowPage * recordPerPage;

		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);

		List<BbsDTO> list = dao.list(map);
		int total = dao.total(col, word);
		String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);
		IDAO idao = rdao;
		request.setAttribute("idao", idao);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("paging", paging);
		request.setAttribute("list", list);
		request.setAttribute("rdao", rdao);

		return "/bbs/list";
	}
}