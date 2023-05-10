package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Cangku;

import com.chengxusheji.mapper.CangkuMapper;
@Service
public class CangkuService {

	@Resource CangkuMapper cangkuMapper;
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

    /*添加仓库记录*/
    public void addCangku(Cangku cangku) throws Exception {
    	cangkuMapper.addCangku(cangku);
    }

    /*按照查询条件分页查询仓库记录*/
    public ArrayList<Cangku> queryCangku(String diqu,String cangkuName,String lianxiren,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!diqu.equals("")) where = where + " and t_cangku.diqu like '%" + diqu + "%'";
    	if(!cangkuName.equals("")) where = where + " and t_cangku.cangkuName like '%" + cangkuName + "%'";
    	if(!lianxiren.equals("")) where = where + " and t_cangku.lianxiren like '%" + lianxiren + "%'";
    	if(!telephone.equals("")) where = where + " and t_cangku.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return cangkuMapper.queryCangku(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Cangku> queryCangku(String diqu,String cangkuName,String lianxiren,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(!diqu.equals("")) where = where + " and t_cangku.diqu like '%" + diqu + "%'";
    	if(!cangkuName.equals("")) where = where + " and t_cangku.cangkuName like '%" + cangkuName + "%'";
    	if(!lianxiren.equals("")) where = where + " and t_cangku.lianxiren like '%" + lianxiren + "%'";
    	if(!telephone.equals("")) where = where + " and t_cangku.telephone like '%" + telephone + "%'";
    	return cangkuMapper.queryCangkuList(where);
    }

    /*查询所有仓库记录*/
    public ArrayList<Cangku> queryAllCangku()  throws Exception {
        return cangkuMapper.queryCangkuList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String diqu,String cangkuName,String lianxiren,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(!diqu.equals("")) where = where + " and t_cangku.diqu like '%" + diqu + "%'";
    	if(!cangkuName.equals("")) where = where + " and t_cangku.cangkuName like '%" + cangkuName + "%'";
    	if(!lianxiren.equals("")) where = where + " and t_cangku.lianxiren like '%" + lianxiren + "%'";
    	if(!telephone.equals("")) where = where + " and t_cangku.telephone like '%" + telephone + "%'";
        recordNumber = cangkuMapper.queryCangkuCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取仓库记录*/
    public Cangku getCangku(int cangkuId) throws Exception  {
        Cangku cangku = cangkuMapper.getCangku(cangkuId);
        return cangku;
    }

    /*更新仓库记录*/
    public void updateCangku(Cangku cangku) throws Exception {
        cangkuMapper.updateCangku(cangku);
    }

    /*删除一条仓库记录*/
    public void deleteCangku (int cangkuId) throws Exception {
        cangkuMapper.deleteCangku(cangkuId);
    }

    /*删除多条仓库信息*/
    public int deleteCangkus (String cangkuIds) throws Exception {
    	String _cangkuIds[] = cangkuIds.split(",");
    	for(String _cangkuId: _cangkuIds) {
    		cangkuMapper.deleteCangku(Integer.parseInt(_cangkuId));
    	}
    	return _cangkuIds.length;
    }
}
