package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Wuzi;

public interface WuziMapper {
	/*添加物资信息*/
	public void addWuzi(Wuzi wuzi) throws Exception;

	/*按照查询条件分页查询物资记录*/
	public ArrayList<Wuzi> queryWuzi(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有物资记录*/
	public ArrayList<Wuzi> queryWuziList(@Param("where") String where) throws Exception;

	/*按照查询条件的物资记录数*/
	public int queryWuziCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条物资记录*/
	public Wuzi getWuzi(String wuliuNo) throws Exception;

	/*更新物资记录*/
	public void updateWuzi(Wuzi wuzi) throws Exception;

	/*删除物资记录*/
	public void deleteWuzi(String wuliuNo) throws Exception;

}
