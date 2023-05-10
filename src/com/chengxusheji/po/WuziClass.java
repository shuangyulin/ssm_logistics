package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class WuziClass {
    /*物资种类id*/
    private Integer wuziClassId;
    public Integer getWuziClassId(){
        return wuziClassId;
    }
    public void setWuziClassId(Integer wuziClassId){
        this.wuziClassId = wuziClassId;
    }

    /*物资种类名称*/
    @NotEmpty(message="物资种类名称不能为空")
    private String wuziClassName;
    public String getWuziClassName() {
        return wuziClassName;
    }
    public void setWuziClassName(String wuziClassName) {
        this.wuziClassName = wuziClassName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonWuziClass=new JSONObject(); 
		jsonWuziClass.accumulate("wuziClassId", this.getWuziClassId());
		jsonWuziClass.accumulate("wuziClassName", this.getWuziClassName());
		return jsonWuziClass;
    }}