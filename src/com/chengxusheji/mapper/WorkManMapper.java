package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.WorkMan;

public interface WorkManMapper {
	/*添加工作人员信息*/
	public void addWorkMan(WorkMan workMan) throws Exception;

	/*按照查询条件分页查询工作人员记录*/
	public ArrayList<WorkMan> queryWorkMan(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有工作人员记录*/
	public ArrayList<WorkMan> queryWorkManList(@Param("where") String where) throws Exception;

	/*按照查询条件的工作人员记录数*/
	public int queryWorkManCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条工作人员记录*/
	public WorkMan getWorkMan(String workUserName) throws Exception;

	/*更新工作人员记录*/
	public void updateWorkMan(WorkMan workMan) throws Exception;

	/*删除工作人员记录*/
	public void deleteWorkMan(String workUserName) throws Exception;

}
