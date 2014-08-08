package kr.co.Foundation.Controller;

import java.security.Principal;

import kr.co.Foundation.Service.AccountService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SampleController {
	
	@Autowired
	AccountService accountService;

	@RequestMapping(value = "management/index.jsp", method = RequestMethod.GET)
	public String index(Model model, Principal principal) {
		if(principal!=null){
			model.addAttribute("employee",accountService.getEmployee(principal.getName()));
		}
		return "Theme.index";
	}
	
	///

	@RequestMapping(value = "management/general.jsp", method = RequestMethod.GET)
	public String general() {		
		return "Theme.general";
	}

	@RequestMapping(value = "management/buttons.jsp", method = RequestMethod.GET)
	public String buttons() {		
		return "Theme.buttons";
	}


	@RequestMapping(value = "management/panels.jsp", method = RequestMethod.GET)
	public String panels() {		
		return "Theme.panels";
	}
	
	///

	@RequestMapping(value = "management/sub2.jsp", method = RequestMethod.GET)
	public String sub2(Model model){ 
		model.addAttribute("roleList",accountService.getRoleList());
		return "Theme.sub2";
	}
	

	///
	
	@RequestMapping(value = "management/calendar.jsp", method = RequestMethod.GET)
	public String calendar() {		
		return "Theme.calendar";
	}

	@RequestMapping(value = "management/gallery.jsp", method = RequestMethod.GET)
	public String gallery() {		
		return "Theme.gallery";
	}
	
	@RequestMapping(value = "management/todo_list.jsp", method = RequestMethod.GET)
	public String todo_list() {		
		return "Theme.todo_list";
	}
	
	
	///


	@RequestMapping(value = "management/blank.jsp", method = RequestMethod.GET)
	public String blank() {		
		return "blank";
	}

	@RequestMapping(value = "management/login.jsp", method = RequestMethod.GET)
	public String login() {		
		return "login";
	}

	@RequestMapping(value = "management/lock_screen.jsp", method = RequestMethod.GET)
	public String lockScreen() {		
		return "lock_screen";
	}
	
	
	///
	
	@RequestMapping(value = "management/form_component.jsp", method = RequestMethod.GET)
	public String form_component() {		
		return "Theme.form_component";
	}
	
	///
	

	@RequestMapping(value = "management/basic_table.jsp", method = RequestMethod.GET)
	public String basic_table() {		
		return "Theme.basic_table";
	}
	@RequestMapping(value = "management/responsive_table.jsp", method = RequestMethod.GET)
	public String responsive_table() {		
		return "Theme.responsive_table";
	}
	
	
	///
	

	@RequestMapping(value = "management/morris.jsp", method = RequestMethod.GET)
	public String morris() {		
		return "Theme.morris";
	}
	@RequestMapping(value = "management/chartjs.jsp", method = RequestMethod.GET)
	public String chartjs() {		
		return "Theme.chartjs";
	}
	
}
