package gd.fintech.lms.teacher.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import gd.fintech.lms.teacher.service.TeacherTestService;
import gd.fintech.lms.vo.Multiplechoice;
import gd.fintech.lms.vo.Student;
import gd.fintech.lms.vo.StudentAnswerSheet;
import gd.fintech.lms.vo.Test;

@Controller
public class TeacherTestController {
	@Autowired TeacherTestService teacherTestService;
	
	// 시험목록 출력
	// 각 강의당 시험이 하나이므로 페이징은 추가안함
	@GetMapping("/teacher/testList/{lectureNo}")
	public String testList(Model model,
							@PathVariable(value="lectureNo") int lectureNo) {
		Test test = teacherTestService.getTestList(lectureNo);
		model.addAttribute("test", test);
		
		return "teacher/testList";
	}
	
	// 시험정보(일정) 추가 폼
	@GetMapping("/teacher/addTest/{lectureNo}")
	public String addTest(@PathVariable(value="lectureNo") int lectureNo) {
		return "teacher/addTest";
	}
	
	// 시험정보(일정) 추가 액션
	@PostMapping("/teacher/addTest/{lectureNo}")
	public String addTest(Test test,
							@PathVariable(value="lectureNo") int lectureNo) {
		teacherTestService.addTest(test);
		return "redirect:/teacher/testList/"+lectureNo;
	}
	
	// 시험정보(일정) 수정 폼
	@GetMapping("/teacher/modifyTest/{lectureNo}")
	public String modifyTest(Model model,
							@PathVariable(value="lectureNo") int lectureNo) {
		Test test = teacherTestService.getTestList(lectureNo);
		model.addAttribute("test", test);
		
		return "teacher/modifyTest";
	}
	
	// 시험정보(일정) 수정 액션
	@PostMapping("/teacher/modifyTest/{lectureNo}")
	public String modifyTest(Test test,
							@PathVariable(value="lectureNo") int lectureNo) {
		teacherTestService.modifyTest(test);
		return "redirect:/teacher/testList/"+lectureNo;
	}
	
	// 시험상세보기(학생답안지, 시험문제목록 들어가있는 페이지)
	@GetMapping("/teacher/testOne/{lectureNo}")
	public String testOne(@PathVariable(value="lectureNo") int lectureNo) {
		return "teacher/testOne";
	}
	
	// 시험문제목록 출력
	@GetMapping("/teacher/testQuestionList/{lectureNo}")
	public String teacherQuestionList(Model model,
										@PathVariable(value="lectureNo") int lectureNo) {
		List<Multiplechoice> multiplechoice = teacherTestService.getTestQuestionList(lectureNo); 
		// System.out.println(multiplechoice);
		model.addAttribute("multiplechoice", multiplechoice);
		return "teacher/testQuestionList";
	}
	
	// 시험문제 상세보기
	@GetMapping("/teacher/testQuestionOne/{multiplechoiceNo}")
	public String teacherQuestionOne(Model model,
									@PathVariable(value="multiplechoiceNo") int multiplechoiceNo) {
		Multiplechoice testOne = teacherTestService.getTestQuestionOne(multiplechoiceNo);
		model.addAttribute("testOne", testOne);
		return "teacher/testQuestionOne";
	}
	
	// 시험문제 추가 폼
	@GetMapping("/teacher/addTestQuestion/{lectureNo}")
	public String addTestQuestion(@PathVariable(value="lectureNo") int lectureNo) {
		return "teacher/addTestQuestion";
	}
	
	
	// 시험문제 추가 액션
	@PostMapping("/teacher/addTestQuestion/{lectureNo}")
	public String addTestQuestion(Multiplechoice multiplechoice,
								@PathVariable(value="lectureNo") int lectureNo) {
		// System.out.println(multiplechoice);
		teacherTestService.addTestQuestion(multiplechoice);
		return "redirect:/teacher/testQuestionList/"+lectureNo;
	}
	
	// 시험문제 수정 폼
	@GetMapping("/teacher/modifyTestQuestion/{multiplechoiceNo}")
	public String modifyTestQuestion(Model model,
									@PathVariable(value="multiplechoiceNo") int multiplechoiceNo) {
		Multiplechoice testOne = teacherTestService.getTestQuestionOne(multiplechoiceNo);
		// System.out.println(testOne);
		model.addAttribute("testOne", testOne);
		return "teacher/modifyTestQuestion";
	}
	
	// 시험문제 수정 액션
	@PostMapping("/teacher/modifyTestQuestion/{multiplechoiceNo}")
	public String modifyTestQuestion(Multiplechoice multiplechoice,
									@PathVariable(value="multiplechoiceNo") int multiplechoiceNo) {
		System.out.println("multiplechocie : " + multiplechoice);
		teacherTestService.modifyTestQuestion(multiplechoice);
		return "redirect:/teacher/testQuestionOne/"+multiplechoiceNo;
	}
	
	// 시험문제 / 보기 삭제
	@GetMapping("/teacher/removeTestQuestion/{lectureNo}/{multiplechoiceNo}")
	public String removeTestQuestion(@PathVariable(value="multiplechoiceNo") int multiplechoiceNo,
									@PathVariable(value="lectureNo") int lectureNo) {
		// 목록으로 redirect 해주기위해 lectureNo을 받아옴
		teacherTestService.removeTestQuestion(multiplechoiceNo);
		return "redirect:/teacher/testQuestionList/"+lectureNo;
	}
	
	// 수강중인 학생 목록 조회(답안지 제출 여부 확인)
	@GetMapping("/teacher/studentListByTest/{lectureNo}")
	public String studentListByTest(Model model,
										@PathVariable(value="lectureNo") int lectureNo) {
		List<StudentAnswerSheet> list = teacherTestService.getStudentByLecture(lectureNo);
		// System.out.println(list);
		model.addAttribute("list", list);
		return "teacher/studentListByTest";
	}
	
	// 해당 강의를 수강중인 학생의 답안지 조회
	@GetMapping("/teacher/answerSheet/{lectureNo}/{studentId}")
	public String answerSheetByStudent(Model model,
										@PathVariable(value="lectureNo") int lectureNo,
										@PathVariable(value="studentId") String studentId) {
		// 학생 이름 출력
		Student name = teacherTestService.getStudentName(studentId);
		// 학생 아이디에 해당하는 답안지와 점수 출력
		List<StudentAnswerSheet> answerSheet = teacherTestService.getAnswerSheetByStudent(lectureNo, studentId);
		model.addAttribute("name", name);
		model.addAttribute("answerSheet", answerSheet);
		return "teacher/answerSheet";
	}
}
