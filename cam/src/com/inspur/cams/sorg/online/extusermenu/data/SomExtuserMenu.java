package com.inspur.cams.sorg.online.extusermenu.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomExtuserMenu
 * @description:
 * @author:
 * @since:2012-10-31
 * @version:1.0
*/
 @Table(tableName = "SOM_EXTUSER_MENU" , keyFields = "id")
public class SomExtuserMenu extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //USER_ID
	@Column(name = "USER_ID")
   private String userId;
   //可用菜单配置
	@Column(name = "MENU_INFO")
   private String menuInfo;

   private String sorgCode;
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
    * getter for USER_ID
    * @generated
    */
   public String getUserId(){
      return this.userId;
   }
   /**
    * setter for USER_ID
    * @generated
    */
   public void setUserId(String userId){
      this.userId = userId;
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
public String getSorgCode() {
	return sorgCode;
}
public void setSorgCode(String sorgCode) {
	this.sorgCode = sorgCode;
}

}