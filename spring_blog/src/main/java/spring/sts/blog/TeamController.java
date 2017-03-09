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

import spring.model.team.TeamDAO;
import spring.model.team.TeamDTO;
import spring.utility.blog.Utility;

@Controller
public class TeamController {
	@Autowired
	private TeamDAO dao;
	
	@RequestMapping("/admin/team/delete")
	public String delete(int no, String oldfile, HttpServletRequest request, String nowPage, String col, String word, Model model) {
		String basePth = request.getRealPath("/team/storage");
		boolean flag = dao.delete(no);
		if(flag) {
			if(oldfile!=null && !oldfile.equals("member.jpg"))
				Utility.deleteFile(basePth, oldfile);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			return "redirect:./list";
		} else {
			return "error";
		}
	}
	
	@RequestMapping(value="/admin/team/update", method=RequestMethod.POST)
	public String update(TeamDTO dto, HttpServletRequest request, String oldfile, String col, String word, String nowPage, Model model) {
		String basePath = request.getRealPath("/team/storage");
		int filesize = (int)dto.getFileMF().getSize();
		String filename="";
		if(filesize > 0) {
			if(oldfile!=null && !oldfile.equals("member.jpg"))
				Utility.deleteFile(basePath, oldfile);
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}
		dto.setFilename(filename);
		
		boolean flag = dao.update(dto);
		if(flag) {
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			return "redirect:./list";
		} else {
			return "error";
		}
	}
	
	@RequestMapping(value="/admin/team/update", method=RequestMethod.GET)
	public String update(int no, Model model) {
		
		model.addAttribute("dto", dao.read(no));
		return "/team/update";
	}
	
	@RequestMapping("/admin/team/read")
	public String read(int no, Model model) {
		
		model.addAttribute("dto", dao.read(no));
		return "/team/read";
	}
	
	@RequestMapping(value="/admin/team/create", method=RequestMethod.GET)
	public String create() {
		return "/team/create";
	}
	
	@RequestMapping(value="/admin/team/create", method=RequestMethod.POST)
	public String create(TeamDTO dto, HttpServletRequest request) {
		String basePath = request.getRealPath("/team/storage");
		
		int filesize = (int)dto.getFileMF().getSize();
		String filename = "";
		if(filesize > 0) {
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		} else {
			filename = "member.jpg";
		}
		dto.setFilename(filename);
		if(dao.create(dto)) {
			return "redirect:./list";
		} else {
			return "error";
		}
	}
	
	@RequestMapping("/admin/team/list")		// /team/list => 요청 URI
	public String list(HttpServletRequest request) {
		
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		if(col.equals("total")) word="";
		
		// 페이징 관련
		int nowPage = 1;		// 현재 페이지, 변경가능
		if(request.getParameter("nowPage")!=null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		int recordPerPage = 5;		// 한페이지당 보여줄 레코드 갯수
		
		// DB가져올 순번 생성
		int sno = ((nowPage - 1) * recordPerPage + 1);
		int eno = nowPage * recordPerPage;
		
		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word); 
		map.put("sno", sno);
		map.put("eno", eno);
		
		int total = dao.total(col, word);
		List<TeamDTO> list = dao.list(map);
		
		String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);
		
		request.setAttribute("list", list);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("paging", paging);
		
		return "/team/list";
	}
}