package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Cangku {
    /*仓库id*/
    private Integer cangkuId;
    public Integer getCangkuId(){
        return cangkuId;
    }
    public void setCangkuId(Integer cangkuId){
        this.cangkuId = cangkuId;
    }

    /*所在地区*/
    @NotEmpty(message="所在地区不能为空")
    private String diqu;
    public String getDiqu() {
        return diqu;
    }
    public void setDiqu(String diqu) {
        this.diqu = diqu;
    }

    /*仓库名称*/
    @NotEmpty(message="仓库名称不能为空")
    private String cangkuName;
    public String getCangkuName() {
        return cangkuName;
    }
    public void setCangkuName(String cangkuName) {
        this.cangkuName = cangkuName;
    }

    /*仓库面积*/
    @NotEmpty(message="仓库面积不能为空")
    private String mianji;
    public String getMianji() {
        return mianji;
    }
    public void setMianji(String mianji) {
        this.mianji = mianji;
    }

    /*仓库吞吐量*/
    @NotEmpty(message="仓库吞吐量不能为空")
    private String tdl;
    public String getTdl() {
        return tdl;
    }
    public void setTdl(String tdl) {
        this.tdl = tdl;
    }

    /*联系人*/
    @NotEmpty(message="联系人不能为空")
    private String lianxiren;
    public String getLianxiren() {
        return lianxiren;
    }
    public void setLianxiren(String lianxiren) {
        this.lianxiren = lianxiren;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*仓库地址*/
    @NotEmpty(message="仓库地址不能为空")
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*仓库备注*/
    private String cangkuMemo;
    public String getCangkuMemo() {
        return cangkuMemo;
    }
    public void setCangkuMemo(String cangkuMemo) {
        this.cangkuMemo = cangkuMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonCangku=new JSONObject(); 
		jsonCangku.accumulate("cangkuId", this.getCangkuId());
		jsonCangku.accumulate("diqu", this.getDiqu());
		jsonCangku.accumulate("cangkuName", this.getCangkuName());
		jsonCangku.accumulate("mianji", this.getMianji());
		jsonCangku.accumulate("tdl", this.getTdl());
		jsonCangku.accumulate("lianxiren", this.getLianxiren());
		jsonCangku.accumulate("telephone", this.getTelephone());
		jsonCangku.accumulate("address", this.getAddress());
		jsonCangku.accumulate("cangkuMemo", this.getCangkuMemo());
		return jsonCangku;
    }}