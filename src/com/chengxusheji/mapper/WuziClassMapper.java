package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.WuziClass;

public interface WuziClassMapper {
	/*添加物资种类信息*/
	public void addWuziClass(WuziClass wuziClass) throws Exception;

	/*按照查询条件分页查询物资种类记录*/
	public ArrayList<WuziClass> queryWuziClass(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有物资种类记录*/
	public ArrayList<WuziClass> queryWuziClassList(@Param("where") String where) throws Exception;

	/*按照查询条件的物资种类记录数*/
	public int queryWuziClassCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条物资种类记录*/
	public WuziClass getWuziClass(int wuziClassId) throws Exception;

	/*更新物资种类记录*/
	public void updateWuziClass(WuziClass wuziClass) throws Exception;

	/*删除物资种类记录*/
	public void deleteWuziClass(int wuziClassId) throws Exception;

}
