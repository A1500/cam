package com.inspur.cams.comm.subsys.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.sca.transaction.Trans;

/**
 * @title:ComSubsysConfig
 * @description:
 * @author:
 * @since:2012-01-17
 * @version:1.0
 */
@Table(tableName = "COM_SUBSYS_CONFIG" , keyFields = "sysId")
public class ComSubsysConfig extends StatefulDatabean {
	//系统编号
	@Rule(value="require")
	@Column(name = "SYS_ID")
	private String sysId;
	//系统名称
	@Rule(value="require")
	@Column(name = "SYS_NAME")
	private String sysName;
	//系统菜单
	@Rule(value="require")
	@Column(name = "SYS_MENU_TYPE")
	private String sysMenuType;
	//系统图标
	@Rule(value="require")
	@Column(name = "SYS_ICO")
	private String sysIco;
	//系统图标
	@Column(name = "SYS_ICO_DISABLE")
	private String sysIcoDisable;
	//系统简称
	@Rule(value="require")
	@Column(name = "SHORT_NAME")
	private String shortName;
	//顶部图片
	@Column(name = "TOP_PIC")
	private String topPic;
	//背景图片
	@Column(name = "MAIN_PIC")
	private String mainPic;	
	//排序字段
	@Rule(value="require")
	@Column(name = "ORDER_NUM")
	private String orderNum;
	//排序字段
	@Rule(value="require")
	@Column(name = "SHOW_FLG")
	private String showFlg;
	//版本号左偏移量
	@Rule(value="require")
	@Column(name = "VER_MARGIN")
	private String verMargin;
	@Transient
	private String grantedRoles;
	
	//是否直接跳转到具体菜单
	private String ifJumpMain;
	
	
	public String getIfJumpMain() {
		return ifJumpMain;
	}
	public void setIfJumpMain(String ifJumpMain) {
		this.ifJumpMain = ifJumpMain;
	}
	/**
	 * getter for 系统编号
	 * @generated
	 */
	public String getSysId(){
		return this.sysId;
	}
	/**
	 * setter for 系统编号
	 * @generated
	 */
	public void setSysId(String sysId){
		this.sysId = sysId;
	}

	/**
	 * getter for 系统名称
	 * @generated
	 */
	public String getSysName(){
		return this.sysName;
	}
	/**
	 * setter for 系统名称
	 * @generated
	 */
	public void setSysName(String sysName){
		this.sysName = sysName;
	}

	/**
	 * getter for 系统菜单
	 * @generated
	 */
	public String getSysMenuType(){
		return this.sysMenuType;
	}
	/**
	 * setter for 系统菜单
	 * @generated
	 */
	public void setSysMenuType(String sysMenuType){
		this.sysMenuType = sysMenuType;
	}

	/**
	 * getter for 系统图标
	 * @generated
	 */
	public String getSysIco(){
		return this.sysIco;
	}
	/**
	 * setter for 系统图标
	 * @generated
	 */
	public void setSysIco(String sysIco){
		this.sysIco = sysIco;
	}

	/**
	 * getter for 系统简称
	 * @generated
	 */
	public String getShortName(){
		return this.shortName;
	}
	/**
	 * setter for 系统简称
	 * @generated
	 */
	public void setShortName(String shortName){
		this.shortName = shortName;
	}

	/**
	 * getter for 顶部图片
	 * @generated
	 */
	public String getTopPic(){
		return this.topPic;
	}
	/**
	 * setter for 顶部图片
	 * @generated
	 */
	public void setTopPic(String topPic){
		this.topPic = topPic;
	}

	/**
	 * getter for 背景图片
	 * @generated
	 */
	public String getMainPic(){
		return this.mainPic;
	}
	/**
	 * setter for 背景图片
	 * @generated
	 */
	public void setMainPic(String mainPic){
		this.mainPic = mainPic;
	}
	/**
	 * @return the grantedRoles
	 */
	public String getGrantedRoles() {
		return grantedRoles;
	}
	/**
	 * @param grantedRoles the grantedRoles to set
	 */
	public void setGrantedRoles(String grantedRoles) {
		this.grantedRoles = grantedRoles;
	}
	/**
	 * @return the orderNum
	 */
	public String getOrderNum() {
		return orderNum;
	}
	/**
	 * @param orderNum the orderNum to set
	 */
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	/**
	 * @return the sysIcoDisable
	 */
	public String getSysIcoDisable() {
		return sysIcoDisable;
	}
	/**
	 * @param sysIcoDisable the sysIcoDisable to set
	 */
	public void setSysIcoDisable(String sysIcoDisable) {
		this.sysIcoDisable = sysIcoDisable;
	}
	/**
	 * @return the showFlg
	 */
	public String getShowFlg() {
		return showFlg;
	}
	/**
	 * @param showFlg the showFlg to set
	 */
	public void setShowFlg(String showFlg) {
		this.showFlg = showFlg;
	}
	/**
	 * @return the showFlg
	 */
	public String getVerMargin() {
		return verMargin;
	}
	/**
	 * @param showFlg the showFlg to set
	 */
	public void setVerMargin(String verMargin) {
		this.verMargin = verMargin;
	}

}