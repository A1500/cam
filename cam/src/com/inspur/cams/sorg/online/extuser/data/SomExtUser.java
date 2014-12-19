package com.inspur.cams.sorg.online.extuser.data;

import com.inspur.cams.comm.extuser.data.ComExtUser;

/**
 * @title:SomExtuserMenu
 * @description:
 * @author:
 * @since:2012-10-31
 * @version:1.0
*/
public class SomExtUser{

   private ComExtUser comExtUser;
   //ID
   private String id;
   //USER_ID
   private String userId;
   //可用菜单配置
   private String menuInfo;

   private String sorgCode;
   public String getSorgCode() {
	return sorgCode;
}
public void setSorgCode(String sorgCode) {
	this.sorgCode = sorgCode;
}
/**
    * getter for ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for 可用菜单配置
    * @generated
    */
   public String getMenuInfo(){
      return this.menuInfo;
   }
   /**
    * setter for 可用菜单配置
    * @generated
    */
   public void setMenuInfo(String menuInfo){
      this.menuInfo = menuInfo;
   }
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public ComExtUser getComExtUser() {
		return comExtUser;
	}
	public void setComExtUser(ComExtUser comExtUser) {
		this.comExtUser = comExtUser;
	}


}