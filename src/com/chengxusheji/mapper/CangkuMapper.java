package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Cangku;

public interface CangkuMapper {
	/*添加仓库信息*/
	public void addCangku(Cangku cangku) throws Exception;

	/*按照查询条件分页查询仓库记录*/
	public ArrayList<Cangku> queryCangku(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有仓库记录*/
	public ArrayList<Cangku> queryCangkuList(@Param("where") String where) throws Exception;

	/*按照查询条件的仓库记录数*/
	public int queryCangkuCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条仓库记录*/
	public Cangku getCangku(int cangkuId) throws Exception;

	/*更新仓库记录*/
	public void updateCangku(Cangku cangku) throws Exception;

	/*删除仓库记录*/
	public void deleteCangku(int cangkuId) throws Exception;

}
