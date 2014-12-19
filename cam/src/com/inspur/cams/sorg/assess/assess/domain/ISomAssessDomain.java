package com.inspur.cams.sorg.assess.assess.domain;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

/**
 * @title:ISomAssessTypeDomain
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 public interface ISomAssessDomain {
	 
   @Trans
   
   public DataSet querySomAssess(ParameterSet pset);
   @Trans
   public void delete(List<String> list);
   @Trans
   public void batchDelete(String[] delIds) ;
   
   @Trans
   public void saveScore(Map<Object,Object> map);
   
   @Trans
   public void updateScore(Map<Object,Object> map);

 }