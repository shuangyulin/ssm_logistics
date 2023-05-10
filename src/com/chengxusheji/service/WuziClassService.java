package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.WuziClass;

import com.chengxusheji.mapper.WuziClassMapper;
@Service
public class WuziClassService {

	@Resource WuziClassMapper wuziClassMapper;
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

    /*添加物资种类记录*/
    public void addWuziClass(WuziClass wuziClass) throws Exception {
    	wuziClassMapper.addWuziClass(wuziClass);
    }

    /*按照查询条件分页查询物资种类记录*/
    public ArrayList<WuziClass> queryWuziClass(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return wuziClassMapper.queryWuziClass(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<WuziClass> queryWuziClass() throws Exception  { 
     	String where = "where 1=1";
    	return wuziClassMapper.queryWuziClassList(where);
    }

    /*查询所有物资种类记录*/
    public ArrayList<WuziClass> queryAllWuziClass()  throws Exception {
        return wuziClassMapper.queryWuziClassList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = wuziClassMapper.queryWuziClassCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取物资种类记录*/
    public WuziClass getWuziClass(int wuziClassId) throws Exception  {
        WuziClass wuziClass = wuziClassMapper.getWuziClass(wuziClassId);
        return wuziClass;
    }

    /*更新物资种类记录*/
    public void updateWuziClass(WuziClass wuziClass) throws Exception {
        wuziClassMapper.updateWuziClass(wuziClass);
    }

    /*删除一条物资种类记录*/
    public void deleteWuziClass (int wuziClassId) throws Exception {
        wuziClassMapper.deleteWuziClass(wuziClassId);
    }

    /*删除多条物资种类信息*/
    public int deleteWuziClasss (String wuziClassIds) throws Exception {
    	String _wuziClassIds[] = wuziClassIds.split(",");
    	for(String _wuziClassId: _wuziClassIds) {
    		wuziClassMapper.deleteWuziClass(Integer.parseInt(_wuziClassId));
    	}
    	return _wuziClassIds.length;
    }
}
