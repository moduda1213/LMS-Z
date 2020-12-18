package gd.fintech.lms.student.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gd.fintech.lms.student.service.StudentReportService;
import gd.fintech.lms.vo.Report;
import gd.fintech.lms.vo.ReportSubmitAddForm;

@Controller
public class StudentReportController {
	@Autowired StudentReportService studentReportService;
	
	@GetMapping("/student/reportList/{accountId}")
	public String listReport(Model model,
			@PathVariable(name="accountId")String accountId) {
		
		List<Report> reportList = studentReportService.getReportPage(accountId);
		model.addAttribute("reportList",reportList);
		return "/student/reportList";
	}
	
	@GetMapping("/student/reportSubmitAdd/{reportNo}")
	public String addReportSubmit(Model model,
			@PathVariable(name="reportNo")int reportNo) {
		
		Report report = studentReportService.getReportOne(reportNo);
		model.addAttribute("report", report);
		return "/student/reportSubmitAdd";
	}
	
	@PostMapping("/student/reportSubmitAdd")
	public String addReportSubmit(ReportSubmitAddForm reportSubmitAddForm) {
		studentReportService.addReportSubmit(reportSubmitAddForm);
		return "redirect:/student";
	}
}
