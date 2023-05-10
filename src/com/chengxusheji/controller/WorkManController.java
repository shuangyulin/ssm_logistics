package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.WorkManService;
import com.chengxusheji.po.WorkMan;

//WorkMan管理控制层
@Controller
@RequestMapping("/WorkMan")
public class WorkManController extends BaseController {

    /*业务层对象*/
    @Resource WorkManService workManService;

	@InitBinder("workMan")
	public void initBinderWorkMan(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("workMan.");
	}
	/*跳转到添加WorkMan视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new WorkMan());
		return "WorkMan_add";
	}

	/*客户端ajax方式提交添加工作人员信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated WorkMan workMan, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(workManService.getWorkMan(workMan.getWorkUserName()) != null) {
			message = "工作人员账号已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			workMan.setWorkManPhoto(this.handlePhotoUpload(request, "workManPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        workManService.addWorkMan(workMan);
        message = "工作人员添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询工作人员信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String workUserName,String name,String birthDate,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (workUserName == null) workUserName = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		if(rows != 0)workManService.setRows(rows);
		List<WorkMan> workManList = workManService.queryWorkMan(workUserName, name, birthDate, telephone, page);
	    /*计算总的页数和总的记录数*/
	    workManService.queryTotalPageAndRecordNumber(workUserName, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = workManService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = workManService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(WorkMan workMan:workManList) {
			JSONObject jsonWorkMan = workMan.getJsonObject();
			jsonArray.put(jsonWorkMan);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询工作人员信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<WorkMan> workManList = workManService.queryAllWorkMan();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(WorkMan workMan:workManList) {
			JSONObject jsonWorkMan = new JSONObject();
			jsonWorkMan.accumulate("workUserName", workMan.getWorkUserName());
			jsonWorkMan.accumulate("name", workMan.getName());
			jsonArray.put(jsonWorkMan);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询工作人员信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String workUserName,String name,String birthDate,String telephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (workUserName == null) workUserName = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		List<WorkMan> workManList = workManService.queryWorkMan(workUserName, name, birthDate, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    workManService.queryTotalPageAndRecordNumber(workUserName, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = workManService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = workManService.getRecordNumber();
	    request.setAttribute("workManList",  workManList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("workUserName", workUserName);
	    request.setAttribute("name", name);
	    request.setAttribute("birthDate", birthDate);
	    request.setAttribute("telephone", telephone);
		return "WorkMan/workMan_frontquery_result"; 
	}

     /*前台查询WorkMan信息*/
	@RequestMapping(value="/{workUserName}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String workUserName,Model model,HttpServletRequest request) throws Exception {
		/*根据主键workUserName获取WorkMan对象*/
        WorkMan workMan = workManService.getWorkMan(workUserName);

        request.setAttribute("workMan",  workMan);
        return "WorkMan/workMan_frontshow";
	}

	/*ajax方式显示工作人员修改jsp视图页*/
	@RequestMapping(value="/{workUserName}/update",method=RequestMethod.GET)
	public void update(@PathVariable String workUserName,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键workUserName获取WorkMan对象*/
        WorkMan workMan = workManService.getWorkMan(workUserName);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonWorkMan = workMan.getJsonObject();
		out.println(jsonWorkMan.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新工作人员信息*/
	@RequestMapping(value = "/{workUserName}/update", method = RequestMethod.POST)
	public void update(@Validated WorkMan workMan, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String workManPhotoFileName = this.handlePhotoUpload(request, "workManPhotoFile");
		if(!workManPhotoFileName.equals("upload/NoImage.jpg"))workMan.setWorkManPhoto(workManPhotoFileName); 


		try {
			workManService.updateWorkMan(workMan);
			message = "工作人员更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "工作人员更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除工作人员信息*/
	@RequestMapping(value="/{workUserName}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String workUserName,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  workManService.deleteWorkMan(workUserName);
	            request.setAttribute("message", "工作人员删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "工作人员删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条工作人员记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String workUserNames,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = workManService.deleteWorkMans(workUserNames);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出工作人员信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String workUserName,String name,String birthDate,String telephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(workUserName == null) workUserName = "";
        if(name == null) name = "";
        if(birthDate == null) birthDate = "";
        if(telephone == null) telephone = "";
        List<WorkMan> workManList = workManService.queryWorkMan(workUserName,name,birthDate,telephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "WorkMan信息记录"; 
        String[] headers = { "工作人员账号","姓名","性别","出生日期","工作人员照片","联系电话"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<workManList.size();i++) {
        	WorkMan workMan = workManList.get(i); 
        	dataset.add(new String[]{workMan.getWorkUserName(),workMan.getName(),workMan.getGender(),workMan.getBirthDate(),workMan.getWorkManPhoto(),workMan.getTelephone()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"WorkMan.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
