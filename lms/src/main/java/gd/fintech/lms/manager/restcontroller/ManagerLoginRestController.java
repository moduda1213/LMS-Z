package gd.fintech.lms.manager.restcontroller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import gd.fintech.lms.manager.service.ManagerLoginService;
import gd.fintech.lms.vo.Account;

@RestController
public class ManagerLoginRestController {
	@Autowired ManagerLoginService managerLoginService;
	
	@GetMapping("/managerLoginCheck")
	public Map<String, Object> managerLoginCheck(
			@RequestParam(value="accountId", required = false) String accountId,
			@RequestParam(value="accountPw", required = false) String accountPw){
		Map<String, Object> map = new HashMap<String, Object>();
		
		Account account = new Account();
		account.setAccountId(accountId);
		account.setAccountPw(accountPw);
		
		String check = managerLoginService.getAccountToManagerLogin(account);
		map.put("check", check);
		return map;
	}
	
	// 아이디, 패스워드 체크
	@GetMapping("/managerSearchToNameAndEmail")
	public Map<String, Object> getManagerToNameAndEmailByCheck(
			@RequestParam(value="managerName", required = false) String managerName,
			@RequestParam(value="managerEmail", required = false) String managerEmail){
		Map<String, Object> map = new HashMap<String, Object>();
		
		int check = managerLoginService.getManagerToNameAndEmailByCheck(managerName, managerEmail);
		
		map.put("check", check);
		
		return map;
	}
	
	// 주소의 리스트를 json으로 출력
	@GetMapping("/managerAddressSearch")
	public Map<String, Object> getAddressToSearch(
			@RequestParam(value="doro", required=false, defaultValue = "") String doro){
		
		return managerLoginService.getAddressToSearch(doro);
	}
		
	// 아이디 중복 값 체크해서 json으로 츨력
	@GetMapping("/managerOverlapId")
	public Map<String, Object> getAccountToSignupByOverlapId(
			@RequestParam(value="accountId", required=false) String accountId){
		Map<String, Object> map = new HashMap<String, Object>();
		
		int overlapId = managerLoginService.getAccountToSignupByOverlapId(accountId);
			
		map.put("overlapId", overlapId);
			
		return map;
	}
		
	// 이메일 중복 값 체크해서 json으로 출력
	@GetMapping("/managerOverlapEmail")
	public Map<String, Object> getManagerToSignupByOverLapEmail(
			@RequestParam(value="managerEmail", required=false) String managerEmail){
		Map<String, Object> map = new HashMap<String, Object>();
		
		int overlapEmail = managerLoginService.getManagerToSignupByOverLapEmail(managerEmail);
			
		map.put("overlapEmail", overlapEmail);
			
		return map;
	}
	// 휴면계정 인증 번호 보내기
	@GetMapping("/managerDormantMsg/{managerId}")
	public int getStudentDormantMsg(HttpServletRequest request,
			@PathVariable(name="managerId") String managerId) {
		int dormantMsg = 0;
		dormantMsg = Integer.parseInt(managerLoginService.getDormantMsg(managerId));
		HttpSession session = request.getSession();
		session.setAttribute("dormantMsg", dormantMsg);
		return dormantMsg;
	}
}
