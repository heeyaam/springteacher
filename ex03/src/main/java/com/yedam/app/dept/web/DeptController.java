package com.yedam.app.dept.web;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yedam.app.dept.service.DeptService;
import com.yedam.app.dept.service.DeptVO;

@Controller
public class DeptController {
	
	@Autowired
	DeptService deptService;
	
	//전체조회
	@GetMapping("deptList")
	public String deptAllList(Model model) {
		model.addAttribute("deptList", deptService.getDeptList());
		return "dept/deptList";
	}
	
	//단건조회
	@GetMapping("deptInfo")
	public String deptInfo(DeptVO deptVO, Model model) {
		DeptVO findVO = deptService.getDeptInfo(deptVO);
		model.addAttribute("deptInfo", findVO);
		return "dept/deptInfo";
	}
	
	//등록 - Form
	@GetMapping("deptInsert")
	public String deptInsertForm() {
		return "dept/deptInsert";
	}
	
	//등록 - Process
	@PostMapping("deptInsert")
	public String deptInsertProcess(DeptVO deptVO, RedirectAttributes rtt) {
		int result = deptService.insertDeptInfo(deptVO);
		String uri = null;
		String message = null;
		if(result == -1) {
			message = "정상적으로 등록되지 않았습니다.";
			uri = "deptList";
		}else {
			message = "정상적으로 등록되었습니다.\n";
			message += "부서번호 : " + result;
			uri = "deptInfo?departmentId=" + result;
		}	
		rtt.addFlashAttribute("message", message);

		return "redirect:" + uri;
	}
	
	//수정 - Process
	@PostMapping("deptUpdate")
	@ResponseBody
	public Map<String, String> deptUpdateProcess(@RequestBody DeptVO deptVO){
		return deptService.updateDeptInfo(deptVO);
	}
	
	//삭제 - Process
	@PostMapping("deptDelete")
	@ResponseBody
	public String deptDeleteProcess(@RequestParam int deptId) {
		Map<String, String> map = deptService.deleteDeptInfo(deptId);
		return map.get("결과");		
	}
	
}
