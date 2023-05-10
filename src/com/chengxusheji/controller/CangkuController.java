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
import com.chengxusheji.service.CangkuService;
import com.chengxusheji.po.Cangku;

//Cangku管理控制层
@Controller
@RequestMapping("/Cangku")
public class CangkuController extends BaseController {

    /*业务层对象*/
    @Resource CangkuService cangkuService;

	@InitBinder("cangku")
	public void initBinderCangku(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("cangku.");
	}
	/*跳转到添加Cangku视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Cangku());
		return "Cangku_add";
	}

	/*客户端ajax方式提交添加仓库信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Cangku cangku, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        cangkuService.addCangku(cangku);
        message = "仓库添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询仓库信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String diqu,String cangkuName,String lianxiren,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (diqu == null) diqu = "";
		if (cangkuName == null) cangkuName = "";
		if (lianxiren == null) lianxiren = "";
		if (telephone == null) telephone = "";
		if(rows != 0)cangkuService.setRows(rows);
		List<Cangku> cangkuList = cangkuService.queryCangku(diqu, cangkuName, lianxiren, telephone, page);
	    /*计算总的页数和总的记录数*/
	    cangkuService.queryTotalPageAndRecordNumber(diqu, cangkuName, lianxiren, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = cangkuService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = cangkuService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Cangku cangku:cangkuList) {
			JSONObject jsonCangku = cangku.getJsonObject();
			jsonArray.put(jsonCangku);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询仓库信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Cangku> cangkuList = cangkuService.queryAllCangku();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Cangku cangku:cangkuList) {
			JSONObject jsonCangku = new JSONObject();
			jsonCangku.accumulate("cangkuId", cangku.getCangkuId());
			jsonCangku.accumulate("cangkuName", cangku.getCangkuName());
			jsonArray.put(jsonCangku);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询仓库信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String diqu,String cangkuName,String lianxiren,String telephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (diqu == null) diqu = "";
		if (cangkuName == null) cangkuName = "";
		if (lianxiren == null) lianxiren = "";
		if (telephone == null) telephone = "";
		List<Cangku> cangkuList = cangkuService.queryCangku(diqu, cangkuName, lianxiren, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    cangkuService.queryTotalPageAndRecordNumber(diqu, cangkuName, lianxiren, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = cangkuService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = cangkuService.getRecordNumber();
	    request.setAttribute("cangkuList",  cangkuList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("diqu", diqu);
	    request.setAttribute("cangkuName", cangkuName);
	    request.setAttribute("lianxiren", lianxiren);
	    request.setAttribute("telephone", telephone);
		return "Cangku/cangku_frontquery_result"; 
	}

     /*前台查询Cangku信息*/
	@RequestMapping(value="/{cangkuId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer cangkuId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键cangkuId获取Cangku对象*/
        Cangku cangku = cangkuService.getCangku(cangkuId);

        request.setAttribute("cangku",  cangku);
        return "Cangku/cangku_frontshow";
	}

	/*ajax方式显示仓库修改jsp视图页*/
	@RequestMapping(value="/{cangkuId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer cangkuId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键cangkuId获取Cangku对象*/
        Cangku cangku = cangkuService.getCangku(cangkuId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonCangku = cangku.getJsonObject();
		out.println(jsonCangku.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新仓库信息*/
	@RequestMapping(value = "/{cangkuId}/update", method = RequestMethod.POST)
	public void update(@Validated Cangku cangku, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			cangkuService.updateCangku(cangku);
			message = "仓库更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "仓库更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除仓库信息*/
	@RequestMapping(value="/{cangkuId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer cangkuId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  cangkuService.deleteCangku(cangkuId);
	            request.setAttribute("message", "仓库删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "仓库删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条仓库记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String cangkuIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = cangkuService.deleteCangkus(cangkuIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出仓库信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String diqu,String cangkuName,String lianxiren,String telephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(diqu == null) diqu = "";
        if(cangkuName == null) cangkuName = "";
        if(lianxiren == null) lianxiren = "";
        if(telephone == null) telephone = "";
        List<Cangku> cangkuList = cangkuService.queryCangku(diqu,cangkuName,lianxiren,telephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Cangku信息记录"; 
        String[] headers = { "仓库id","所在地区","仓库名称","仓库面积","仓库吞吐量","联系人","联系电话","仓库地址"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<cangkuList.size();i++) {
        	Cangku cangku = cangkuList.get(i); 
        	dataset.add(new String[]{cangku.getCangkuId() + "",cangku.getDiqu(),cangku.getCangkuName(),cangku.getMianji(),cangku.getTdl(),cangku.getLianxiren(),cangku.getTelephone(),cangku.getAddress()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Cangku.xls");//filename是下载的xls的名，建议最好用英文 
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
