package com.inspur.cams.sorg.assess.assesstype.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.assess.assesstype.dao.SomAssessType;

/**
 * @title:ISomAssessTypeDomain
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 public interface ISomAssessTypeDomain {
	 
   @Trans
   public void saveSomAssessType(List<SomAssessType> list);
   
   public DataSet querySomAssessType(ParameterSet pset);
   @Trans
   public void delete(List<String> list);
   @Trans
   public void insert(SomAssessType somassesstype) ;
   @Trans
   public void update(SomAssessType somassesstype) ;
   @Trans
   public void batchDelete(String[] delIds) ;
   @Trans
   public void save(List<SomAssessType> list) ;

 }