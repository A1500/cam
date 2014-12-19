package com.inspur.cams.bpt.dicobjecttype.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:DicObjecttype
 * @description:
 * @author:
 * @since:2011-08-16
 * @version:1.0
*/
 @Table(tableName = "DIC_BPT_OBJECTTYPE" , keyFields = "typeId")
public class DicObjecttype extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "TYPE_ID")
   private String typeId;
   //优抚对象名称
	@Column(name = "TYPE_NAME")
   private String typeName;
   //本节点编码
	@Column(name = "TYPE_ORGAN_ID")
   private String typeOrganId;
   //父节点内码
	@Column(name = "TYPE_PARENT_ID")
   private String typeParentId;
   //排序顺序
   	@Rule(value="number")
	@Column(name = "TYPE_ORDER")
   private BigDecimal typeOrder;
   /**
    * getter for ID
    * @generated
    */
   public String getTypeId(){
      return this.typeId;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setTypeId(String typeId){
      this.typeId = typeId;
   }

   /**
    * getter for 优抚对象名称
    * @generated
    */
   public String getTypeName(){
      return this.typeName;
   }
   /**
    * setter for 优抚对象名称
    * @generated
    */
   public void setTypeName(String typeName){
      this.typeName = typeName;
   }

   /**
    * getter for 本节点编码
    * @generated
    */
   public String getTypeOrganId(){
      return this.typeOrganId;
   }
   /**
    * setter for 本节点编码
    * @generated
    */
   public void setTypeOrganId(String typeOrganId){
      this.typeOrganId = typeOrganId;
   }

   /**
    * getter for 父节点内码
    * @generated
    */
   public String getTypeParentId(){
      return this.typeParentId;
   }
   /**
    * setter for 父节点内码
    * @generated
    */
   public void setTypeParentId(String typeParentId){
      this.typeParentId = typeParentId;
   }

   /**
    * getter for 排序顺序
    * @generated
    */
   public BigDecimal getTypeOrder(){
      return this.typeOrder;
   }
   /**
    * setter for 排序顺序
    * @generated
    */
   public void setTypeOrder(BigDecimal typeOrder){
      this.typeOrder = typeOrder;
   }

}