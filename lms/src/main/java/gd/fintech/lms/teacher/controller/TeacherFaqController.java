package gd.fintech.lms.teacher.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import gd.fintech.lms.teacher.service.TeacherFaqService;
import gd.fintech.lms.vo.Faq;
import gd.fintech.lms.vo.FaqCategory;

@Controller
public class TeacherFaqController {
	@Autowired TeacherFaqService teacherFaqService;
	
	// 전체 / 카테고리별 FAQ 목록리스트 출력(페이징 코드 추가 필요)
	@RequestMapping("/teacher/faqList/{currentPage}/{faqCategory}")
	public String faqList(Model model,
						@PathVariable(value="faqCategory") String faqCategory,
						@PathVariable(value="currentPage") int currentPage) {
		// 페이징에 사용되는 변수 선언
		int rowPerPage = 5;
		int beginRow = (currentPage - 1) * rowPerPage;
		int lastPage = 0;
		int startPage = ((currentPage/11)*rowPerPage)+1;
		// faqCategory값을 받아와 해당 카테고리의 faq목록을 출력
		// 카테고리별 faq목록 개수
		int totalCountByCategory = teacherFaqService.getFaqCountByCategory(faqCategory);
		// 카테고리별 faq목록의 lastPage 구하기
		if(totalCountByCategory % rowPerPage == 0) {
			lastPage = totalCountByCategory / rowPerPage;
		}else {
			lastPage = totalCountByCategory / rowPerPage + 1;
		}
		// 해당 카테고리의 faq목록 출력 메서드 호출 및 리스트 초기화
		List<Faq> faqList = teacherFaqService.getFaqListByCategory(faqCategory, beginRow, rowPerPage);
		List<FaqCategory> category = teacherFaqService.getFaqCategoryList();
		model.addAttribute("faqList", faqList);
		model.addAttribute("currentCategory", faqCategory);
		model.addAttribute("category", category);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("lastPage", lastPage);
		
		return "teacher/faqList";
	}
	
	//검색했을 때 일치하는 FAQ 리스트 출력
	@GetMapping("/teacher/faqList/{currentPage}/{faqCategory}/{faqTitle}")
	public String faqList(Model model, 
			@PathVariable(name = "faqTitle") String faqTitle,
			@PathVariable(name = "faqCategory") String faqCategory,
			@PathVariable(name = "currentPage") int currentPage) {

		// 페이징에 사용되는 변수 선언
		int rowPerPage = 5;
		int beginRow = (currentPage - 1) * rowPerPage;
		int lastPage = 0;
		int startPage = ((currentPage/11)*rowPerPage)+1;
		// faqCategory값을 받아와 해당 카테고리의 faq목록을 출력
		// 카테고리별 faq목록 개수
		int totalCountByCategory = teacherFaqService.getFaqCountBySearch(faqTitle, faqCategory);
		// 카테고리별 faq목록의 lastPage 구하기
		if(totalCountByCategory % rowPerPage == 0) {
			lastPage = totalCountByCategory / rowPerPage;
		}else {
			lastPage = totalCountByCategory / rowPerPage + 1;
		}
		// 카테고리 별 faq 리스트
		List<Faq> faqList = teacherFaqService.getFaqListBySearch(faqCategory, faqTitle, beginRow, rowPerPage);
		// 카테고리 리스트
		List<FaqCategory> category = teacherFaqService.getFaqCategoryList();

		model.addAttribute("faqList", faqList);
		model.addAttribute("currentCategory", faqCategory);
		model.addAttribute("category", category);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("faqTitle", faqTitle);

		return "teacher/faqList";
	}
	
	// FAQ 상세보기
	@GetMapping("/teacher/faqOne/{faqNo}")
	public String faqOne(Model model,
						@PathVariable(value="faqNo") int faqNo) {
		Faq faqOne = teacherFaqService.getFaqOne(faqNo);
		model.addAttribute("faqOne", faqOne);
		
		return "teacher/faqOne";
	}
	
	// FAQ 조회수 증가
	@GetMapping("/teacher/modifyFaqCount/{faqNo}")
	public String faqOne(@PathVariable(value="faqNo") int faqNo) {
		
		teacherFaqService.modifyFaqCount(faqNo);
		
		return "redirect:/teacher/faqOne/"+faqNo;
	}
	
}
