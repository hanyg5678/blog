package spring.sts.blog;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.model.imgbbs.ImgbbsDTO;
import spring.model.imgbbs.ImgbbsDAO;
import spring.utility.blog.Utility;

@Controller
public class ImgbbsConroller {
	@Autowired
	private ImgbbsDAO dao;
	
	@RequestMapping(value="/imgbbs/delete", method=RequestMethod.POST)
	public String delete(int no, Model model, String col, String word, String nowPage, String oldfile, HttpServletRequest request, String passwd) {
		String upDir = request.getRealPath("/imgbbs/storage");
		Map map = new HashMap();
		map.put("no", no);
		map.put("passwd", passwd);
		boolean pflag = dao.passCheck(map);
		if(pflag) {
			if(dao.delete(no))Utility.deleteFile(upDir, oldfile);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			model.addAttribute("nowPage", nowPage);
			
			return "redirect:./list";
		} else {
			return "passwdError";
		}
	}
	
	@RequestMapping(value="/imgbbs/delete", method=RequestMethod.GET)
	public String delete(int no, Model model) {
		model.addAttribute("flag", dao.chechRefno(no));
		
		return "/imgbbs/delete";
	}
	
	@RequestMapping(value="/imgbbs/reply", method=RequestMethod.POST)
	public String reply(HttpServletRequest request, ImgbbsDTO dto, String col, String word, String nowPage, Model model) {
		String basePath = request.getRealPath("imgbbs/storage");
		int filesize = (int)dto.getFileMF().getSize();
		String filename = "";
		if(filesize > 0) {
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}
		
		dto.setFilename(filename);
		dto.setFilesize(filesize);
		dao.addAnsnum(dto.getGrpno(), dto.getAnsnum());
		
		boolean flag = dao.createreply(dto);
		if(flag) {
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			model.addAttribute("nowPage", nowPage);
			return "redirect:./list";
		} else {
			return "error";
		}
	}
	
	@RequestMapping(value="/imgbbs/reply", method=RequestMethod.GET)
	public String reply(Model model, int no) {
		model.addAttribute("dto", dao.readReply(no));
		
		return "/imgbbs/reply";
	}
	
	@RequestMapping(value="/imgbbs/update", method=RequestMethod.POST)
	public String update(Model model, String col, String word, String nowPage, HttpServletRequest request, ImgbbsDTO dto, String oldfile) {
		String basePath = request.getRealPath("/imgbbs/storage");
		int filesize = (int)dto.getFileMF().getSize();
		String filename = "";
		if(filesize > 0) {
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}
		
		dto.setFilename(filename);
		dto.setFilesize(filesize);
		
		Map map = new HashMap();
		map.put("no", dto.getNo());
		map.put("passwd", dto.getPasswd());
		boolean pflag = dao.passCheck(map);
		if(pflag) {
			if(dao.update(dto)) {
				Utility.deleteFile(basePath, oldfile);
				model.addAttribute("col", col);
				model.addAttribute("word", word);
				model.addAttribute("nowPage", nowPage);
				return "redirect:./list";
			} else {
				return "error";
			} 
		}else {
			if(filesize>0) Utility.deleteFile(basePath, filename);
			return "passwdError";
		}
	}
	
	@RequestMapping(value="/imgbbs/update", method=RequestMethod.GET)
	public String update(int no, Model model) {
		model.addAttribute("dto", dao.read(no));
		return "/imgbbs/update";
	}
	
	@RequestMapping("/imgbbs/read")
	public String read(Model model, String col, String word, int no, String nowPage, HttpServletRequest request) {
		ImgbbsDTO dto = dao.read(no);
		Map map = dao.imgRead(no);
		
		BigDecimal[] noArr = {((BigDecimal)map.get("PRE_NO2")), 
		((BigDecimal)map.get("PRE_NO1")),
		((BigDecimal)map.get("NO")),
		((BigDecimal)map.get("NEX_NO1")),
		((BigDecimal)map.get("NEX_NO2"))
		};

		String[] files = {
		((String)map.get("PRE_FILE2")),
		((String)map.get("PRE_FILE1")),
		((String)map.get("FILENAME")),
		((String)map.get("NEX_FILE1")),
		((String)map.get("NEX_FILE2"))
		};

		String content = dto.getContent();
		content = content.replaceAll("\r\n", "<br>");

		model.addAttribute("col", col);
		model.addAttribute("word", word);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("dto", dto);
		model.addAttribute("no", no);
		model.addAttribute("files", files);
		model.addAttribute("noArr", noArr);

		return "/imgbbs/read";
	}
	
	@RequestMapping(value="/imgbbs/create", method=RequestMethod.POST)
	public String create(HttpServletRequest request, ImgbbsDTO dto) {
		String basePath = request.getRealPath("imgbbs/storage");
		int filesize = (int)dto.getFileMF().getSize();
		String filename = "";
		if(filesize > 0) {
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}
		
		dto.setFilename(filename);
		dto.setFilesize(filesize);
		
		boolean flag = dao.create(dto);
		if(flag) {
			return "redirect:./list";
		} else {
			return "error";
		}
	}
	
	@RequestMapping(value="/imgbbs/create", method=RequestMethod.GET)
	public String create() {
		
		return "/imgbbs/create";
	}
	
	@RequestMapping("/imgbbs/list")
	public String list(HttpServletRequest request) {
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		if(col.equals("total")){
			word="";
		}
		//페이징관련
		int nowPage = 1;
		int recordPerPage = 5;
		if(request.getParameter("nowPage")!=null){
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		
		int sno = ((nowPage-1)*recordPerPage)+1;
		int eno = nowPage*recordPerPage;
		
		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);
		
		int total = dao.total(col, word);
		List<ImgbbsDTO> list = dao.list(map);
		
		
		String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);
		
		request.setAttribute("paging", paging);
		request.setAttribute("list", list);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);
				
		return "/imgbbs/list";
	}
}