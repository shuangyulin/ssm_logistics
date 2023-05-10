package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Wuzi;
import com.chengxusheji.po.WuziClass;
import com.chengxusheji.po.Cangku;
import com.chengxusheji.po.WorkMan;
import com.chengxusheji.po.Chuku;

import com.chengxusheji.mapper.ChukuMapper;
@Service
public class ChukuService {

	@Resource ChukuMapper chukuMapper;
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

    /*添加出库记录*/
    public void addChuku(Chuku chuku) throws Exception {
    	chukuMapper.addChuku(chuku);
    }

    /*按照查询条件分页查询出库记录*/
    public ArrayList<Chuku> queryChuku(Wuzi wuziObj,WuziClass wuziClassObj,Cangku cangkuObj,String chukuTime,WorkMan workManObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != wuziObj &&  wuziObj.getWuliuNo() != null  && !wuziObj.getWuliuNo().equals(""))  where += " and t_chuku.wuziObj='" + wuziObj.getWuliuNo() + "'";
    	if(null != wuziClassObj && wuziClassObj.getWuziClassId()!= null && wuziClassObj.getWuziClassId()!= 0)  where += " and t_chuku.wuziClassObj=" + wuziClassObj.getWuziClassId();
    	if(null != cangkuObj && cangkuObj.getCangkuId()!= null && cangkuObj.getCangkuId()!= 0)  where += " and t_chuku.cangkuObj=" + cangkuObj.getCangkuId();
    	if(!chukuTime.equals("")) where = where + " and t_chuku.chukuTime like '%" + chukuTime + "%'";
    	if(null != workManObj &&  workManObj.getWorkUserName() != null  && !workManObj.getWorkUserName().equals(""))  where += " and t_chuku.workManObj='" + workManObj.getWorkUserName() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return chukuMapper.queryChuku(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Chuku> queryChuku(Wuzi wuziObj,WuziClass wuziClassObj,Cangku cangkuObj,String chukuTime,WorkMan workManObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != wuziObj &&  wuziObj.getWuliuNo() != null && !wuziObj.getWuliuNo().equals(""))  where += " and t_chuku.wuziObj='" + wuziObj.getWuliuNo() + "'";
    	if(null != wuziClassObj && wuziClassObj.getWuziClassId()!= null && wuziClassObj.getWuziClassId()!= 0)  where += " and t_chuku.wuziClassObj=" + wuziClassObj.getWuziClassId();
    	if(null != cangkuObj && cangkuObj.getCangkuId()!= null && cangkuObj.getCangkuId()!= 0)  where += " and t_chuku.cangkuObj=" + cangkuObj.getCangkuId();
    	if(!chukuTime.equals("")) where = where + " and t_chuku.chukuTime like '%" + chukuTime + "%'";
    	if(null != workManObj &&  workManObj.getWorkUserName() != null && !workManObj.getWorkUserName().equals(""))  where += " and t_chuku.workManObj='" + workManObj.getWorkUserName() + "'";
    	return chukuMapper.queryChukuList(where);
    }

    /*查询所有出库记录*/
    public ArrayList<Chuku> queryAllChuku()  throws Exception {
        return chukuMapper.queryChukuList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Wuzi wuziObj,WuziClass wuziClassObj,Cangku cangkuObj,String chukuTime,WorkMan workManObj) throws Exception {
     	String where = "where 1=1";
    	if(null != wuziObj &&  wuziObj.getWuliuNo() != null && !wuziObj.getWuliuNo().equals(""))  where += " and t_chuku.wuziObj='" + wuziObj.getWuliuNo() + "'";
    	if(null != wuziClassObj && wuziClassObj.getWuziClassId()!= null && wuziClassObj.getWuziClassId()!= 0)  where += " and t_chuku.wuziClassObj=" + wuziClassObj.getWuziClassId();
    	if(null != cangkuObj && cangkuObj.getCangkuId()!= null && cangkuObj.getCangkuId()!= 0)  where += " and t_chuku.cangkuObj=" + cangkuObj.getCangkuId();
    	if(!chukuTime.equals("")) where = where + " and t_chuku.chukuTime like '%" + chukuTime + "%'";
    	if(null != workManObj &&  workManObj.getWorkUserName() != null && !workManObj.getWorkUserName().equals(""))  where += " and t_chuku.workManObj='" + workManObj.getWorkUserName() + "'";
        recordNumber = chukuMapper.queryChukuCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取出库记录*/
    public Chuku getChuku(int chukuId) throws Exception  {
        Chuku chuku = chukuMapper.getChuku(chukuId);
        return chuku;
    }

    /*更新出库记录*/
    public void updateChuku(Chuku chuku) throws Exception {
        chukuMapper.updateChuku(chuku);
    }

    /*删除一条出库记录*/
    public void deleteChuku (int chukuId) throws Exception {
        chukuMapper.deleteChuku(chukuId);
    }

    /*删除多条出库信息*/
    public int deleteChukus (String chukuIds) throws Exception {
    	String _chukuIds[] = chukuIds.split(",");
    	for(String _chukuId: _chukuIds) {
    		chukuMapper.deleteChuku(Integer.parseInt(_chukuId));
    	}
    	return _chukuIds.length;
    }
}
