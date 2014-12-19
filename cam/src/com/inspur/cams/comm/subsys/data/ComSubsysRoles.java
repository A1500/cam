package com.inspur.cams.comm.subsys.data; 

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:ComSubsysRoles
 * @description:
 * @author:
 * @since:2012-01-17
 * @version:1.0
*/
 @Table(tableName = "COM_SUBSYS_ROLES" , keyFields = "sysId")
public class ComSubsysRoles extends StatefulDatabean {	
   //系统编号
   	@Rule(value="require")   
	@Column(name = "SYS_ID")
   private String sysId;   
   //角色
   	@Rule(value="require")   
	@Column(name = "ROLE_ID")
   private String roleId;
   	@Transient
   	private String roleName;      
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
    * getter for 角色
    * @generated
    */
   public String getRoleId(){
      return this.roleId;
   }   
   /** 
    * setter for 角色
    * @generated
    */
   public void setRoleId(String roleId){
      this.roleId = roleId;	
   }
/**
 * @return the roleName
 */
public String getRoleName() {
	return roleName;
}
/**
 * @param roleName the roleName to set
 */
public void setRoleName(String roleName) {
	this.roleName = roleName;
}  
      
}