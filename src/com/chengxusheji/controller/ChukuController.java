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
import com.chengxusheji.service.ChukuService;
import com.chengxusheji.po.Chuku;
import com.chengxusheji.service.CangkuService;
import com.chengxusheji.po.Cangku;
import com.chengxusheji.service.WorkManService;
import com.chengxusheji.po.WorkMan;
import com.chengxusheji.service.WuziService;
import com.chengxusheji.po.Wuzi;
import com.chengxusheji.service.WuziClassService;
import com.chengxusheji.po.WuziClass;

//Chuku管理控制层
@Controller
@RequestMapping("/Chuku")
public class ChukuController extends BaseController {

    /*业务层对象*/
    @Resource ChukuService chukuService;

    @Resource CangkuService cangkuService;
    @Resource WorkManService workManService;
    @Resource WuziService wuziService;
    @Resource WuziClassService wuziClassService;
	@InitBinder("wuziObj")
	public void initBinderwuziObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("wuziObj.");
	}
	@InitBinder("wuziClassObj")
	public void initBinderwuziClassObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("wuziClassObj.");
	}
	@InitBinder("cangkuObj")
	public void initBindercangkuObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("cangkuObj.");
	}
	@InitBinder("workManObj")
	public void initBinderworkManObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("workManObj.");
	}
	@InitBinder("chuku")
	public void initBinderChuku(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("chuku.");
	}
	/*跳转到添加Chuku视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Chuku());
		/*查询所有的Cangku信息*/
		List<Cangku> cangkuList = cangkuService.queryAllCangku();
		request.setAttribute("cangkuList", cangkuList);
		/*查询所有的WorkMan信息*/
		List<WorkMan> workManList = workManService.queryAllWorkMan();
		request.setAttribute("workManList", workManList);
		/*查询所有的Wuzi信息*/
		List<Wuzi> wuziList = wuziService.queryAllWuzi();
		request.setAttribute("wuziList", wuziList);
		/*查询所有的WuziClass信息*/
		List<WuziClass> wuziClassList = wuziClassService.queryAllWuziClass();
		request.setAttribute("wuziClassList", wuziClassList);
		return "Chuku_add";
	}

	/*客户端ajax方式提交添加出库信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Chuku chuku, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        chukuService.addChuku(chuku);
        message = "出库添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询出库信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("wuziObj") Wuzi wuziObj,@ModelAttribute("wuziClassObj") WuziClass wuziClassObj,@ModelAttribute("cangkuObj") Cangku cangkuObj,String chukuTime,@ModelAttribute("workManObj") WorkMan workManObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (chukuTime == null) chukuTime = "";
		if(rows != 0)chukuService.setRows(rows);
		List<Chuku> chukuList = chukuService.queryChuku(wuziObj, wuziClassObj, cangkuObj, chukuTime, workManObj, page);
	    /*计算总的页数和总的记录数*/
	    chukuService.queryTotalPageAndRecordNumber(wuziObj, wuziClassObj, cangkuObj, chukuTime, workManObj);
	    /*获取到总的页码数目*/
	    int totalPage = chukuService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = chukuService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Chuku chuku:chukuList) {
			JSONObject jsonChuku = chuku.getJsonObject();
			jsonArray.put(jsonChuku);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询出库信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Chuku> chukuList = chukuService.queryAllChuku();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Chuku chuku:chukuList) {
			JSONObject jsonChuku = new JSONObject();
			jsonChuku.accumulate("chukuId", chuku.getChukuId());
			jsonArray.put(jsonChuku);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询出库信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("wuziObj") Wuzi wuziObj,@ModelAttribute("wuziClassObj") WuziClass wuziClassObj,@ModelAttribute("cangkuObj") Cangku cangkuObj,String chukuTime,@ModelAttribute("workManObj") WorkMan workManObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (chukuTime == null) chukuTime = "";
		List<Chuku> chukuList = chukuService.queryChuku(wuziObj, wuziClassObj, cangkuObj, chukuTime, workManObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    chukuService.queryTotalPageAndRecordNumber(wuziObj, wuziClassObj, cangkuObj, chukuTime, workManObj);
	    /*获取到总的页码数目*/
	    int totalPage = chukuService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = chukuService.getRecordNumber();
	    request.setAttribute("chukuList",  chukuList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("wuziObj", wuziObj);
	    request.setAttribute("wuziClassObj", wuziClassObj);
	    request.setAttribute("cangkuObj", cangkuObj);
	    request.setAttribute("chukuTime", chukuTime);
	    request.setAttribute("workManObj", workManObj);
	    List<Cangku> cangkuList = cangkuService.queryAllCangku();
	    request.setAttribute("cangkuList", cangkuList);
	    List<WorkMan> workManList = workManService.queryAllWorkMan();
	    request.setAttribute("workManList", workManList);
	    List<Wuzi> wuziList = wuziService.queryAllWuzi();
	    request.setAttribute("wuziList", wuziList);
	    List<WuziClass> wuziClassList = wuziClassService.queryAllWuziClass();
	    request.setAttribute("wuziClassList", wuziClassList);
		return "Chuku/chuku_frontquery_result"; 
	}

     /*前台查询Chuku信息*/
	@RequestMapping(value="/{chukuId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer chukuId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键chukuId获取Chuku对象*/
        Chuku chuku = chukuService.getChuku(chukuId);

        List<Cangku> cangkuList = cangkuService.queryAllCangku();
        request.setAttribute("cangkuList", cangkuList);
        List<WorkMan> workManList = workManService.queryAllWorkMan();
        request.setAttribute("workManList", workManList);
        List<Wuzi> wuziList = wuziService.queryAllWuzi();
        request.setAttribute("wuziList", wuziList);
        List<WuziClass> wuziClassList = wuziClassService.queryAllWuziClass();
        request.setAttribute("wuziClassList", wuziClassList);
        request.setAttribute("chuku",  chuku);
        return "Chuku/chuku_frontshow";
	}

	/*ajax方式显示出库修改jsp视图页*/
	@RequestMapping(value="/{chukuId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer chukuId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键chukuId获取Chuku对象*/
        Chuku chuku = chukuService.getChuku(chukuId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonChuku = chuku.getJsonObject();
		out.println(jsonChuku.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新出库信息*/
	@RequestMapping(value = "/{chukuId}/update", method = RequestMethod.POST)
	public void update(@Validated Chuku chuku, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			chukuService.updateChuku(chuku);
			message = "出库更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "出库更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除出库信息*/
	@RequestMapping(value="/{chukuId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer chukuId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  chukuService.deleteChuku(chukuId);
	            request.setAttribute("message", "出库删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "出库删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条出库记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String chukuIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = chukuService.deleteChukus(chukuIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出出库信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("wuziObj") Wuzi wuziObj,@ModelAttribute("wuziClassObj") WuziClass wuziClassObj,@ModelAttribute("cangkuObj") Cangku cangkuObj,String chukuTime,@ModelAttribute("workManObj") WorkMan workManObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(chukuTime == null) chukuTime = "";
        List<Chuku> chukuList = chukuService.queryChuku(wuziObj,wuziClassObj,cangkuObj,chukuTime,workManObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Chuku信息记录"; 
        String[] headers = { "出库id","出库物资","物资种类","重量","出库仓库","出库时间","是否完好","工作人员"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<chukuList.size();i++) {
        	Chuku chuku = chukuList.get(i); 
        	dataset.add(new String[]{chuku.getChukuId() + "",chuku.getWuziObj().getWuziName(),chuku.getWuziClassObj().getWuziClassName(),chuku.getZhongliang(),chuku.getCangkuObj().getCangkuName(),chuku.getChukuTime(),chuku.getOkFlag(),chuku.getWorkManObj().getName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Chuku.xls");//filename是下载的xls的名，建议最好用英文 
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
