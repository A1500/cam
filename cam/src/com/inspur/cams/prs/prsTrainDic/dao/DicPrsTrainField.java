package com.inspur.cams.prs.prsTrainDic.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:DicPrsTrainField
 * @description:
 * @author:
 * @since:2012-09-21
 * @version:1.0
*/
 @Table(tableName = "DIC_PRS_TRAIN_FIELD" , keyFields = "code")
public class DicPrsTrainField extends StatefulDatabean {
   //主键编码
   	@Rule(value="require")
	@Column(name = "CODE")
   private String code;
   //专业名称
   	@Rule(value="require")
	@Column(name = "NAME")
   private String name;
   //使用状态
   	@Rule(value="require")
	@Column(name = "EFFECTIVE")
   private String effective;
   //地市编码
   	@Rule(value="require")
	@Column(name = "CITYID")
   private String cityid;
   /**
    * getter for 主键编码
    * @generated
    */
   public String getCode(){
      return this.code;
   }
   /**
    * setter for 主键编码
    * @generated
    */
   public void setCode(String code){
      this.code = code;
   }

   /**
    * getter for 专业名称
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 专业名称
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for 使用状态
    * @generated
    */
   public String getEffective(){
      return this.effective;
   }
   /**
    * setter for 使用状态
    * @generated
    */
   public void setEffective(String effective){
      this.effective = effective;
   }

   /**
    * getter for 地市编码
    * @generated
    */
   public String getCityid(){
      return this.cityid;
   }
   /**
    * setter for 地市编码
    * @generated
    */
   public void setCityid(String cityid){
      this.cityid = cityid;
   }

}