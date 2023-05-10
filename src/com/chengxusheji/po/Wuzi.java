package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Wuzi {
    /*物流单号*/
    @NotEmpty(message="物流单号不能为空")
    private String wuliuNo;
    public String getWuliuNo(){
        return wuliuNo;
    }
    public void setWuliuNo(String wuliuNo){
        this.wuliuNo = wuliuNo;
    }

    /*物资分类*/
    private WuziClass wuziClassObj;
    public WuziClass getWuziClassObj() {
        return wuziClassObj;
    }
    public void setWuziClassObj(WuziClass wuziClassObj) {
        this.wuziClassObj = wuziClassObj;
    }

    /*物资名称*/
    @NotEmpty(message="物资名称不能为空")
    private String wuziName;
    public String getWuziName() {
        return wuziName;
    }
    public void setWuziName(String wuziName) {
        this.wuziName = wuziName;
    }

    /*物资重量*/
    @NotEmpty(message="物资重量不能为空")
    private String zhongliang;
    public String getZhongliang() {
        return zhongliang;
    }
    public void setZhongliang(String zhongliang) {
        this.zhongliang = zhongliang;
    }

    /*物资详情*/
    @NotEmpty(message="物资详情不能为空")
    private String wuziDesc;
    public String getWuziDesc() {
        return wuziDesc;
    }
    public void setWuziDesc(String wuziDesc) {
        this.wuziDesc = wuziDesc;
    }

    /*寄件人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*寄件人电话*/
    @NotEmpty(message="寄件人电话不能为空")
    private String sendTelephone;
    public String getSendTelephone() {
        return sendTelephone;
    }
    public void setSendTelephone(String sendTelephone) {
        this.sendTelephone = sendTelephone;
    }

    /*寄件人地址*/
    @NotEmpty(message="寄件人地址不能为空")
    private String sendAddress;
    public String getSendAddress() {
        return sendAddress;
    }
    public void setSendAddress(String sendAddress) {
        this.sendAddress = sendAddress;
    }

    /*收件人*/
    private UserInfo receiveUserObj;
    public UserInfo getReceiveUserObj() {
        return receiveUserObj;
    }
    public void setReceiveUserObj(UserInfo receiveUserObj) {
        this.receiveUserObj = receiveUserObj;
    }

    /*收件人电话*/
    @NotEmpty(message="收件人电话不能为空")
    private String receiveTelephone;
    public String getReceiveTelephone() {
        return receiveTelephone;
    }
    public void setReceiveTelephone(String receiveTelephone) {
        this.receiveTelephone = receiveTelephone;
    }

    /*收件人地址*/
    @NotEmpty(message="收件人地址不能为空")
    private String receiveAddress;
    public String getReceiveAddress() {
        return receiveAddress;
    }
    public void setReceiveAddress(String receiveAddress) {
        this.receiveAddress = receiveAddress;
    }

    /*运费*/
    @NotNull(message="必须输入运费")
    private Float yunfei;
    public Float getYunfei() {
        return yunfei;
    }
    public void setYunfei(Float yunfei) {
        this.yunfei = yunfei;
    }

    /*物流动态*/
    @NotEmpty(message="物流动态不能为空")
    private String wldt;
    public String getWldt() {
        return wldt;
    }
    public void setWldt(String wldt) {
        this.wldt = wldt;
    }

    /*备注信息*/
    private String wuziMemo;
    public String getWuziMemo() {
        return wuziMemo;
    }
    public void setWuziMemo(String wuziMemo) {
        this.wuziMemo = wuziMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonWuzi=new JSONObject(); 
		jsonWuzi.accumulate("wuliuNo", this.getWuliuNo());
		jsonWuzi.accumulate("wuziClassObj", this.getWuziClassObj().getWuziClassName());
		jsonWuzi.accumulate("wuziClassObjPri", this.getWuziClassObj().getWuziClassId());
		jsonWuzi.accumulate("wuziName", this.getWuziName());
		jsonWuzi.accumulate("zhongliang", this.getZhongliang());
		jsonWuzi.accumulate("wuziDesc", this.getWuziDesc());
		jsonWuzi.accumulate("userObj", this.getUserObj().getName());
		jsonWuzi.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonWuzi.accumulate("sendTelephone", this.getSendTelephone());
		jsonWuzi.accumulate("sendAddress", this.getSendAddress());
		jsonWuzi.accumulate("receiveUserObj", this.getReceiveUserObj().getName());
		jsonWuzi.accumulate("receiveUserObjPri", this.getReceiveUserObj().getUser_name());
		jsonWuzi.accumulate("receiveTelephone", this.getReceiveTelephone());
		jsonWuzi.accumulate("receiveAddress", this.getReceiveAddress());
		jsonWuzi.accumulate("yunfei", this.getYunfei());
		jsonWuzi.accumulate("wldt", this.getWldt());
		jsonWuzi.accumulate("wuziMemo", this.getWuziMemo());
		return jsonWuzi;
    }}