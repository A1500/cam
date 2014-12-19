package com.inspur.cams.drel.mbalance.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamMedicalConConfig
 * @description:一站结算_医保系统连接配置bean
 * @author:路国隋
 * @since:2011-09-27
 * @version:1.0
 */
@Table(tableName = "sam_medical_con_config" , keyFields={"CON_AREA","CON_TYPE"})
public class SamMedicalConConfig extends StatefulDatabean {
	//连接区域
	@Column(name = "CON_AREA")
	@Rule(value="require")
	private String conArea;
	//连接区域名称
	@Column(name = "CON_AREA_NAME")
	@Rule(value="require")
	private String conAreaName;
	//单位ID
	@Column(name = "ORGAN_ID")
	private String organId;
	//连接类型
	@Rule(value="require")
	@Column(name = "CON_TYPE")
	private String conType;
	//连接方式
	@Column(name = "CON_MOD")
	private String conMod;

	//URL
	@Column(name = "CON_URL")
	private String conUrl;
	//WSDL命名空间
	@Column(name= "DEFAULT_NAMESPACE")
	private String defaultNamespace;
	//端口
	@Column(name = "CON_PORT")
	private String conPort;
	//用户名
	@Column(name = "CON_USER")
	private String conUser;
	//密码
	@Column(name = "CON_PWD")
	private String conPwd;

	//soapAction
	@Column(name = "SOAP_ACTION")
	private String soapAction;
	/**
	 * getter for 单位ID
	 * @generated
	 */
	public String getOrganId(){
		return this.organId;
	}
	/**
	 * setter for 单位ID
	 * @generated
	 */
	public void setOrganId(String organId){
		this.organId = organId;
	}

	/**
	 * getter for 连接类型
	 * @generated
	 */
	public String getConType(){
		return this.conType;
	}
	/**
	 * setter for 连接类型
	 * @generated
	 */
	public void setConType(String conType){
		this.conType = conType;
	}

	/**
	 * getter for 连接方式
	 * @generated
	 */
	public String getConMod(){
		return this.conMod;
	}
	/**
	 * setter for 连接方式
	 * @generated
	 */
	public void setConMod(String conMod){
		this.conMod = conMod;
	}

	/**
	 * getter for 连接区域
	 * @generated
	 */
	public String getConArea(){
		return this.conArea;
	}
	/**
	 * setter for 连接区域
	 * @generated
	 */
	public void setConArea(String conArea){
		this.conArea = conArea;
	}

	/**
	 * getter for URL
	 * @generated
	 */
	public String getConUrl(){
		return this.conUrl;
	}
	/**
	 * setter for URL
	 * @generated
	 */
	public void setConUrl(String conUrl){
		this.conUrl = conUrl;
	}

	/**
	 * getter for 端口
	 * @generated
	 */
	public String getConPort(){
		return this.conPort;
	}
	/**
	 * setter for 端口
	 * @generated
	 */
	public void setConPort(String conPort){
		this.conPort = conPort;
	}

	/**
	 * getter for 用户名
	 * @generated
	 */
	public String getConUser(){
		return this.conUser;
	}
	/**
	 * setter for 用户名
	 * @generated
	 */
	public void setConUser(String conUser){
		this.conUser = conUser;
	}

	/**
	 * getter for 密码
	 * @generated
	 */
	public String getConPwd(){
		return this.conPwd;
	}
	/**
	 * setter for 密码
	 * @generated
	 */
	public void setConPwd(String conPwd){
		this.conPwd = conPwd;
	}
	public String getDefaultNamespace() {
		return defaultNamespace;
	}
	public void setDefaultNamespace(String defaultNamespace) {
		this.defaultNamespace = defaultNamespace;
	}
	/**
	 * @return the soapAction
	 */
	public String getSoapAction() {
		return soapAction;
	}
	/**
	 * @param soapAction the soapAction to set
	 */
	public void setSoapAction(String soapAction) {
		this.soapAction = soapAction;
	}
	/**
	 * @return the conAreaName
	 */
	public String getConAreaName() {
		return conAreaName;
	}
	/**
	 * @param conAreaName the conAreaName to set
	 */
	public void setConAreaName(String conAreaName) {
		this.conAreaName = conAreaName;
	}

}