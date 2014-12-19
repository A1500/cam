package com.inspur.cams.sorg.assess.assessscore.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomAssessScore
 * @description:
 * @author:
 * @since:2011-12-09
 * @version:1.0
*/
 @Table(tableName = "SOM_ASSESS_SCORE" , keyFields = "id")
public class SomAssessScore extends StatefulDatabean {
   //主键
	@Column(name = "ID")
   private String id;
   //业务编号
	@Column(name = "TASK_CODE")
   private String taskCode;
   //配置表ID
	@Column(name = "CONFIG_ID")
   private String configId;
   //评估类型
	@Column(name = "ASSESS_TYPE")
   private String assessType;
   //评估分数
	@Column(name = "ASSESS_MAKE_SCORE")
   private String assessMakeScore;
   //评估说明
	@Column(name = "ASSESS_DESC")
   private String assessDesc;
   /**
    * getter for 主键
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for 主键
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for 业务编号
    * @generated
    */
   public String getTaskCode(){
      return this.taskCode;
   }
   /**
    * setter for 业务编号
    * @generated
    */
   public void setTaskCode(String taskCode){
      this.taskCode = taskCode;
   }

   /**
    * getter for 配置表ID
    * @generated
    */
   public String getConfigId(){
      return this.configId;
   }
   /**
    * setter for 配置表ID
    * @generated
    */
   public void setConfigId(String configId){
      this.configId = configId;
   }

   /**
    * getter for 评估类型
    * @generated
    */
   public String getAssessType(){
      return this.assessType;
   }
   /**
    * setter for 评估类型
    * @generated
    */
   public void setAssessType(String assessType){
      this.assessType = assessType;
   }

   /**
    * getter for 评估说明
    * @generated
    */
   public String getAssessDesc(){
      return this.assessDesc;
   }
   /**
    * setter for 评估说明
    * @generated
    */
   public void setAssessDesc(String assessDesc){
      this.assessDesc = assessDesc;
   }
public String getAssessMakeScore() {
	return assessMakeScore;
}
public void setAssessMakeScore(String assessMakeScore) {
	this.assessMakeScore = assessMakeScore;
}

}