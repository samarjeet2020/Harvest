package com.sam.ams.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sam.ams.component.AMSMasterComponent;
import com.sam.ams.component.AMSMasterComponentImpl;
import com.sam.ams.component.CustomerDetailBean;
import com.sam.ams.component.DataTableGridBean;
import com.sam.ams.component.LoginComponent;
import com.sam.ams.component.LoginComponentImpl;
import com.sam.ams.component.MenuComponentImpl;
import com.sam.ams.dto.MenuDTO;
import com.sam.ams.dto.PocTable;
import com.sam.ams.entity.BillingDetail;
import com.sam.ams.entity.CustomerBillingInfo;
import com.sam.ams.entity.CustomerInfo;
import com.sam.ams.entity.Employee;
import com.sam.ams.entity.LuRateSlab;
import com.sam.ams.service.ParkingLookupService;
import com.sam.ams.service.UserTrayService;
import com.sam.ams.service.impl.ParkingLookupServiceImpl;
import com.sam.app.dto.AppCommonBean;
import com.sam.test.service.EmployeeService;

@Controller
public class AMSUIController {


	@Autowired
	private EmployeeService employeeService;
	 @Autowired
	 UserTrayService userTrayService;
	 @Autowired
	 ParkingLookupService parkingLookupService;

	/*@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView getData() {

		ModelAndView model = new ModelAndView("index");
	
		return model;

	}*/

	//@RequestMapping(value = "/", method = RequestMethod.GET)
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public ModelAndView loadBoozePage() 
	{
		ModelAndView modelAndView =null;
		try
		{
			AppCommonBean appCommonBean=new AppCommonBean();
			modelAndView =new ModelAndView ("AMSLogin");
			//modelAndView =new ModelAndView ("ParkingSystem");
			MenuComponentImpl menuComponentImpl=new MenuComponentImpl();
			List<MenuDTO> menuList =menuComponentImpl.boozeMenuItem(appCommonBean);
			modelAndView.addObject("menuList", menuList);
			
			
			
		}
		catch(Exception e)
		{	
			modelAndView.addObject("greeting", "Credential is  inValid.");
			modelAndView =new ModelAndView ("index");
		}
		return modelAndView;
	}
	
	public static void main (String args[]){
		AppCommonBean appCommonBean=new AppCommonBean();
		appCommonBean.setLoginid("samarjeet");
		appCommonBean.setPasswd("samarjeet123");
		
		LoginComponent loginComponent=new LoginComponentImpl();
		loginComponent.authonticateUser(appCommonBean);
	}

	@RequestMapping(value="/AMS", method = RequestMethod.POST)
	public ModelAndView  AMSModule(ModelMap model,HttpServletRequest request) {
		System.out.println("request:"+request.getParameter("iv-user"));
	
		 ModelAndView modelAndView =null;
		 try
			{
		AppCommonBean appCommonBean=new AppCommonBean();
		appCommonBean.setLoginid(request.getParameter("iv-user"));
		appCommonBean.setPasswd(request.getParameter("password"));
		LoginComponent loginComponent=new LoginComponentImpl();
		AppCommonBean outAppCommonBean=loginComponent.authonticateUser(appCommonBean);
		if(true==outAppCommonBean.getIsLogin())
		{
	    modelAndView =new ModelAndView ("ParkingSystem");
		MenuComponentImpl menuComponentImpl=new MenuComponentImpl();
		List<MenuDTO> menuList =menuComponentImpl.fetchMenu(appCommonBean);
		modelAndView.addObject("menuList", menuList);
		}
		else
		{
			modelAndView =new ModelAndView ("Booze");
			modelAndView.addObject("greeting", "Credential is  inValid.");	
		}
			}
			catch(Exception e)
			{	
				modelAndView =new ModelAndView ("Booze");
				modelAndView.addObject("greeting", "Credential is  inValid.");

			}
		return modelAndView;
	}

	
	@RequestMapping(value="/customers", method = RequestMethod.POST)
	public ModelAndView getAllCustomers(ModelMap model) {
		ModelAndView modelAndView=null;
		AMSMasterComponent AMSMasterComponent=new AMSMasterComponentImpl();
		AppCommonBean appCommonBean=new AppCommonBean();
		List<CustomerDetailBean> customersList =AMSMasterComponent.listAllCustomer(appCommonBean);
		modelAndView =new ModelAndView ("Customer");
		modelAndView.addObject("customersList", customersList);
		return modelAndView;
	}
	
	@RequestMapping(value="/atmRequestMessage", method = RequestMethod.POST)
	public ModelAndView getAllATMRequestMessage(ModelMap model) {
		ModelAndView modelAndView=null;
		
		AppCommonBean appCommonBean=new AppCommonBean();
		List<DataTableGridBean> list=userTrayService.getATMRequestMessages(appCommonBean);
		modelAndView =new ModelAndView ("ATMSwitchRequestMessage");
		modelAndView.addObject("dataTableList", list);
		return modelAndView;
	}
	
	@RequestMapping(value="/tickets", method = RequestMethod.POST)
	public ModelAndView getTickets(ModelMap model) {
		ModelAndView modelAndView=null;
		
		AppCommonBean appCommonBean=new AppCommonBean();
		List<DataTableGridBean> list=userTrayService.getTickets(appCommonBean);
		modelAndView =new ModelAndView ("Tikets");
		modelAndView.addObject("dataTableList", list);
		return modelAndView;
	}
	
	@RequestMapping(value="/dispatchTikets", method = RequestMethod.POST)
	public ModelAndView getDispatchTickets(ModelMap model) {
		ModelAndView modelAndView=null;
		
		AppCommonBean appCommonBean=new AppCommonBean();
		appCommonBean.setRole("1");
		List<DataTableGridBean> list=userTrayService.getTickets(appCommonBean);
		modelAndView =new ModelAndView ("DispatchTicktes");
		modelAndView.addObject("dataTableList", list);
		return modelAndView;
	}
	
	@RequestMapping(value="/dashBoard", method = RequestMethod.POST)
	public ModelAndView openDashBoard(ModelMap model) {
		ModelAndView modelAndView=null;
	
		AppCommonBean appCommonBean=new AppCommonBean();
		List<DataTableGridBean> list=userTrayService.getATMRequestMessages(appCommonBean);
		modelAndView =new ModelAndView ("DashBoard");
		modelAndView.addObject("dataTableList", list);
		


		return modelAndView;
	}

	/**
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/employees", method = RequestMethod.POST)
	public ModelAndView employeeList(ModelMap model) {
ModelAndView modelAndView=null;
		
		AppCommonBean appCommonBean=new AppCommonBean();
		List<DataTableGridBean> list=userTrayService.getEmployeeList(appCommonBean);
		modelAndView =new ModelAndView ("EmployeeList");
		modelAndView.addObject("dataTableList", list);
		return modelAndView;
	}
	
	

	@RequestMapping(value = "addEmployees", method = RequestMethod.POST)
	public ModelAndView viewRegister(@ModelAttribute Employee employee) {
		return new ModelAndView("register");
	}

	@RequestMapping(value = "register", method = RequestMethod.POST)
	public ModelAndView createUser(@ModelAttribute Employee employee) {
		employee.setLogedIn("Y");
		employeeService.createEmployee(employee);
		ModelAndView modelAndView = null;
		modelAndView =new ModelAndView ("ParkingSystem");
		AppCommonBean appCommonBean=new AppCommonBean();
		MenuComponentImpl menuComponentImpl=new MenuComponentImpl();
		List<MenuDTO> menuList =menuComponentImpl.fetchMenu(appCommonBean);
		modelAndView.addObject("menuList", menuList);
		return modelAndView;
	}

	

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public ModelAndView processLogin(@ModelAttribute Employee employee) {
		Employee emp = employeeService.getEmployee(employee);
		ModelAndView modelAndView = null;
		if (emp == null) {
			modelAndView =new ModelAndView ("AMSLogin");
			modelAndView.addObject("errorMessage", "*Invalid credential!!");
		} else {
			modelAndView =new ModelAndView ("ParkingSystem");
			modelAndView.addObject("emp", emp.getName());
			AppCommonBean appCommonBean=new AppCommonBean();
			appCommonBean.setLoginid(emp.getUsername());
			appCommonBean.setPasswd(emp.getPassword());
			MenuComponentImpl menuComponentImpl=new MenuComponentImpl();
			List<MenuDTO> menuList =menuComponentImpl.fetchMenu(appCommonBean);
			modelAndView.addObject("menuList", menuList);
		}
		return modelAndView;
	}


	@RequestMapping(value="/billingDetail", method = RequestMethod.POST)
	public ModelAndView getParkingStatusGriddata(ModelMap model) {
		ModelAndView modelAndView=null;
		modelAndView =new ModelAndView ("ParkingStatusDetail");
		AppCommonBean appCommonBean=new AppCommonBean();
		List<com.sam.ams.bean.CustomerDetailBean> list=userTrayService.getCustomerList(appCommonBean);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			String jsonInString = mapper.writeValueAsString(list);
			modelAndView.addObject("customerList", list);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		LuRateSlab luRateSlab=new LuRateSlab();
		List<LuRateSlab> rateList=parkingLookupService.fetchRateSlabList(luRateSlab);
		modelAndView.addObject("rateList", rateList);
		BillingDetail v=new BillingDetail();
		List<BillingDetail > dataTableList=userTrayService.getBillingDetail(v);
		modelAndView.addObject("dataTableList", dataTableList);
		return modelAndView;
	}
	
	@RequestMapping(value="/addBillingDetail", method = RequestMethod.POST)
	public ModelAndView addBillingDetail(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView=null;
		
		
		System.out.println(request.getParameter("customerName"));
		System.out.println(request.getParameter("customerID"));
		System.out.println(request.getParameter("amount"));
		System.out.println(request.getParameter("remarks"));
		System.out.println(request.getParameter("workType"));
		System.out.println(request.getParameter("totalUnit"));
		System.out.println(request.getParameter("chargePerUnit"));
		modelAndView =new ModelAndView ("ParkingStatusDetail");
		//modelAndView.addObject("dataTableList", list);
		BillingDetail billingDetail=new BillingDetail();
		billingDetail.setCustomerID(request.getParameter("customerID"));
		billingDetail.setCustomerName(request.getParameter("customerName"));
		billingDetail.setChargePerUnit(Integer.parseInt(request.getParameter("chargePerUnit")));
		billingDetail.setTotalChargeAfterDiscount(Integer.parseInt(request.getParameter("amount")));
		billingDetail.setTotalUnit(request.getParameter("totalUnit"));
		billingDetail.setRemarks(request.getParameter("remarks"));
		userTrayService.addBillingDetail( billingDetail);
		
		
		
		
		AppCommonBean appCommonBean=new AppCommonBean();
		List<com.sam.ams.bean.CustomerDetailBean> list=userTrayService.getCustomerList(appCommonBean);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			String jsonInString = mapper.writeValueAsString(list);
			modelAndView.addObject("customerList", list);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		LuRateSlab luRateSlab=new LuRateSlab();
		List<LuRateSlab> rateList=parkingLookupService.fetchRateSlabList(luRateSlab);
		modelAndView.addObject("rateList", rateList);
		BillingDetail v=new BillingDetail();
		List<BillingDetail > dataTableList=userTrayService.getBillingDetail(v);
		modelAndView.addObject("dataTableList", dataTableList);
		return modelAndView;
	}
	

	
	
}
