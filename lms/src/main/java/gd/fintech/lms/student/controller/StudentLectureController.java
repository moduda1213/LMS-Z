package gd.fintech.lms.student.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import gd.fintech.lms.student.service.StudentLectureService;
import gd.fintech.lms.vo.Lecture;

@Controller
public class StudentLectureController {
	@Autowired StudentLectureService studentLectureService;
	
	//페이징 처리한 전체 강의 목록 리스트
	@GetMapping("/student/lectureList/{currentPage}")
	public String lectureList(Model model,
							@PathVariable(name="currentPage") int currentPage) {
		// page당 목록 갯수
		int rowPerPage = 2;
		// 시작 목록
		int beginRow = (currentPage-1)*rowPerPage; 
		// 페이징 처리한 전체 강의 리스트
		List<Lecture> lectureList = studentLectureService.getLectureList(beginRow, rowPerPage); 
		// 전체 강의 목록 갯수
		int listTotal = studentLectureService.getLectureListTotal(); 
		// 마지막 페이지
		int lastPage = 0;
		if(listTotal%rowPerPage==1) { // 나누어 떨어지지 않는다면 페이지 + 1
			lastPage = (listTotal/rowPerPage)+1;
		}else { // 나누어 떨어진다면 
			lastPage = listTotal/rowPerPage;
		}
		model.addAttribute("lectureList",lectureList);
		model.addAttribute("lastPage",lastPage);
		return "student/lectureList";
	}
}