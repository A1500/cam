package com.inspur.cams.bpt.dicdisabilitylevel.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:DicDisabilityLevel
 * @description:
 * @author:
 * @since:2011-11-03
 * @version:1.0
*/
 @Table(tableName = "DIC_DISABILITY_LEVEL" , keyFields = "code")
public class DicDisabilityLevel extends StatefulDatabean {
   //等级编号
   	@Rule(value="require")
	@Column(name = "CODE")
   private String code;
   //名称
   	@Rule(value="require")
	@Column(name = "NAME")
   private String name;
   //本节点编码
	@Column(name = "ORGAN_ID")
   private String organId;
   //父节点编码
	@Column(name = "PARENT_ID")
   private String parentId;
   //排序顺序
   	@Rule(value="number")
	@Column(name = "SORT_ORDER")
   private BigDecimal sortOrder;
   //编号
   	@Rule(value="number")
	@Column(name = "LEVEL_ID")
   private String levelId;
   /**
    * getter for 等级编号
    * @generated
    */
   public String getCode(){
      return this.code;
   }
   /**
    * setter for 等级编号
    * @generated
    */
   public void setCode(String code){
      this.code = code;
   }

   /**
    * getter for 名称
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 名称
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for 本节点编码
    * @generated
    */
   public String getOrganId(){
      return this.organId;
   }
   /**
    * setter for 本节点编码
    * @generated
    */
   public void setOrganId(String organId){
      this.organId = organId;
   }

   /**
    * getter for 父节点编码
    * @generated
    */
   public String getParentId(){
      return this.parentId;
   }
   /**
    * setter for 父节点编码
    * @generated
    */
   public void setParentId(String parentId){
      this.parentId = parentId;
   }

   /**
    * getter for 排序顺序
    * @generated
    */
   public BigDecimal getSortOrder(){
      return this.sortOrder;
   }
   /**
    * setter for 排序顺序
    * @generated
    */
   public void setSortOrder(BigDecimal sortOrder){
      this.sortOrder = sortOrder;
   }

   /**
    * getter for 编号
    * @generated
    */
   public String getLevelId(){
      return this.levelId;
   }
   /**
    * setter for 编号
    * @generated
    */
   public void setLevelId(String childId){
      this.levelId = childId;
   }

}