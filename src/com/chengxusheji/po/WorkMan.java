package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class WorkMan {
    /*工作人员账号*/
    @NotEmpty(message="工作人员账号不能为空")
    private String workUserName;
    public String getWorkUserName(){
        return workUserName;
    }
    public void setWorkUserName(String workUserName){
        this.workUserName = workUserName;
    }

    /*登录密码*/
    @NotEmpty(message="登录密码不能为空")
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String gender;
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String birthDate;
    public String getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    /*工作人员照片*/
    private String workManPhoto;
    public String getWorkManPhoto() {
        return workManPhoto;
    }
    public void setWorkManPhoto(String workManPhoto) {
        this.workManPhoto = workManPhoto;
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

    /*家庭地址*/
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*备注信息*/
    private String workManMemo;
    public String getWorkManMemo() {
        return workManMemo;
    }
    public void setWorkManMemo(String workManMemo) {
        this.workManMemo = workManMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonWorkMan=new JSONObject(); 
		jsonWorkMan.accumulate("workUserName", this.getWorkUserName());
		jsonWorkMan.accumulate("password", this.getPassword());
		jsonWorkMan.accumulate("name", this.getName());
		jsonWorkMan.accumulate("gender", this.getGender());
		jsonWorkMan.accumulate("birthDate", this.getBirthDate().length()>19?this.getBirthDate().substring(0,19):this.getBirthDate());
		jsonWorkMan.accumulate("workManPhoto", this.getWorkManPhoto());
		jsonWorkMan.accumulate("telephone", this.getTelephone());
		jsonWorkMan.accumulate("address", this.getAddress());
		jsonWorkMan.accumulate("workManMemo", this.getWorkManMemo());
		return jsonWorkMan;
    }}