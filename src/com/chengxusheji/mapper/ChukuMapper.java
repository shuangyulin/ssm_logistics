package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Chuku;

public interface ChukuMapper {
	/*添加出库信息*/
	public void addChuku(Chuku chuku) throws Exception;

	/*按照查询条件分页查询出库记录*/
	public ArrayList<Chuku> queryChuku(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有出库记录*/
	public ArrayList<Chuku> queryChukuList(@Param("where") String where) throws Exception;

	/*按照查询条件的出库记录数*/
	public int queryChukuCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条出库记录*/
	public Chuku getChuku(int chukuId) throws Exception;

	/*更新出库记录*/
	public void updateChuku(Chuku chuku) throws Exception;

	/*删除出库记录*/
	public void deleteChuku(int chukuId) throws Exception;

}
