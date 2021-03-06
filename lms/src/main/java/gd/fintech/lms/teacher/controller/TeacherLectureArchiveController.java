package gd.fintech.lms.teacher.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import gd.fintech.lms.teacher.service.TeacherLectureArchiveService;
import gd.fintech.lms.vo.Lecture;
import gd.fintech.lms.vo.LectureArchive;
import gd.fintech.lms.vo.LectureArchiveAddForm;
import gd.fintech.lms.vo.Student;
import gd.fintech.lms.vo.Teacher;


@Controller
public class TeacherLectureArchiveController {
	@Autowired TeacherLectureArchiveService teacherLectureArchiveService;
	private static String OS = System.getProperty("os.name").toLowerCase();
	
	@GetMapping("/teacher/lectureArchiveList/{accountId}/{lectureNo}/{currentPage}")
	public String listLectureArchive(Model model,
			@PathVariable(name="accountId")String accountId,
			@PathVariable(name="lectureNo")int lectureNo,
			@PathVariable(name="currentPage")int currentPage) {
		int rowPerPage=5;
		List<LectureArchive> lectureArchiveList = teacherLectureArchiveService.getLectureArchiveList(currentPage, rowPerPage, accountId);
		
		int listUnderPerPage = 10;	
		int listUnderFirstPage = currentPage - (currentPage % listUnderPerPage) + 1;
		int listUnderLastPage = listUnderFirstPage + listUnderPerPage - 1;
		
		if (currentPage % listUnderPerPage == 0 && currentPage != 0) {
			listUnderFirstPage = listUnderFirstPage - listUnderPerPage;
			listUnderLastPage = listUnderLastPage - listUnderPerPage;
		}
		
		int totalArchive = teacherLectureArchiveService.listCountLectureArchive(accountId);
		int lastPage = totalArchive/rowPerPage;
		if(totalArchive % rowPerPage !=0) {
			lastPage +=1;
		}
		model.addAttribute("listUnderPerPage",listUnderPerPage);
		model.addAttribute("listUnderFirstPage",listUnderFirstPage);
		model.addAttribute("listUnderLastPage",listUnderLastPage);
		model.addAttribute("lastPage",lastPage);
		model.addAttribute("listCurrentPage",currentPage);
		model.addAttribute("lectureArchiveList",lectureArchiveList);
		model.addAttribute("lectureNo",lectureNo);
		return "/teacher/lectureArchiveList";
	}
	
	@GetMapping("/teacher/lectureArchiveSearch/{accountId}/{lectureArchiveTitle}/{currentPage}")
	public String searchLectureArchive(Model model,
			@PathVariable(name="accountId")String accountId,
			@PathVariable(name="lectureArchiveTitle")String lectureArchiveTitle,
			@PathVariable(name="currentPage")int currentPage) {
		
		int rowPerPage=5;
		List<LectureArchive> lectureArchiveList = teacherLectureArchiveService.getLectureArchiveSearchList(currentPage, rowPerPage, accountId, lectureArchiveTitle);
		int searchCount = teacherLectureArchiveService.searchCountLectureArchive(accountId, lectureArchiveTitle);
		int searchUnderPerPage = 10;	
		int searchUnderFirstPage = currentPage - (currentPage % searchUnderPerPage) + 1;
		int searchUnderLastPage = searchUnderFirstPage + searchUnderPerPage - 1;
		
		if (currentPage % searchUnderPerPage == 0 && currentPage != 0) {
			searchUnderFirstPage = searchUnderFirstPage - searchUnderPerPage;
			searchUnderLastPage = searchUnderLastPage - searchUnderPerPage;
		}
		
		int lastPage = searchCount/rowPerPage;
		if(searchCount % rowPerPage !=0) {
			lastPage +=1;
		}
		model.addAttribute("searchUnderPerPage",searchUnderPerPage);
		model.addAttribute("searchUnderFirstPage",searchUnderFirstPage);
		model.addAttribute("searchUnderLastPage",searchUnderLastPage);
		model.addAttribute("searchLastPage",lastPage);
		model.addAttribute("searchCurrentPage",currentPage);
		model.addAttribute("lectureArchiveTitle",lectureArchiveTitle);
		model.addAttribute("lectureArchiveList",lectureArchiveList);
		return "/teacher/lectureArchiveList";
	}
	
	@GetMapping("/teacher/lectureArchiveAdd/{accountId}/{lectureNo}")
	public String addLectureArchive(Model model,
			@PathVariable(name="accountId")String accountId,
			@PathVariable(name="lectureNo")int lectureNo) {
		List<Lecture> lectureList = teacherLectureArchiveService.getLectureList(accountId);
		Teacher teacher = teacherLectureArchiveService.getTeacherName(accountId);
		model.addAttribute("teacher", teacher);
		model.addAttribute("lectureList", lectureList);
		model.addAttribute("lectureNo", lectureNo);
		return "/teacher/lectureArchiveAdd";
	}
	
	@PostMapping("/teacher/lectureArchiveAdd/{lectureNo}")
	public String addLectureArchive(LectureArchiveAddForm lectureArchiveAddForm,
			@RequestParam(value="teacherId")String teacherId,
			@PathVariable(name="lectureNo")int lectureNo) {
		teacherLectureArchiveService.addLectureArchive(lectureArchiveAddForm);
		String title = lectureArchiveAddForm.getLectureArchiveTitle().replaceAll("<(/)?([a-zA-Z]*)(\\\\s[a-zA-Z]*=[^>]*)?(\\\\s)*(/)?>", "");
		lectureArchiveAddForm.setLectureArchiveTitle(title);
		String content = lectureArchiveAddForm.getLectureArchiveContent().replaceAll("<(/)?([a-zA-Z]*)(\\\\s[a-zA-Z]*=[^>]*)?(\\\\s)*(/)?>", "");
		lectureArchiveAddForm.setLectureArchiveContent(content);
		return "redirect:/teacher/lectureArchiveList/"+teacherId+"/{lectureNo}/1";
	}
	
	@GetMapping("/teacher/lectureArchiveCountUp/{accountId}/{lectureNo}/{lectureArchiveNo}")
	public String CountUplectureArchive(
			@PathVariable(name="accountId")String accountId,
			@PathVariable(name="lectureNo")int lectureNo,
			@PathVariable(name="lectureArchiveNo")int lectureArchiveNo) {
		teacherLectureArchiveService.upCountLectureArchive(lectureArchiveNo);
		return "redirect:/teacher/lectureArchiveOne/{accountId}/{lectureNo}/{lectureArchiveNo}";
	}
	
	@GetMapping("/teacher/lectureArchiveOne/{accountId}/{lectureNo}/{lectureArchiveNo}")
	public String oneLectureArchive(Model model,
			@PathVariable(name="accountId")String accountId,
			@PathVariable(name="lectureNo")int lectureNo,
			@PathVariable(name="lectureArchiveNo")int lectureArchiveNo) {
		LectureArchive lectureArchive = teacherLectureArchiveService.getLectureArchiveOne(lectureArchiveNo);
		Lecture lecture = teacherLectureArchiveService.getLectureName(accountId, lectureNo);
		model.addAttribute("lecture", lecture);
		model.addAttribute("lectureArchive", lectureArchive);
		return "/teacher/lectureArchiveListOne";
	}
	
	@GetMapping("/teacher/lectureArchiveModify/{accountId}/{lectureNo}/{lectureArchiveNo}")
	public String modifylectureArchive(Model model,
			@PathVariable(name="lectureArchiveNo")int lectureArchiveNo,
			@PathVariable(name="accountId")String accountId,
			@PathVariable(name="lectureNo")int lectureNo) {
		List<Lecture> lectureList = teacherLectureArchiveService.getLectureList(accountId);
		LectureArchive lectureArchive = teacherLectureArchiveService.getLectureArchiveOne(lectureArchiveNo);
		model.addAttribute("lectureArchive", lectureArchive);
		model.addAttribute("lectureArchiveNo", lectureArchiveNo);
		model.addAttribute("lectureList", lectureList);
		model.addAttribute("lectureNo", lectureNo);
		
		return "/teacher/lectureArchiveModify";
	}
	
	@PostMapping("/teacher/lectureArchiveModify/{accountId}/{lectureNo}/{lectureArchiveNo}")
	public String modifylectureArchive(LectureArchiveAddForm lectureArchiveAddForm,
			@PathVariable(name="accountId")String accountId,
			@PathVariable(name="lectureNo")int lectureNo,
			@PathVariable(name="lectureArchiveNo")int lectureArchiveNo) {
		teacherLectureArchiveService.updateLectureArchive(lectureArchiveAddForm);
		return "redirect:/teacher/lectureArchiveOne/{accountId}/{lectureNo}/{lectureArchiveNo}";
	}
	
	
	@GetMapping("/teacher/lectureArchiveOneFileRemove/{lectureArchiveFileUuid}/{lectureArchiveNo}/{accountId}/{lectureNo}")
	public String removeLectureArchiveOneFile(@PathVariable(name="lectureArchiveFileUuid")String lectureArchiveFileUuid,
			@PathVariable(name="lectureArchiveNo")int lectureArchiveNo,
			@PathVariable(name="lectureNo")int lectureNo,
			@PathVariable(name="accountId")String accountId) {
		teacherLectureArchiveService.deleteLectureArchiveOneFile(lectureArchiveFileUuid);
		return "redirect:/teacher/lectureArchiveModify/{accountId}/{lectureNo}/{lectureArchiveNo}";
	}
	@GetMapping("/teacher/lectureArchiveRemove/{lectureArchiveNo}/{accountId}/{lectureNo}")
	public String removeLectureArchive(@PathVariable(name="lectureArchiveNo")int lectureArchiveNo,
			@PathVariable(name="accountId")String accountId) {
		teacherLectureArchiveService.deleteLectureArchive(lectureArchiveNo);
		return "redirect:/teacher/lectureArchiveList/{accountId}/{lectureNo}/1";
	}
	
	@GetMapping("/teacher/lectureArchiveFileCountUp/{lectureArchiveFileUuid}")
	public String CountUplectureArchiveFile(@PathVariable(name="lectureArchiveFileUuid")String lectureArchiveFileUuid) {
		teacherLectureArchiveService.upCountLectureArchiveFile(lectureArchiveFileUuid);
		return "redirect:/teacher/lectureArchiveFileDownload/{lectureArchiveFileUuid}";
	}
	
	@GetMapping("/teacher/lectureArchiveFileDownload/{lectureArchiveFileUuid}")
	public ResponseEntity<byte[]> displayFile(@PathVariable(name="lectureArchiveFileUuid")String fileName,HttpServletResponse response)throws Exception{
		String rootPath = "";
		
		String attachPath = "";
		
		if ( OS.indexOf("nux") >= 0) {
        	rootPath = "/var/lib/tomcat9/webapps/lms/";
        	attachPath = "uploadfile/lectureArchivefile/";
        } else {
            File file = new File("");
            rootPath =  file.getAbsolutePath() + "\\src\\main\\webapp\\";
            attachPath = "uploadfile\\lectureArchivefile\\";
        }
		
		File f = new File(rootPath + attachPath + fileName);
		
		// 파일을 다운로드 받기 위한 스트림
		InputStream in = null;
		ResponseEntity<byte[]> entity= null;
				
		try {
			HttpHeaders headers = new HttpHeaders();
			in = new FileInputStream(f);
							
			// 다운로드 파일 컨텐트 타입
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			response.setHeader("Content-Disposition", "attachment; filename=\""+fileName+"\"");
					
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			in.close();
		}
		return entity;
	}
	
}
