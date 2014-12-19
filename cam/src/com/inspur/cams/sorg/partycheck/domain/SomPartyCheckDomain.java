package com.inspur.cams.sorg.partycheck.domain;

import java.math.BigDecimal;
import java.util.*;
import java.sql.*;

import org.loushang.next.data.*;
//import org.loushang.util.Page;
//import org.loushang.util.RowSelection;
import org.osoa.sca.annotations.*;
import  com.inspur.cams.sorg.partycheck.data.*;
import  com.inspur.cams.sorg.partycheck.dao.*;
/**
 * @title:SomPartyCheckDomain
 * @description:
 * @author:
 * @since:2013-04-26
 * @version:1.0
*/
 public class SomPartyCheckDomain implements ISomPartyCheckDomain {

	private ISomPartyCheckDao sompartycheckDao;
	

	@Reference
	public void setSomPartyCheckDao(ISomPartyCheckDao sompartycheckDao) {
		this.sompartycheckDao = sompartycheckDao;
	}

	public void saveSomPartyCheck(List<SomPartyCheck> list) {
		this.sompartycheckDao.save(list);

	}

	public void delete(List<String> list) {
		String[] sompartycheckIds = list.toArray(new String[list.size()]);
		if (list != null && !list.isEmpty()) {
			this.sompartycheckDao.batchDelete(sompartycheckIds);
		}
	}

	public DataSet querySomPartyCheck(ParameterSet pset) {
		return sompartycheckDao.query(pset);
	}






}