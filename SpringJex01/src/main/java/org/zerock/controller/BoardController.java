package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller //@Controller어노테이션을 추가해서 스프링의 빈으로 인식할 수 있게 함
@RequestMapping("/board/*") //@RequestMapping어노테이션은 통해서 /board로 시작하는 모든 처리를 BoardController가 하도록 지정
@Log4j
@AllArgsConstructor
public class BoardController {

	//스프링 4.3 이상에서는 단일 파라미터를 받는 생성자의 경우에는 필요한 파라미터를 자동으로 주입할 수 있다.
	//@Setter(onMethod_={@Autowired}) //@AllArgsConstructor 애노테이션이 없을 경우 설정
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("called list()");
		int memberTotal = service.getTotal(cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, memberTotal));
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) { //RedirectAttributes를 파라미터로 사용하게 되면 리턴은 리다이렉트로 해야한다.
		log.info("register(BoardVO board, RedirectAttributes rttr)");
		
		log.info("==================================================================");
		log.info("register: " + board);
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(vo->log.info(vo));
		}
		log.info("==================================================================");
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list"; //리턴 시에는 'redirect:'접두어를 사용하는데 이를 이용하면 스프링 MVC가 내부적으로 response.sendRedirect()를 처리해준다.
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno")Long bno, @ModelAttribute("cri")Criteria cri, Model model) {
		log.info("get(@RequestParam(\"bno\")Long bno, Model model)");
		model.addAttribute("board",service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr, @ModelAttribute("cri")Criteria cri) {
		log.info("modify(BoardVO board, RedirectAttributes rttr)");
	
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		//Criteria클래스의 UriComponentBuilder를 사용해서 URL형태로 만들어줌
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam Long bno, RedirectAttributes rttr, @ModelAttribute("cri")Criteria cri) {
		log.info("remove(@RequestParam Long bno, RedirectAttributes rttr)");
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}		
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list" + cri.getListLink();
	}

	
}
























