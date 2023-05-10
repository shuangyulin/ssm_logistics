package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Wuzi;
import com.chengxusheji.po.WuziClass;
import com.chengxusheji.po.Cangku;
import com.chengxusheji.po.WorkMan;
import com.chengxusheji.po.Ruku;

import com.chengxusheji.mapper.RukuMapper;
@Service
public class RukuService {

	@Resource RukuMapper rukuMapper;
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

    /*添加入库记录*/
    public void addRuku(Ruku ruku) throws Exception {
    	rukuMapper.addRuku(ruku);
    }

    /*按照查询条件分页查询入库记录*/
    public ArrayList<Ruku> queryRuku(Wuzi wuziObj,WuziClass wuziClassObj,Cangku cangkuObj,String rukuTime,WorkMan workManObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != wuziObj &&  wuziObj.getWuliuNo() != null  && !wuziObj.getWuliuNo().equals(""))  where += " and t_ruku.wuziObj='" + wuziObj.getWuliuNo() + "'";
    	if(null != wuziClassObj && wuziClassObj.getWuziClassId()!= null && wuziClassObj.getWuziClassId()!= 0)  where += " and t_ruku.wuziClassObj=" + wuziClassObj.getWuziClassId();
    	if(null != cangkuObj && cangkuObj.getCangkuId()!= null && cangkuObj.getCangkuId()!= 0)  where += " and t_ruku.cangkuObj=" + cangkuObj.getCangkuId();
    	if(!rukuTime.equals("")) where = where + " and t_ruku.rukuTime like '%" + rukuTime + "%'";
    	if(null != workManObj &&  workManObj.getWorkUserName() != null  && !workManObj.getWorkUserName().equals(""))  where += " and t_ruku.workManObj='" + workManObj.getWorkUserName() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return rukuMapper.queryRuku(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Ruku> queryRuku(Wuzi wuziObj,WuziClass wuziClassObj,Cangku cangkuObj,String rukuTime,WorkMan workManObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != wuziObj &&  wuziObj.getWuliuNo() != null && !wuziObj.getWuliuNo().equals(""))  where += " and t_ruku.wuziObj='" + wuziObj.getWuliuNo() + "'";
    	if(null != wuziClassObj && wuziClassObj.getWuziClassId()!= null && wuziClassObj.getWuziClassId()!= 0)  where += " and t_ruku.wuziClassObj=" + wuziClassObj.getWuziClassId();
    	if(null != cangkuObj && cangkuObj.getCangkuId()!= null && cangkuObj.getCangkuId()!= 0)  where += " and t_ruku.cangkuObj=" + cangkuObj.getCangkuId();
    	if(!rukuTime.equals("")) where = where + " and t_ruku.rukuTime like '%" + rukuTime + "%'";
    	if(null != workManObj &&  workManObj.getWorkUserName() != null && !workManObj.getWorkUserName().equals(""))  where += " and t_ruku.workManObj='" + workManObj.getWorkUserName() + "'";
    	return rukuMapper.queryRukuList(where);
    }

    /*查询所有入库记录*/
    public ArrayList<Ruku> queryAllRuku()  throws Exception {
        return rukuMapper.queryRukuList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Wuzi wuziObj,WuziClass wuziClassObj,Cangku cangkuObj,String rukuTime,WorkMan workManObj) throws Exception {
     	String where = "where 1=1";
    	if(null != wuziObj &&  wuziObj.getWuliuNo() != null && !wuziObj.getWuliuNo().equals(""))  where += " and t_ruku.wuziObj='" + wuziObj.getWuliuNo() + "'";
    	if(null != wuziClassObj && wuziClassObj.getWuziClassId()!= null && wuziClassObj.getWuziClassId()!= 0)  where += " and t_ruku.wuziClassObj=" + wuziClassObj.getWuziClassId();
    	if(null != cangkuObj && cangkuObj.getCangkuId()!= null && cangkuObj.getCangkuId()!= 0)  where += " and t_ruku.cangkuObj=" + cangkuObj.getCangkuId();
    	if(!rukuTime.equals("")) where = where + " and t_ruku.rukuTime like '%" + rukuTime + "%'";
    	if(null != workManObj &&  workManObj.getWorkUserName() != null && !workManObj.getWorkUserName().equals(""))  where += " and t_ruku.workManObj='" + workManObj.getWorkUserName() + "'";
        recordNumber = rukuMapper.queryRukuCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取入库记录*/
    public Ruku getRuku(int rukuId) throws Exception  {
        Ruku ruku = rukuMapper.getRuku(rukuId);
        return ruku;
    }

    /*更新入库记录*/
    public void updateRuku(Ruku ruku) throws Exception {
        rukuMapper.updateRuku(ruku);
    }

    /*删除一条入库记录*/
    public void deleteRuku (int rukuId) throws Exception {
        rukuMapper.deleteRuku(rukuId);
    }

    /*删除多条入库信息*/
    public int deleteRukus (String rukuIds) throws Exception {
    	String _rukuIds[] = rukuIds.split(",");
    	for(String _rukuId: _rukuIds) {
    		rukuMapper.deleteRuku(Integer.parseInt(_rukuId));
    	}
    	return _rukuIds.length;
    }
}
