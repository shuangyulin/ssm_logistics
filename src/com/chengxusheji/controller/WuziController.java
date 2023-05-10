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
import com.chengxusheji.service.WuziService;
import com.chengxusheji.po.Wuzi;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.service.WuziClassService;
import com.chengxusheji.po.WuziClass;

//Wuzi管理控制层
@Controller
@RequestMapping("/Wuzi")
public class WuziController extends BaseController {

    /*业务层对象*/
    @Resource WuziService wuziService;

    @Resource UserInfoService userInfoService;
    @Resource WuziClassService wuziClassService;
	@InitBinder("wuziClassObj")
	public void initBinderwuziClassObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("wuziClassObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("receiveUserObj")
	public void initBinderreceiveUserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("receiveUserObj.");
	}
	@InitBinder("wuzi")
	public void initBinderWuzi(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("wuzi.");
	}
	/*跳转到添加Wuzi视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Wuzi());
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		/*查询所有的WuziClass信息*/
		List<WuziClass> wuziClassList = wuziClassService.queryAllWuziClass();
		request.setAttribute("wuziClassList", wuziClassList);
		return "Wuzi_add";
	}

	/*客户端ajax方式提交添加物资信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Wuzi wuzi, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(wuziService.getWuzi(wuzi.getWuliuNo()) != null) {
			message = "物流单号已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
        wuziService.addWuzi(wuzi);
        message = "物资添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询物资信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String wuliuNo,@ModelAttribute("wuziClassObj") WuziClass wuziClassObj,String wuziName,@ModelAttribute("userObj") UserInfo userObj,String sendTelephone,String sendAddress,@ModelAttribute("receiveUserObj") UserInfo receiveUserObj,String receiveTelephone,String receiveAddress,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (wuliuNo == null) wuliuNo = "";
		if (wuziName == null) wuziName = "";
		if (sendTelephone == null) sendTelephone = "";
		if (sendAddress == null) sendAddress = "";
		if (receiveTelephone == null) receiveTelephone = "";
		if (receiveAddress == null) receiveAddress = "";
		if(rows != 0)wuziService.setRows(rows);
		List<Wuzi> wuziList = wuziService.queryWuzi(wuliuNo, wuziClassObj, wuziName, userObj, sendTelephone, sendAddress, receiveUserObj, receiveTelephone, receiveAddress, page);
	    /*计算总的页数和总的记录数*/
	    wuziService.queryTotalPageAndRecordNumber(wuliuNo, wuziClassObj, wuziName, userObj, sendTelephone, sendAddress, receiveUserObj, receiveTelephone, receiveAddress);
	    /*获取到总的页码数目*/
	    int totalPage = wuziService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = wuziService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Wuzi wuzi:wuziList) {
			JSONObject jsonWuzi = wuzi.getJsonObject();
			jsonArray.put(jsonWuzi);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询物资信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Wuzi> wuziList = wuziService.queryAllWuzi();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Wuzi wuzi:wuziList) {
			JSONObject jsonWuzi = new JSONObject();
			jsonWuzi.accumulate("wuliuNo", wuzi.getWuliuNo());
			jsonWuzi.accumulate("wuziName", wuzi.getWuziName());
			jsonArray.put(jsonWuzi);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询物资信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String wuliuNo,@ModelAttribute("wuziClassObj") WuziClass wuziClassObj,String wuziName,@ModelAttribute("userObj") UserInfo userObj,String sendTelephone,String sendAddress,@ModelAttribute("receiveUserObj") UserInfo receiveUserObj,String receiveTelephone,String receiveAddress,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (wuliuNo == null) wuliuNo = "";
		if (wuziName == null) wuziName = "";
		if (sendTelephone == null) sendTelephone = "";
		if (sendAddress == null) sendAddress = "";
		if (receiveTelephone == null) receiveTelephone = "";
		if (receiveAddress == null) receiveAddress = "";
		List<Wuzi> wuziList = wuziService.queryWuzi(wuliuNo, wuziClassObj, wuziName, userObj, sendTelephone, sendAddress, receiveUserObj, receiveTelephone, receiveAddress, currentPage);
	    /*计算总的页数和总的记录数*/
	    wuziService.queryTotalPageAndRecordNumber(wuliuNo, wuziClassObj, wuziName, userObj, sendTelephone, sendAddress, receiveUserObj, receiveTelephone, receiveAddress);
	    /*获取到总的页码数目*/
	    int totalPage = wuziService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = wuziService.getRecordNumber();
	    request.setAttribute("wuziList",  wuziList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("wuliuNo", wuliuNo);
	    request.setAttribute("wuziClassObj", wuziClassObj);
	    request.setAttribute("wuziName", wuziName);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("sendTelephone", sendTelephone);
	    request.setAttribute("sendAddress", sendAddress);
	    request.setAttribute("receiveUserObj", receiveUserObj);
	    request.setAttribute("receiveTelephone", receiveTelephone);
	    request.setAttribute("receiveAddress", receiveAddress);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
	    List<WuziClass> wuziClassList = wuziClassService.queryAllWuziClass();
	    request.setAttribute("wuziClassList", wuziClassList);
		return "Wuzi/wuzi_frontquery_result"; 
	}

     /*前台查询Wuzi信息*/
	@RequestMapping(value="/{wuliuNo}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String wuliuNo,Model model,HttpServletRequest request) throws Exception {
		/*根据主键wuliuNo获取Wuzi对象*/
        Wuzi wuzi = wuziService.getWuzi(wuliuNo);

        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        List<WuziClass> wuziClassList = wuziClassService.queryAllWuziClass();
        request.setAttribute("wuziClassList", wuziClassList);
        request.setAttribute("wuzi",  wuzi);
        return "Wuzi/wuzi_frontshow";
	}

	/*ajax方式显示物资修改jsp视图页*/
	@RequestMapping(value="/{wuliuNo}/update",method=RequestMethod.GET)
	public void update(@PathVariable String wuliuNo,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键wuliuNo获取Wuzi对象*/
        Wuzi wuzi = wuziService.getWuzi(wuliuNo);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonWuzi = wuzi.getJsonObject();
		out.println(jsonWuzi.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新物资信息*/
	@RequestMapping(value = "/{wuliuNo}/update", method = RequestMethod.POST)
	public void update(@Validated Wuzi wuzi, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			wuziService.updateWuzi(wuzi);
			message = "物资更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "物资更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除物资信息*/
	@RequestMapping(value="/{wuliuNo}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String wuliuNo,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  wuziService.deleteWuzi(wuliuNo);
	            request.setAttribute("message", "物资删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "物资删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条物资记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String wuliuNos,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = wuziService.deleteWuzis(wuliuNos);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出物资信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String wuliuNo,@ModelAttribute("wuziClassObj") WuziClass wuziClassObj,String wuziName,@ModelAttribute("userObj") UserInfo userObj,String sendTelephone,String sendAddress,@ModelAttribute("receiveUserObj") UserInfo receiveUserObj,String receiveTelephone,String receiveAddress, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(wuliuNo == null) wuliuNo = "";
        if(wuziName == null) wuziName = "";
        if(sendTelephone == null) sendTelephone = "";
        if(sendAddress == null) sendAddress = "";
        if(receiveTelephone == null) receiveTelephone = "";
        if(receiveAddress == null) receiveAddress = "";
        List<Wuzi> wuziList = wuziService.queryWuzi(wuliuNo,wuziClassObj,wuziName,userObj,sendTelephone,sendAddress,receiveUserObj,receiveTelephone,receiveAddress);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Wuzi信息记录"; 
        String[] headers = { "物流单号","物资分类","物资名称","物资重量","寄件人","寄件人电话","收件人","收件人电话","运费"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<wuziList.size();i++) {
        	Wuzi wuzi = wuziList.get(i); 
        	dataset.add(new String[]{wuzi.getWuliuNo(),wuzi.getWuziClassObj().getWuziClassName(),wuzi.getWuziName(),wuzi.getZhongliang(),wuzi.getUserObj().getName(),wuzi.getSendTelephone(),wuzi.getReceiveUserObj().getName(),wuzi.getReceiveTelephone(),wuzi.getYunfei() + ""});
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
			response.setHeader("Content-disposition","attachment; filename="+"Wuzi.xls");//filename是下载的xls的名，建议最好用英文 
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
