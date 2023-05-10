package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Ruku;

public interface RukuMapper {
	/*添加入库信息*/
	public void addRuku(Ruku ruku) throws Exception;

	/*按照查询条件分页查询入库记录*/
	public ArrayList<Ruku> queryRuku(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有入库记录*/
	public ArrayList<Ruku> queryRukuList(@Param("where") String where) throws Exception;

	/*按照查询条件的入库记录数*/
	public int queryRukuCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条入库记录*/
	public Ruku getRuku(int rukuId) throws Exception;

	/*更新入库记录*/
	public void updateRuku(Ruku ruku) throws Exception;

	/*删除入库记录*/
	public void deleteRuku(int rukuId) throws Exception;

}
