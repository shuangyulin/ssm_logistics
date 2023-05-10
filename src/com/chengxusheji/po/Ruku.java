package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Ruku {
    /*入库id*/
    private Integer rukuId;
    public Integer getRukuId(){
        return rukuId;
    }
    public void setRukuId(Integer rukuId){
        this.rukuId = rukuId;
    }

    /*入库物资*/
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

    /*入库仓库*/
    private Cangku cangkuObj;
    public Cangku getCangkuObj() {
        return cangkuObj;
    }
    public void setCangkuObj(Cangku cangkuObj) {
        this.cangkuObj = cangkuObj;
    }

    /*入库时间*/
    @NotEmpty(message="入库时间不能为空")
    private String rukuTime;
    public String getRukuTime() {
        return rukuTime;
    }
    public void setRukuTime(String rukuTime) {
        this.rukuTime = rukuTime;
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

    /*入库备注*/
    private String rukuMemo;
    public String getRukuMemo() {
        return rukuMemo;
    }
    public void setRukuMemo(String rukuMemo) {
        this.rukuMemo = rukuMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonRuku=new JSONObject(); 
		jsonRuku.accumulate("rukuId", this.getRukuId());
		jsonRuku.accumulate("wuziObj", this.getWuziObj().getWuziName());
		jsonRuku.accumulate("wuziObjPri", this.getWuziObj().getWuliuNo());
		jsonRuku.accumulate("wuziClassObj", this.getWuziClassObj().getWuziClassName());
		jsonRuku.accumulate("wuziClassObjPri", this.getWuziClassObj().getWuziClassId());
		jsonRuku.accumulate("zhongliang", this.getZhongliang());
		jsonRuku.accumulate("cangkuObj", this.getCangkuObj().getCangkuName());
		jsonRuku.accumulate("cangkuObjPri", this.getCangkuObj().getCangkuId());
		jsonRuku.accumulate("rukuTime", this.getRukuTime().length()>19?this.getRukuTime().substring(0,19):this.getRukuTime());
		jsonRuku.accumulate("okFlag", this.getOkFlag());
		jsonRuku.accumulate("workManObj", this.getWorkManObj().getName());
		jsonRuku.accumulate("workManObjPri", this.getWorkManObj().getWorkUserName());
		jsonRuku.accumulate("rukuMemo", this.getRukuMemo());
		return jsonRuku;
    }}