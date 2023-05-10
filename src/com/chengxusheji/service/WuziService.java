package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.WuziClass;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Wuzi;

import com.chengxusheji.mapper.WuziMapper;
@Service
public class WuziService {

	@Resource WuziMapper wuziMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加物资记录*/
    public void addWuzi(Wuzi wuzi) throws Exception {
    	wuziMapper.addWuzi(wuzi);
    }

    /*按照查询条件分页查询物资记录*/
    public ArrayList<Wuzi> queryWuzi(String wuliuNo,WuziClass wuziClassObj,String wuziName,UserInfo userObj,String sendTelephone,String sendAddress,UserInfo receiveUserObj,String receiveTelephone,String receiveAddress,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!wuliuNo.equals("")) where = where + " and t_wuzi.wuliuNo like '%" + wuliuNo + "%'";
    	if(null != wuziClassObj && wuziClassObj.getWuziClassId()!= null && wuziClassObj.getWuziClassId()!= 0)  where += " and t_wuzi.wuziClassObj=" + wuziClassObj.getWuziClassId();
    	if(!wuziName.equals("")) where = where + " and t_wuzi.wuziName like '%" + wuziName + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_wuzi.userObj='" + userObj.getUser_name() + "'";
    	if(!sendTelephone.equals("")) where = where + " and t_wuzi.sendTelephone like '%" + sendTelephone + "%'";
    	if(!sendAddress.equals("")) where = where + " and t_wuzi.sendAddress like '%" + sendAddress + "%'";
    	if(null != receiveUserObj &&  receiveUserObj.getUser_name() != null  && !receiveUserObj.getUser_name().equals(""))  where += " and t_wuzi.receiveUserObj='" + receiveUserObj.getUser_name() + "'";
    	if(!receiveTelephone.equals("")) where = where + " and t_wuzi.receiveTelephone like '%" + receiveTelephone + "%'";
    	if(!receiveAddress.equals("")) where = where + " and t_wuzi.receiveAddress like '%" + receiveAddress + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return wuziMapper.queryWuzi(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Wuzi> queryWuzi(String wuliuNo,WuziClass wuziClassObj,String wuziName,UserInfo userObj,String sendTelephone,String sendAddress,UserInfo receiveUserObj,String receiveTelephone,String receiveAddress) throws Exception  { 
     	String where = "where 1=1";
    	if(!wuliuNo.equals("")) where = where + " and t_wuzi.wuliuNo like '%" + wuliuNo + "%'";
    	if(null != wuziClassObj && wuziClassObj.getWuziClassId()!= null && wuziClassObj.getWuziClassId()!= 0)  where += " and t_wuzi.wuziClassObj=" + wuziClassObj.getWuziClassId();
    	if(!wuziName.equals("")) where = where + " and t_wuzi.wuziName like '%" + wuziName + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_wuzi.userObj='" + userObj.getUser_name() + "'";
    	if(!sendTelephone.equals("")) where = where + " and t_wuzi.sendTelephone like '%" + sendTelephone + "%'";
    	if(!sendAddress.equals("")) where = where + " and t_wuzi.sendAddress like '%" + sendAddress + "%'";
    	if(null != receiveUserObj &&  receiveUserObj.getUser_name() != null && !receiveUserObj.getUser_name().equals(""))  where += " and t_wuzi.receiveUserObj='" + receiveUserObj.getUser_name() + "'";
    	if(!receiveTelephone.equals("")) where = where + " and t_wuzi.receiveTelephone like '%" + receiveTelephone + "%'";
    	if(!receiveAddress.equals("")) where = where + " and t_wuzi.receiveAddress like '%" + receiveAddress + "%'";
    	return wuziMapper.queryWuziList(where);
    }

    /*查询所有物资记录*/
    public ArrayList<Wuzi> queryAllWuzi()  throws Exception {
        return wuziMapper.queryWuziList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String wuliuNo,WuziClass wuziClassObj,String wuziName,UserInfo userObj,String sendTelephone,String sendAddress,UserInfo receiveUserObj,String receiveTelephone,String receiveAddress) throws Exception {
     	String where = "where 1=1";
    	if(!wuliuNo.equals("")) where = where + " and t_wuzi.wuliuNo like '%" + wuliuNo + "%'";
    	if(null != wuziClassObj && wuziClassObj.getWuziClassId()!= null && wuziClassObj.getWuziClassId()!= 0)  where += " and t_wuzi.wuziClassObj=" + wuziClassObj.getWuziClassId();
    	if(!wuziName.equals("")) where = where + " and t_wuzi.wuziName like '%" + wuziName + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_wuzi.userObj='" + userObj.getUser_name() + "'";
    	if(!sendTelephone.equals("")) where = where + " and t_wuzi.sendTelephone like '%" + sendTelephone + "%'";
    	if(!sendAddress.equals("")) where = where + " and t_wuzi.sendAddress like '%" + sendAddress + "%'";
    	if(null != receiveUserObj &&  receiveUserObj.getUser_name() != null && !receiveUserObj.getUser_name().equals(""))  where += " and t_wuzi.receiveUserObj='" + receiveUserObj.getUser_name() + "'";
    	if(!receiveTelephone.equals("")) where = where + " and t_wuzi.receiveTelephone like '%" + receiveTelephone + "%'";
    	if(!receiveAddress.equals("")) where = where + " and t_wuzi.receiveAddress like '%" + receiveAddress + "%'";
        recordNumber = wuziMapper.queryWuziCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取物资记录*/
    public Wuzi getWuzi(String wuliuNo) throws Exception  {
        Wuzi wuzi = wuziMapper.getWuzi(wuliuNo);
        return wuzi;
    }

    /*更新物资记录*/
    public void updateWuzi(Wuzi wuzi) throws Exception {
        wuziMapper.updateWuzi(wuzi);
    }

    /*删除一条物资记录*/
    public void deleteWuzi (String wuliuNo) throws Exception {
        wuziMapper.deleteWuzi(wuliuNo);
    }

    /*删除多条物资信息*/
    public int deleteWuzis (String wuliuNos) throws Exception {
    	String _wuliuNos[] = wuliuNos.split(",");
    	for(String _wuliuNo: _wuliuNos) {
    		wuziMapper.deleteWuzi(_wuliuNo);
    	}
    	return _wuliuNos.length;
    }
}
