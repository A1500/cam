package com.inspur.cams.marry.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:MrmBulu
 * @description:
 * @author:
 * @since:2012-02-23
 * @version:1.0
*/
 @Table(tableName = "MRM_BULU" , keyFields = "deptCode")
public class MrmBulu extends StatefulDatabean {
   //登记机关代码
   	@Rule(value="require")
	@Column(name = "DEPT_CODE")
   private String deptCode;
   //补录至年份
   	@Rule(value="date{yyyy-MM-dd}")
	@Column(name = "EARLIEST")
   private String earliest;
   //补录数量
   	@Rule(value="number")
	@Column(name = "AMOUNT")
   private BigDecimal amount;
   /**
    * getter for 登记机关代码
    * @generated
    */
   public String getDeptCode(){
      return this.deptCode;
   }
   /**
    * setter for 登记机关代码
    * @generated
    */
   public void setDeptCode(String deptCode){
      this.deptCode = deptCode;
   }

   /**
    * getter for 补录至年份
    * @generated
    */
   public String getEarliest(){
      return this.earliest;
   }
   /**
    * setter for 补录至年份
    * @generated
    */
   public void setEarliest(String earliest){
      this.earliest = earliest;
   }

   /**
    * getter for 补录数量
    * @generated
    */
   public BigDecimal getAmount(){
      return this.amount;
   }
   /**
    * setter for 补录数量
    * @generated
    */
   public void setAmount(BigDecimal amount){
      this.amount = amount;
   }

}