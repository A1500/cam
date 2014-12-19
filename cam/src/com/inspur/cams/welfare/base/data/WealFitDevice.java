package com.inspur.cams.welfare.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:WealFitDevice
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 @Table(tableName = "WEAL_FIT_DEVICE" , keyFields = "deviceId")
public class WealFitDevice extends StatefulDatabean {
   //DEVICE_ID
   	@Rule(value="require")
	@Column(name = "DEVICE_ID")
   private String deviceId;
   //TASK_CODE
   	@Rule(value="require")
	@Column(name = "TASK_CODE")
   private String taskCode;
   //DEVICE_CODE
   	@Rule(value="require")
	@Column(name = "DEVICE_CODE")
   private String deviceCode;
   //DEVICE_NAME
	@Column(name = "DEVICE_NAME")
   private String deviceName;
   //DEVICE_NUM
   	@Rule(value="number")
	@Column(name = "DEVICE_NUM")
   private BigDecimal deviceNum;
   /**
    * getter for DEVICE_ID
    * @generated
    */
   public String getDeviceId(){
      return this.deviceId;
   }
   /**
    * setter for DEVICE_ID
    * @generated
    */
   public void setDeviceId(String deviceId){
      this.deviceId = deviceId;
   }

   /**
    * getter for TASK_CODE
    * @generated
    */
   public String getTaskCode(){
      return this.taskCode;
   }
   /**
    * setter for TASK_CODE
    * @generated
    */
   public void setTaskCode(String taskCode){
      this.taskCode = taskCode;
   }

   /**
    * getter for DEVICE_CODE
    * @generated
    */
   public String getDeviceCode(){
      return this.deviceCode;
   }
   /**
    * setter for DEVICE_CODE
    * @generated
    */
   public void setDeviceCode(String deviceCode){
      this.deviceCode = deviceCode;
   }

   /**
    * getter for DEVICE_NAME
    * @generated
    */
   public String getDeviceName(){
      return this.deviceName;
   }
   /**
    * setter for DEVICE_NAME
    * @generated
    */
   public void setDeviceName(String deviceName){
      this.deviceName = deviceName;
   }

   /**
    * getter for DEVICE_NUM
    * @generated
    */
   public BigDecimal getDeviceNum(){
      return this.deviceNum;
   }
   /**
    * setter for DEVICE_NUM
    * @generated
    */
   public void setDeviceNum(BigDecimal deviceNum){
      this.deviceNum = deviceNum;
   }

}