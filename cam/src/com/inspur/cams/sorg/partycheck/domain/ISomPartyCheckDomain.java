package com.inspur.cams.sorg.partycheck.domain;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.sql.*;

import org.loushang.next.data.*;
import  com.inspur.cams.sorg.partycheck.data.*;


/**
 * @title:ISomPartyCheckDomain
 * @description:
 * @author:
 * @since:2013-04-26
 * @version:1.0
*/
 public interface ISomPartyCheckDomain {

   public void saveSomPartyCheck(List<SomPartyCheck> list);
   

	public DataSet querySomPartyCheck(ParameterSet pset);


	public void delete(List<String> list);

 }