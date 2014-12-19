package com.inspur.cams.fis.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @Path com.inspur.cams.fis.base.data.FisResourceRule  
 * @Description: TODO 殡葬业务资源级别规则定义表
 * @author wangziming
 * @date 2011-11-16
 */
 @Table(tableName = "fis_resource_rule" , keyFields = "ruleId")
public class FisResourceRule extends StatefulDatabean {
   //规则内码
	@Column(name = "rule_Id")
   private String ruleId;
   //上级编号
	@Column(name = "parent_Level")
   private String parentLevel;
   //下级编号
	@Column(name = "children_Level")
   private String childrenLevel;
	@Transient
	private String childrenName;
	@Transient
	private String parentName;
	@Transient
	private String resourceType;
	@Transient
	private String typeName;
	
	public String getResourceType() {
		return resourceType;
	}
	public void setResourceType(String resourceType) {
		this.resourceType = resourceType;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
public String getChildrenName() {
		return childrenName;
	}
	public void setChildrenName(String childrenName) {
		this.childrenName = childrenName;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
/**
    * getter for 规则内码
    * @generated
    */
   public String getRuleId(){
      return this.ruleId;
   }
   /**
    * setter for 规则内码
    * @generated
    */
   public void setRuleId(String ruleId){
      this.ruleId = ruleId;
   }

   /**
    * getter for 上级编号
    * @generated
    */
   public String getParentLevel(){
      return this.parentLevel;
   }
   /**
    * setter for 上级编号
    * @generated
    */
   public void setParentLevel(String parentLevel){
      this.parentLevel = parentLevel;
   }

   /**
    * getter for 下级编号
    * @generated
    */
   public String getChildrenLevel(){
      return this.childrenLevel;
   }
   /**
    * setter for 下级编号
    * @generated
    */
   public void setChildrenLevel(String childrenLevel){
      this.childrenLevel = childrenLevel;
   }

}