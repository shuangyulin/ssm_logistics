package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Chuku {
    /*出库id*/
    private Integer chukuId;
    public Integer getChukuId(){
        return chukuId;
    }
    public void setChukuId(Integer chukuId){
        this.chukuId = chukuId;
    }

    /*出库物资*/
    private Wuzi wuziObj;
    public Wuzi getWuziObj() {
        return wuziObj;
    }
    public void setWuziObj(Wuzi wuziObj) {
        this.wuziObj = wuziObj;
    }

    /*物资种类*/
    private WuziClass wuziClassObj;
    public WuziClass getWuziClassObj() {
        return wuziClassObj;
    }
    public void setWuziClassObj(WuziClass wuziClassObj) {
        this.wuziClassObj = wuziClassObj;
    }

    /*重量*/
    @NotEmpty(message="重量不能为空")
    private String zhongliang;
    public String getZhongliang() {
        return zhongliang;
    }
    public void setZhongliang(String zhongliang) {
        this.zhongliang = zhongliang;
    }

    /*出库仓库*/
    private Cangku cangkuObj;
    public Cangku getCangkuObj() {
        return cangkuObj;
    }
    public void setCangkuObj(Cangku cangkuObj) {
        this.cangkuObj = cangkuObj;
    }

    /*出库时间*/
    @NotEmpty(message="出库时间不能为空")
    private String chukuTime;
    public String getChukuTime() {
        return chukuTime;
    }
    public void setChukuTime(String chukuTime) {
        this.chukuTime = chukuTime;
    }

    /*是否完好*/
    @NotEmpty(message="是否完好不能为空")
    private String okFlag;
    public String getOkFlag() {
        return okFlag;
    }
    public void setOkFlag(String okFlag) {
        this.okFlag = okFlag;
    }

    /*工作人员*/
    private WorkMan workManObj;
    public WorkMan getWorkManObj() {
        return workManObj;
    }
    public void setWorkManObj(WorkMan workManObj) {
        this.workManObj = workManObj;
    }

    /*出库备注*/
    private String chukuMemo;
    public String getChukuMemo() {
        return chukuMemo;
    }
    public void setChukuMemo(String chukuMemo) {
        this.chukuMemo = chukuMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonChuku=new JSONObject(); 
		jsonChuku.accumulate("chukuId", this.getChukuId());
		jsonChuku.accumulate("wuziObj", this.getWuziObj().getWuziName());
		jsonChuku.accumulate("wuziObjPri", this.getWuziObj().getWuliuNo());
		jsonChuku.accumulate("wuziClassObj", this.getWuziClassObj().getWuziClassName());
		jsonChuku.accumulate("wuziClassObjPri", this.getWuziClassObj().getWuziClassId());
		jsonChuku.accumulate("zhongliang", this.getZhongliang());
		jsonChuku.accumulate("cangkuObj", this.getCangkuObj().getCangkuName());
		jsonChuku.accumulate("cangkuObjPri", this.getCangkuObj().getCangkuId());
		jsonChuku.accumulate("chukuTime", this.getChukuTime().length()>19?this.getChukuTime().substring(0,19):this.getChukuTime());
		jsonChuku.accumulate("okFlag", this.getOkFlag());
		jsonChuku.accumulate("workManObj", this.getWorkManObj().getName());
		jsonChuku.accumulate("workManObjPri", this.getWorkManObj().getWorkUserName());
		jsonChuku.accumulate("chukuMemo", this.getChukuMemo());
		return jsonChuku;
    }}