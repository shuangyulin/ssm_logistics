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
import com.chengxusheji.service.RukuService;
import com.chengxusheji.po.Ruku;
import com.chengxusheji.service.CangkuService;
import com.chengxusheji.po.Cangku;
import com.chengxusheji.service.WorkManService;
import com.chengxusheji.po.WorkMan;
import com.chengxusheji.service.WuziService;
import com.chengxusheji.po.Wuzi;
import com.chengxusheji.service.WuziClassService;
import com.chengxusheji.po.WuziClass;

//Ruku管理控制层
@Controller
@RequestMapping("/Ruku")
public class RukuController extends BaseController {

    /*业务层对象*/
    @Resource RukuService rukuService;

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
	@InitBinder("ruku")
	public void initBinderRuku(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("ruku.");
	}
	/*跳转到添加Ruku视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Ruku());
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
		return "Ruku_add";
	}

	/*客户端ajax方式提交添加入库信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Ruku ruku, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        rukuService.addRuku(ruku);
        message = "入库添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询入库信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("wuziObj") Wuzi wuziObj,@ModelAttribute("wuziClassObj") WuziClass wuziClassObj,@ModelAttribute("cangkuObj") Cangku cangkuObj,String rukuTime,@ModelAttribute("workManObj") WorkMan workManObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (rukuTime == null) rukuTime = "";
		if(rows != 0)rukuService.setRows(rows);
		List<Ruku> rukuList = rukuService.queryRuku(wuziObj, wuziClassObj, cangkuObj, rukuTime, workManObj, page);
	    /*计算总的页数和总的记录数*/
	    rukuService.queryTotalPageAndRecordNumber(wuziObj, wuziClassObj, cangkuObj, rukuTime, workManObj);
	    /*获取到总的页码数目*/
	    int totalPage = rukuService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = rukuService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Ruku ruku:rukuList) {
			JSONObject jsonRuku = ruku.getJsonObject();
			jsonArray.put(jsonRuku);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询入库信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Ruku> rukuList = rukuService.queryAllRuku();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Ruku ruku:rukuList) {
			JSONObject jsonRuku = new JSONObject();
			jsonRuku.accumulate("rukuId", ruku.getRukuId());
			jsonArray.put(jsonRuku);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询入库信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("wuziObj") Wuzi wuziObj,@ModelAttribute("wuziClassObj") WuziClass wuziClassObj,@ModelAttribute("cangkuObj") Cangku cangkuObj,String rukuTime,@ModelAttribute("workManObj") WorkMan workManObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (rukuTime == null) rukuTime = "";
		List<Ruku> rukuList = rukuService.queryRuku(wuziObj, wuziClassObj, cangkuObj, rukuTime, workManObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    rukuService.queryTotalPageAndRecordNumber(wuziObj, wuziClassObj, cangkuObj, rukuTime, workManObj);
	    /*获取到总的页码数目*/
	    int totalPage = rukuService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = rukuService.getRecordNumber();
	    request.setAttribute("rukuList",  rukuList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("wuziObj", wuziObj);
	    request.setAttribute("wuziClassObj", wuziClassObj);
	    request.setAttribute("cangkuObj", cangkuObj);
	    request.setAttribute("rukuTime", rukuTime);
	    request.setAttribute("workManObj", workManObj);
	    List<Cangku> cangkuList = cangkuService.queryAllCangku();
	    request.setAttribute("cangkuList", cangkuList);
	    List<WorkMan> workManList = workManService.queryAllWorkMan();
	    request.setAttribute("workManList", workManList);
	    List<Wuzi> wuziList = wuziService.queryAllWuzi();
	    request.setAttribute("wuziList", wuziList);
	    List<WuziClass> wuziClassList = wuziClassService.queryAllWuziClass();
	    request.setAttribute("wuziClassList", wuziClassList);
		return "Ruku/ruku_frontquery_result"; 
	}

     /*前台查询Ruku信息*/
	@RequestMapping(value="/{rukuId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer rukuId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键rukuId获取Ruku对象*/
        Ruku ruku = rukuService.getRuku(rukuId);

        List<Cangku> cangkuList = cangkuService.queryAllCangku();
        request.setAttribute("cangkuList", cangkuList);
        List<WorkMan> workManList = workManService.queryAllWorkMan();
        request.setAttribute("workManList", workManList);
        List<Wuzi> wuziList = wuziService.queryAllWuzi();
        request.setAttribute("wuziList", wuziList);
        List<WuziClass> wuziClassList = wuziClassService.queryAllWuziClass();
        request.setAttribute("wuziClassList", wuziClassList);
        request.setAttribute("ruku",  ruku);
        return "Ruku/ruku_frontshow";
	}

	/*ajax方式显示入库修改jsp视图页*/
	@RequestMapping(value="/{rukuId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer rukuId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键rukuId获取Ruku对象*/
        Ruku ruku = rukuService.getRuku(rukuId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonRuku = ruku.getJsonObject();
		out.println(jsonRuku.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新入库信息*/
	@RequestMapping(value = "/{rukuId}/update", method = RequestMethod.POST)
	public void update(@Validated Ruku ruku, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			rukuService.updateRuku(ruku);
			message = "入库更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "入库更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除入库信息*/
	@RequestMapping(value="/{rukuId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer rukuId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  rukuService.deleteRuku(rukuId);
	            request.setAttribute("message", "入库删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "入库删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条入库记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String rukuIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = rukuService.deleteRukus(rukuIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出入库信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("wuziObj") Wuzi wuziObj,@ModelAttribute("wuziClassObj") WuziClass wuziClassObj,@ModelAttribute("cangkuObj") Cangku cangkuObj,String rukuTime,@ModelAttribute("workManObj") WorkMan workManObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(rukuTime == null) rukuTime = "";
        List<Ruku> rukuList = rukuService.queryRuku(wuziObj,wuziClassObj,cangkuObj,rukuTime,workManObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Ruku信息记录"; 
        String[] headers = { "入库id","入库物资","物资种类","重量","入库仓库","入库时间","是否完好","工作人员"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<rukuList.size();i++) {
        	Ruku ruku = rukuList.get(i); 
        	dataset.add(new String[]{ruku.getRukuId() + "",ruku.getWuziObj().getWuziName(),ruku.getWuziClassObj().getWuziClassName(),ruku.getZhongliang(),ruku.getCangkuObj().getCangkuName(),ruku.getRukuTime(),ruku.getOkFlag(),ruku.getWorkManObj().getName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Ruku.xls");//filename是下载的xls的名，建议最好用英文 
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
