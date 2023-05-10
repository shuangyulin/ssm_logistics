package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.WorkMan;

import com.chengxusheji.mapper.WorkManMapper;
@Service
public class WorkManService {

	@Resource WorkManMapper workManMapper;
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

    /*添加工作人员记录*/
    public void addWorkMan(WorkMan workMan) throws Exception {
    	workManMapper.addWorkMan(workMan);
    }

    /*按照查询条件分页查询工作人员记录*/
    public ArrayList<WorkMan> queryWorkMan(String workUserName,String name,String birthDate,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!workUserName.equals("")) where = where + " and t_workMan.workUserName like '%" + workUserName + "%'";
    	if(!name.equals("")) where = where + " and t_workMan.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_workMan.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_workMan.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return workManMapper.queryWorkMan(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<WorkMan> queryWorkMan(String workUserName,String name,String birthDate,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(!workUserName.equals("")) where = where + " and t_workMan.workUserName like '%" + workUserName + "%'";
    	if(!name.equals("")) where = where + " and t_workMan.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_workMan.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_workMan.telephone like '%" + telephone + "%'";
    	return workManMapper.queryWorkManList(where);
    }

    /*查询所有工作人员记录*/
    public ArrayList<WorkMan> queryAllWorkMan()  throws Exception {
        return workManMapper.queryWorkManList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String workUserName,String name,String birthDate,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(!workUserName.equals("")) where = where + " and t_workMan.workUserName like '%" + workUserName + "%'";
    	if(!name.equals("")) where = where + " and t_workMan.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_workMan.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_workMan.telephone like '%" + telephone + "%'";
        recordNumber = workManMapper.queryWorkManCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取工作人员记录*/
    public WorkMan getWorkMan(String workUserName) throws Exception  {
        WorkMan workMan = workManMapper.getWorkMan(workUserName);
        return workMan;
    }

    /*更新工作人员记录*/
    public void updateWorkMan(WorkMan workMan) throws Exception {
        workManMapper.updateWorkMan(workMan);
    }

    /*删除一条工作人员记录*/
    public void deleteWorkMan (String workUserName) throws Exception {
        workManMapper.deleteWorkMan(workUserName);
    }

    /*删除多条工作人员信息*/
    public int deleteWorkMans (String workUserNames) throws Exception {
    	String _workUserNames[] = workUserNames.split(",");
    	for(String _workUserName: _workUserNames) {
    		workManMapper.deleteWorkMan(_workUserName);
    	}
    	return _workUserNames.length;
    }
}
